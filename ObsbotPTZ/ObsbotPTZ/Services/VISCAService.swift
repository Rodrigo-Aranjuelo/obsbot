import Foundation
import Network

enum VISCAServiceError: LocalizedError {
    case invalidIPAddress
    case invalidPort
    case notConnected
    case sendFailed

    var errorDescription: String? {
        switch self {
        case .invalidIPAddress:
            return "Invalid camera IP address"
        case .invalidPort:
            return "Invalid VISCA port"
        case .notConnected:
            return "VISCA service is not connected"
        case .sendFailed:
            return "Failed to send VISCA packet"
        }
    }
}

protocol VISCAServiceProtocol {
    func connect(to camera: CameraDevice) async throws
    func sendPanTilt(_ direction: PTZDirection, speed: UInt8) async throws
    func sendZoom(_ command: ZoomCommand, speed: UInt8) async throws
    func recallPreset(slot: UInt8) async throws
    func savePreset(slot: UInt8) async throws
    func disconnect()
}

final class VISCAService: VISCAServiceProtocol {
    private var currentCamera: CameraDevice?
    private var connection: NWConnection?
    private let queue = DispatchQueue(label: "visca.service.queue")

    func connect(to camera: CameraDevice) async throws {
        guard IPv4Address(camera.ip) != nil else {
            throw VISCAServiceError.invalidIPAddress
        }
        guard camera.viscaPort > 0 else {
            throw VISCAServiceError.invalidPort
        }

        disconnect()

        let host = NWEndpoint.Host(camera.ip)
        let port = NWEndpoint.Port(rawValue: camera.viscaPort)
        guard let port else { throw VISCAServiceError.invalidPort }

        let params = NWParameters.udp
        let conn = NWConnection(host: host, port: port, using: params)
        conn.stateUpdateHandler = { state in
            print("[VISCA] state=\(state)")
        }
        conn.start(queue: queue)

        currentCamera = camera
        connection = conn
    }

    func sendPanTilt(_ direction: PTZDirection, speed: UInt8) async throws {
        try ensureConnected()

        let pan = clamp(speed, min: 0x01, max: 0x18)
        let tilt = clamp(speed, min: 0x01, max: 0x14)

        // VISCA Pan/Tilt Drive: 81 01 06 01 VV WW XX YY FF
        let directionBytes: (UInt8, UInt8)
        switch direction {
        case .up: directionBytes = (0x03, 0x01)
        case .down: directionBytes = (0x03, 0x02)
        case .left: directionBytes = (0x01, 0x03)
        case .right: directionBytes = (0x02, 0x03)
        case .upLeft: directionBytes = (0x01, 0x01)
        case .upRight: directionBytes = (0x02, 0x01)
        case .downLeft: directionBytes = (0x01, 0x02)
        case .downRight: directionBytes = (0x02, 0x02)
        case .stop: directionBytes = (0x03, 0x03)
        }

        let packet: [UInt8] = [0x81, 0x01, 0x06, 0x01, pan, tilt, directionBytes.0, directionBytes.1, 0xFF]
        try await send(packet)
    }

    func sendZoom(_ command: ZoomCommand, speed: UInt8) async throws {
        try ensureConnected()

        let spd = clamp(speed, min: 0x00, max: 0x07)

        // VISCA Zoom: 81 01 04 07 2p FF (tele), 3p (wide), 00 stop
        let code: UInt8
        switch command {
        case .zoomIn:
            code = 0x20 | spd
        case .zoomOut:
            code = 0x30 | spd
        case .stop:
            code = 0x00
        }

        let packet: [UInt8] = [0x81, 0x01, 0x04, 0x07, code, 0xFF]
        try await send(packet)
    }

    func recallPreset(slot: UInt8) async throws {
        try ensureConnected()
        let p = clamp(slot, min: 0x00, max: 0xFE)
        // VISCA Memory Recall: 81 01 04 3F 02 pp FF
        let packet: [UInt8] = [0x81, 0x01, 0x04, 0x3F, 0x02, p, 0xFF]
        try await send(packet)
    }

    func savePreset(slot: UInt8) async throws {
        try ensureConnected()
        let p = clamp(slot, min: 0x00, max: 0xFE)
        // VISCA Memory Set: 81 01 04 3F 01 pp FF
        let packet: [UInt8] = [0x81, 0x01, 0x04, 0x3F, 0x01, p, 0xFF]
        try await send(packet)
    }

    func disconnect() {
        connection?.cancel()
        connection = nil
        currentCamera = nil
    }

    private func ensureConnected() throws {
        guard connection != nil, currentCamera != nil else {
            throw VISCAServiceError.notConnected
        }
    }

    private func send(_ bytes: [UInt8]) async throws {
        guard let connection else {
            throw VISCAServiceError.notConnected
        }

        let data = Data(bytes)
        try await withCheckedThrowingContinuation { continuation in
            connection.send(content: data, completion: .contentProcessed { error in
                if let error {
                    print("[VISCA] send error: \(error.localizedDescription)")
                    continuation.resume(throwing: VISCAServiceError.sendFailed)
                } else {
                    continuation.resume()
                }
            })
        }
    }

    private func clamp(_ value: UInt8, min: UInt8, max: UInt8) -> UInt8 {
        Swift.min(Swift.max(value, min), max)
    }
}

import Foundation

@MainActor
final class CameraViewModel: ObservableObject {
    @Published var camera: CameraDevice
    @Published var statusText: String = "Disconnected"

    private let viscaService: VISCAServiceProtocol

    init(camera: CameraDevice = .tailAir2Demo, viscaService: VISCAServiceProtocol = VISCAService()) {
        self.camera = camera
        self.viscaService = viscaService
    }

    func connect() {
        Task {
            do {
                try await viscaService.connect(to: camera)
                camera.isConnected = true
                statusText = "Connected to \(camera.ip):\(camera.viscaPort)"
            } catch {
                camera.isConnected = false
                statusText = "Connection failed: \(error.localizedDescription)"
            }
        }
    }

    func disconnect() {
        viscaService.disconnect()
        camera.isConnected = false
        statusText = "Disconnected"
    }

    func sendPanTilt(_ direction: PTZDirection, speed: UInt8 = 10) {
        Task {
            do {
                try await viscaService.sendPanTilt(direction, speed: speed)
            } catch {
                statusText = "PTZ error: \(error.localizedDescription)"
            }
        }
    }

    func sendZoom(_ command: ZoomCommand, speed: UInt8 = 3) {
        Task {
            do {
                try await viscaService.sendZoom(command, speed: speed)
            } catch {
                statusText = "Zoom error: \(error.localizedDescription)"
            }
        }
    }

    func recallPreset(slot: UInt8) {
        Task {
            do {
                try await viscaService.recallPreset(slot: slot)
            } catch {
                statusText = "Preset error: \(error.localizedDescription)"
            }
        }
    }

    func savePreset(slot: UInt8) {
        Task {
            do {
                try await viscaService.savePreset(slot: slot)
            } catch {
                statusText = "Save preset error: \(error.localizedDescription)"
            }
        }
    }
}

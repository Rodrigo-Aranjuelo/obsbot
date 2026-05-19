import Foundation

struct CameraDevice: Identifiable, Equatable {
    let id: UUID
    var name: String
    var ip: String
    var viscaPort: UInt16
    var rtspURL: URL
    var codec: String
    var isConnected: Bool

    static let tailAir2Demo = CameraDevice(
        id: UUID(),
        name: "Tail Air 2 - CAM1",
        ip: "192.168.1.9",
        viscaPort: 52381,
        rtspURL: URL(string: "rtsp://192.168.1.9/stream1")!,
        codec: "H265",
        isConnected: false
    )
}

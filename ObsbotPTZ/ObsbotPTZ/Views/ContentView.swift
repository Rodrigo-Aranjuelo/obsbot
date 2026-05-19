import SwiftUI

struct ContentView: View {
    @StateObject private var vm = CameraViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Text(vm.camera.name)
                    .font(.headline)
                Text(vm.statusText)
                    .font(.subheadline)
                    .foregroundColor(vm.camera.isConnected ? .green : .secondary)

                HStack(spacing: 12) {
                    Button("Connect") { vm.connect() }
                        .buttonStyle(.borderedProminent)
                    Button("Disconnect") { vm.disconnect() }
                        .buttonStyle(.bordered)
                }

                VStack(spacing: 12) {
                    Button("↑") { vm.sendPanTilt(.up) }
                    HStack(spacing: 12) {
                        Button("←") { vm.sendPanTilt(.left) }
                        Button("Stop") { vm.sendPanTilt(.stop) }
                        Button("→") { vm.sendPanTilt(.right) }
                    }
                    Button("↓") { vm.sendPanTilt(.down) }
                }
                .buttonStyle(.bordered)

                HStack(spacing: 12) {
                    Button("Zoom +") { vm.sendZoom(.zoomIn) }
                    Button("Zoom -") { vm.sendZoom(.zoomOut) }
                    Button("Zoom Stop") { vm.sendZoom(.stop) }
                }
                .buttonStyle(.bordered)

                HStack(spacing: 8) {
                    ForEach(1..<4) { slot in
                        Button("Preset \(slot)") { vm.recallPreset(slot: UInt8(slot)) }
                    }
                }

                Spacer()
            }
            .padding()
            .navigationTitle("OBSBOT PTZ")
        }
    }
}

#Preview {
    ContentView()
}

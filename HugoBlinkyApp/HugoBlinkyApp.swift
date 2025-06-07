import SwiftUI
import CoreBluetooth

@main
struct HugoBlinkyApp: App {
    @StateObject private var bleManager = BLEManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(bleManager)
        }
    }
}

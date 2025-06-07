import SwiftUI

struct ContentView: View {
    @EnvironmentObject var bleManager: BLEManager

    var body: some View {
        VStack {
            Text(bleManager.isConnected ? "Connected" : "Disconnected")
                .padding()
            Button(action: {
                bleManager.toggleLED()
            }) {
                Text(bleManager.ledOn ? "Turn Off" : "Turn On")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(!bleManager.isConnected)
        }
        .onAppear {
            bleManager.startScanning()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(BLEManager())
    }
}

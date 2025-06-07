# HugoBlinky iOS Example

This sample project shows how to connect to an nRF52830 BLE device named **Hugo_Blinky** and control its LED. The app scans for the device, connects automatically, and provides a button to toggle the LED on and off.

## Running the App
1. Open Xcode on macOS and create a new **App** project using SwiftUI.
2. Replace the generated source files with the contents of the `HugoBlinkyApp` folder in this repository.
3. Add `Info.plist` from `HugoBlinkyApp` to your Xcode project and ensure it contains the Bluetooth usage description.
4. Build and run on a real iOS device (e.g., iPhone 16 Pro). The app will start scanning as soon as it launches.

The BLE service and characteristic UUIDs are set to `FFE0` and `FFE1`. Update them if your device uses different values.

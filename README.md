# Northwestern Phone Dialer

Northwestern Phone Dialer is a lightweight SwiftUI app that converts five-digit Northwestern Memorial Hospital extensions into full telephone numbers and launches the system dialer in one tap.

## Features
- Maps hospital extensions to the appropriate 5-digit prefix automatically.
- Filters non-numeric characters and constrains input to five digits.
- Displays the formatted 10-digit number as you type.
- Triggers the native phone app when you press the dial button.

## Getting Started
1. Open `NorthwesternPhoneDialer.xcodeproj` in Xcode 15 or newer.
2. Select the `NorthwesternPhoneDialer` scheme and a target device (an iPhone simulator or physical device).
3. Press `⌘R` to build and run.
4. Enter a five-digit hospital extension to see the full number and tap the green phone button to place a call. (Dialing requires a physical device.)

## Requirements
- Xcode 15+
- iOS 16 deployment target

## Project Structure
```
Northwestern-Phone-Dialer/
├── NorthwesternPhoneDialer/        # App sources and resources
│   ├── ContentView.swift           # SwiftUI interface and dialing logic
│   ├── NorthwesternPhoneDialerApp.swift # App entry point
│   ├── Assets.xcassets/            # Accent color and app icon placeholders
│   └── Info.plist                  # Bundle and scene configuration
├── NorthwesternPhoneDialer.xcodeproj/ # Xcode project definition
├── README.md                       # Project overview
└── PRIVACY.md                      # Generic privacy policy
```

## License
This project is provided as-is for internal use. Update the license section if you plan to distribute it publicly.

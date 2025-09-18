import SwiftUI
import UIKit

struct ContentView: View {
    // Tracks the five-digit extension typed by the user
    @State private var fiveDigitInput: String = ""

    // Determines the correct 5-digit prefix based on the first digit of the user's input.
    private var numberPrefix: String? {
        guard let firstChar = fiveDigitInput.first else {
            return nil
        }

        switch firstChar {
        case "6":
            return "31292"
        case "5":
            return "31269"
        case "2":
            return "31247"
        case "3":
            return "31250"
        case "4":
            return "31269"
        default:
            return nil
        }
    }

    /// Constructs the full 10-digit phone number once the input is complete.
    private var fullPhoneNumber: String? {
        guard let prefix = numberPrefix, fiveDigitInput.count == 5 else {
            return nil
        }
        return prefix + fiveDigitInput
    }

    /// Formats the number for display (e.g., "(312) 921-2345").
    private var formattedDisplayNumber: String {
        let paddedInput = fiveDigitInput.padding(toLength: 5, withPad: "_", startingAt: 0)

        guard let prefix = numberPrefix else {
            return "(XXX)XXX-XXXX"
        }

        let fullNumber = prefix + paddedInput
        let areaCode = String(fullNumber.prefix(3))
        let exchange = String(fullNumber.dropFirst(3).prefix(3))
        let lineNumber = String(fullNumber.suffix(4))
        return "(\(areaCode))\(exchange)-\(lineNumber)"
    }

    /// Determines if the dial button should be enabled.
    private var isDialButtonEnabled: Bool {
        fullPhoneNumber != nil
    }

    var body: some View {
        ZStack {
            Color(red: 0.35, green: 0.2, blue: 0.55)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer()

                Text(formattedDisplayNumber)
                    .font(.system(size: 40, weight: .bold, design: .monospaced))
                    .foregroundStyle(.white)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .padding(.horizontal)

                Text("Please type your five digit Northwestern Memorial extension here.")
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)

                TextField("", text: $fiveDigitInput)
                    .font(.system(size: 44, weight: .bold, design: .monospaced))
                    .foregroundColor(.white)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal, 50)
                    .onChange(of: fiveDigitInput) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered.count > 5 {
                            fiveDigitInput = String(filtered.prefix(5))
                        } else {
                            fiveDigitInput = filtered
                        }
                    }

                Spacer()

                Button(action: dialNumber) {
                    Image(systemName: "phone.fill")
                        .font(.system(size: 40))
                        .padding(30)
                        .background(isDialButtonEnabled ? Color.green : Color.gray.opacity(0.5))
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.3), radius: isDialButtonEnabled ? 10 : 0, x: 0, y: 5)
                        .animation(.spring(), value: isDialButtonEnabled)
                }
                .disabled(!isDialButtonEnabled)

                Spacer()
            }
        }
    }

    private func dialNumber() {
        guard let numberToDial = fullPhoneNumber else { return }

        let telephoneURLString = "tel://\(numberToDial)"
        guard let telephoneURL = URL(string: telephoneURLString) else { return }

        if UIApplication.shared.canOpenURL(telephoneURL) {
            UIApplication.shared.open(telephoneURL)
        }
    }
}

#Preview {
    ContentView()
}

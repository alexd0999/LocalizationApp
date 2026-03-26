//
//  ContentView.swift
//  LocalizationApp
//
//  Created by Alex Arthur on 3/15/26.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("selectedLanguage") private var language = "en"
    
    //manually adjusts UI elements for cultural customization
    @Environment(\.layoutDirection) var layoutDirection
    
    let sampleNumber: Double = 1234567.89

    //dynamically changes main color of the app based on region
    var themeColor: Color {
        if language == "ar" {
            return .purple
        } else if language == "es" {
            return .orange
        } else if language == "fr" {
            return .indigo
        } else {
            return .blue
        }
    }

    var body: some View {
        ZStack {
            Image("background_\(language)")
                .resizable()
                .ignoresSafeArea()
                .opacity(0.4)
                .blur(radius: 3)

            VStack(spacing: 20) {
                
                //auti align
                Text("Welcome to our App!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(themeColor)
                
                Text("This is a sample description to show how localization works.")
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)

                Divider().padding(.vertical, 5)

                //formatted data
                VStack(alignment: .leading, spacing: 10) {
                    Text("Current Date & Time:")
                        .font(.headline)
                    
                    Text(getFormattedDateTime(localeIdentifier: language))
                        .font(.subheadline)

                    Text("Formatted Number:")
                        .font(.headline)
                        .padding(.top, 5)
                    
                    Text(getFormattedNumber(value: sampleNumber, localeIdentifier: language))
                        .font(.subheadline)
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(15)

                //reverses OK and Cancel buttons
                HStack(spacing: 20) {
                    if layoutDirection == .rightToLeft {
                        Button("OK") { print("OK tapped") }
                            .buttonStyle(ThemeButtonStyle(color: themeColor))
                        
                        Button("Cancel") { print("Cancel tapped") }
                            .buttonStyle(ThemeButtonStyle(color: .gray))
                    } else {
                        Button("Cancel") { print("Cancel tapped") }
                            .buttonStyle(ThemeButtonStyle(color: .gray))
                        
                        Button("OK") { print("OK tapped") }
                            .buttonStyle(ThemeButtonStyle(color: themeColor))
                    }
                }
                .padding(.top, 10)

                Spacer()

                //language switcher
                Button(action: {
                    if language == "en" { language = "es" }
                    else if language == "es" { language = "fr" }
                    else if language == "fr" { language = "ar" }
                    else { language = "en" }
                }) {
                    Text("Switch Language")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black.opacity(0.8))
                        .cornerRadius(12)
                }
                .padding(.horizontal)
            }
            .padding(.top)
        }
    }

    //helper functions
    func getFormattedDateTime(localeIdentifier: String) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: localeIdentifier)
        return formatter.string(from: Date())
    }

    func getFormattedNumber(value: Double, localeIdentifier: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: localeIdentifier)
        return formatter.string(from: NSNumber(value: value)) ?? "Error"
    }
}

struct ThemeButtonStyle: ViewModifier {
    var color: Color
    func body(content: Content) -> some View {
        content
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.horizontal, 30)
            .padding(.vertical, 10)
            .background(color)
            .cornerRadius(8)
    }
}
extension View {
    func buttonStyle(_ style: ThemeButtonStyle) -> some View {
        self.modifier(style)
    }
}

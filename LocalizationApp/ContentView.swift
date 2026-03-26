//
//  ContentView.swift
//  LocalizationApp
//
//  Created by Alex Arthur on 3/15/26.
//

import SwiftUI

struct ContentView: View {

    //starts in english
    @AppStorage("selectedLanguage") private var language = "en"

    var body: some View {
        
        VStack(spacing: 30) {
            
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.blue)
                .font(.system(size: 60))


            Text("Welcome to our App!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)

            VStack(spacing: 10) {
                Text("Current Date:")
                    .font(.headline)
                
                //calls custom function
                Text(getFormattedDate(localeIdentifier: language))
                    .font(.title3)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)

            //language switcher
            Button(action: {
                if language == "en" {
                    language = "es"
                } else {
                    language = "en"
                }
            }) {
                Text("Switch Language")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
    }

    //date & time translator
    func getFormattedDate(localeIdentifier: String) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long //spells out month
        formatter.timeStyle = .none //date only
        
        //tells formatter to use en or es
        formatter.locale = Locale(identifier: localeIdentifier)
        
        //returns the current date into a formatted string
        return formatter.string(from: Date())
    }
}

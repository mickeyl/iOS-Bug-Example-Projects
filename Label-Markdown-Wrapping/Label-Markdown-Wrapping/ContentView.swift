//
//  ContentView.swift
//  Label-Markdown-Wrapping
//
//  Created by Dr. Michael Lauer on 28.10.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")

            List {

                Section {

                } header: {

                } footer: {
                    Text("This is a simple example text with markdown statement, intended to shows it's not always [wrapping correctly](http://www.vanille.de).")
                }

            }

        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

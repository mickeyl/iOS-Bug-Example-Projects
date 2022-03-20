//
//  ContentView.swift
//  EAAccessoryPicker-not-showing-up
//
//  Created by Dr. Michael Lauer on 20.03.22.
//
import ExternalAccessory
import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                Thread.sleep(forTimeInterval: 1.0)
                EAAccessoryManager.shared().showBluetoothAccessoryPicker(withNameFilter: nil) { _ in
                    print("Done")
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

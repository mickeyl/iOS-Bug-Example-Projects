//
//  ContentView.swift
//  TabBarItemValueTest
//
//  Created by Dr. Michael Lauer on 07.11.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Dashboard", systemImage: "gauge.with.dots.needle.bottom.50percent") {
                NavigationStack {
                    HomeView()
                        .navigationTitle("Dashboard")
                        .navigationBarTitleDisplayMode(.inline)
                }
            }

            Tab("Tools", systemImage: "gear") {
                NavigationStack {
                    Text("Tools")
                        .navigationTitle("Tools")
                        .navigationBarTitleDisplayMode(.inline)
                }
            }
            Tab("Zeroconf", systemImage: "bonjour") {
                NavigationStack {
                    EmptyView()
                        .navigationTitle("Zeroconf Neighbourhood")
                        .navigationBarTitleDisplayMode(.inline)
                }
            }.badge(Handler.shared.homeBadgeValue)
        }
    }
}
#Preview {
    ContentView()
}

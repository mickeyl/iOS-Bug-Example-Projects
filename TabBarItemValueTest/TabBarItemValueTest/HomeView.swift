//
//  HomeView.swift
//  TabBarItemValueTest
//
//  Created by Dr. Michael Lauer on 07.11.24.
//

import SwiftUI

struct HomeView: View {

    init() {
        print("HomeView init")
    }


    var body: some View {


            List {
                
                NavigationLink {
                    DetailView()
                } label: {
                    Text("Home Details")
                }
            }
            .navigationTitle("Home")
        }
}

#Preview {
    HomeView()
}

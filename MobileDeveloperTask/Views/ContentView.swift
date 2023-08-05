//
//  ContentView.swift
//  MobileDeveloperTask
//
//  Created by Jan Kubín on 04.08.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DailyView()
                .tabItem {
                    Image(systemName: "photo")
                    Text("Daily")
               }
            LaunchesView()
                .tabItem {
                    Image(systemName: "note")
                    Text("Launches")
                }
        }
    }
}

#Preview {
    ContentView()
}

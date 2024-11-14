//
//  ContentView.swift
//  NegroniChallenge
//
//  Created by Luca Maria Incarnato on 04/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // TabBar with Sidebar option to display main sections of the app
        TabView{
            Tab("Home", systemImage: "house"){
                HomeView()
            }
            Tab("Search", systemImage: "magnifyingglass"){
                SearchView()
            }
            // Show the link to each speech
            TabSection("Speeches") {
                Tab("All topics", systemImage: "pencil") {
                    // For future: there goes the NavigationLink for the speech
                    Text("This is the blog page")
               }
            }
            Tab("old", systemImage: "house"){
                TextSpeechView()
            }
            .defaultVisibility(.hidden, for: .tabBar)
            // Hides the Section from the TabBar but not from the Sidebar
        }
        .tabViewStyle(.sidebarAdaptable) // Allows the Sidebar
    }
}

#Preview {
    ContentView()
}

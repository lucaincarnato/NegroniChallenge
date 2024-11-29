//
//  ContentView.swift
//  NegroniChallenge
//
//  Created by Luca Maria Incarnato on 04/11/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query private var speeches: [Speech]
    
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
                ForEach(speeches) { speech in
                    // Looks into the data array to show all the speeches in the sidebar
                    Tab(speech.title, systemImage: ""){
                        // TODO: Correct this issue
                        TextSpeechView(actualSpeech: speech)
                    }
                }
            }
            .defaultVisibility(.hidden, for: .tabBar)
            // Hides the Section from the TabBar but not from the Sidebar
        }
        .tabViewStyle(.sidebarAdaptable) // Allows the Sidebar
    }
}

#Preview {
    // The environment variable is needed as an "example" to not make the simulator crash
    ContentView()
}

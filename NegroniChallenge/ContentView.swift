//
//  ContentView.swift
//  NegroniChallenge
//
//  Created by Luca Maria Incarnato on 04/11/24.
//

import SwiftUI

struct ContentView: View {
    @State var speechesVM = SpeechViewModel()
    
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
                ForEach(speechesVM.data) { speech in
                    // Looks into the data array to show all the speeches in the sidebar
                    Tab(speech.speechTitle, systemImage: ""){
                        CardView(actualSpeech: speech)
                    }
                }
            }
            Tab("old", systemImage: "house"){
                TextSpeechView()
            }
            .defaultVisibility(.hidden, for: .tabBar)
            // Hides the Section from the TabBar but not from the Sidebar
        }
        .tabViewStyle(.sidebarAdaptable) // Allows the Sidebar
        .environment(speechesVM) // Pushes the data object into the environment to make it available to all views
    }
}

#Preview {
    // The environment variable is needed as an "example" to not make the simulator crash
    ContentView()
        .environment(SpeechViewModel())
}

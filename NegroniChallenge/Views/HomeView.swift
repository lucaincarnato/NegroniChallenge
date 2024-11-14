//
//  HomeView.swift
//  NegroniChallenge
//
//  Created by Michele Barbato on 12/11/24.
//

import SwiftUI

struct HomeView: View {
    // Data set got from the environment (in ContentView)
    @Environment(SpeechViewModel.self) var speechesVM
    // Information about the four columns of the LazyVGrid
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // Four columns from columns array for the grid
                LazyVGrid(columns: columns, spacing: 30) {
                    // Set of cards for the single speeches
                    ForEach(speechesVM.data) { speech in
                        CardView(actualSpeech: speech)
                    }
                }
                .padding()
            }
            .navigationTitle("Home")
            // Toolbar for the add button
            .toolbar {
                ToolbarItem(placement: .topBarTrailing){
                    Button("Add") {
                        print("ADDEDD")
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(SpeechViewModel())
}

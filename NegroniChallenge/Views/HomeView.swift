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
    @State private var showModal = false
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
            //modal to speechView
            .sheet(isPresented: $showModal, content: {
                NewSpeechView(showModal: $showModal)
            })
            // Toolbar for the add button
            .toolbar {
                ToolbarItem {
                    Button {
                        showModal.toggle()
                    } label: {
                        Image(systemName: "plus")
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

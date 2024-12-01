//
//  HomeView.swift
//  NegroniChallenge
//
//  Created by Michele Barbato on 12/11/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var context
    @Query private var speeches: [Speech]
    // Boolean variable for the modality
    @State private var showModal = false
    // Describes how many columns and how they act in the grid
    let columns = [
        GridItem(.flexible(minimum: 150, maximum: 250)),
        GridItem(.flexible(minimum: 150, maximum: 250)),
        GridItem(.flexible(minimum: 150, maximum: 250)),
        GridItem(.flexible(minimum: 150, maximum: 250))
    ]
    
    var body: some View {
        NavigationStack {
            // ZStack for the overlay of background and content
            ZStack {
                // Background
                Color.gray
                    .opacity(0.1)
                    .ignoresSafeArea()
                // Content
                ScrollView {
                    if(speeches.isEmpty){
                        Text("No speeches found, click on the plus button to add one")
                            .font(.subheadline)
                            .padding()
                            .foregroundStyle(.gray)
                    } else {
                        // Vertical grid where there'll be Speech cards
                        LazyVGrid(columns: columns, spacing: 30) {
                            // Set of cards for the single speeches
                            ForEach(speeches) { speech in
                                // Card to Speech navigation
                                NavigationLink{
                                    TextSpeechView(actualSpeech: speech)
                                } label: {
                                    CardView(actualSpeech: speech, remove: context.delete)
                                }
                                // Michele was right, there's an overlay removed by this modifier
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding()
                }
                }
                .navigationTitle("Home")
                // Modal to New speech
                .sheet(isPresented: $showModal, content: {
                    NewSpeechView(showModal: $showModal, add: context.insert)
                })
                // Toolbar for the add button in the top Trailing corner
                .toolbar {
                    ToolbarItem (placement: .topBarTrailing) {
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
}

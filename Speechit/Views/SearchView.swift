//
//  SearchView.swift
//  NegroniChallenge
//
//  Created by Michele Barbato on 12/11/24.
//

import SwiftUI
import SwiftData

struct SearchView: View {
    // Link to memory in order to retreive data
    @Environment(\.modelContext) private var context
    @Query private var speeches: [Speech]
    // Describes how many columns and how they act in the grid
    let columns = [
        GridItem(.flexible(minimum: 150, maximum: 250)),
        GridItem(.flexible(minimum: 150, maximum: 250)),
        GridItem(.flexible(minimum: 150, maximum: 250)),
        GridItem(.flexible(minimum: 150, maximum: 250))
    ]
    // State variable to show the searched text in real time
    @State private var searchText = ""
    // Returns an array of Speeches that has the name of searchText (ignoring upper and lower cases)
    var filteredSpeech: [Speech] {
        // Filter goes through the array and get the items with the expressed conditions (localizedCaseInsensitiveContains)
        speeches.filter{ speech in
            speech.title.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        NavigationStack {
            // ZStack for the overlay of background and content
            ZStack {
                // Background
                Color.gray
                    .opacity(0.1)
                    .ignoresSafeArea()
                
                // Search results
                ScrollView{
                    // If the search returns no item, it is shown a "no founds" texts
                    if filteredSpeech.isEmpty && !searchText.isEmpty {
                        Text("No speech found")
                            .font(.subheadline)
                            .padding()
                            .foregroundStyle(.gray)
                        // If the search returns an array of items, it shows it
                    } else {
                        // Vertical grid where there'll be Speech cards
                        LazyVGrid(columns: columns, spacing: 30) {
                            // Card for the single speech
                            ForEach(filteredSpeech){ speech in
                                NavigationLink{
                                    TextSpeechView(actualSpeech: speech)
                                } label: {
                                    CardView(actualSpeech: speech, remove: context.delete)
                                }
                                // Michele was right, there's an overlay removed by this modifier
                                .buttonStyle(PlainButtonStyle())
                                // Set to searched when the user taps on the speech and goes into navigation
                                .simultaneousGesture(TapGesture().onEnded {
                                    speech.searched.toggle()
                                })
                            }
                        }
                        .padding()
                    }
                    // History
                    Section{
                        Text("HISTORY")
                            .font(.subheadline)
                            .padding(.horizontal, 20)
                            .foregroundStyle(Color.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ScrollView{
                            // Vertical grid where there'll be searched Speech cards
                            LazyVGrid(columns: columns, spacing: 30) {
                                // Card for the single speech
                                ForEach(speeches){ speech in
                                    if(speech.searched){
                                        NavigationLink{
                                            TextSpeechView(actualSpeech: speech)
                                        } label: {
                                            CardView(actualSpeech: speech, remove: context.delete)
                                        }
                                        // Michele was right, there's an overlay removed by this modifier
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
            .navigationTitle("Search")
        }
        // The actual search bar, placed down the navigationTitle and always shown when you scroll down
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
    }
}

//
//  SearchView.swift
//  NegroniChallenge
//
//  Created by Michele Barbato on 12/11/24.
//

import SwiftUI

struct SearchView: View {
    @Environment(SpeechViewModel.self) var speechesVM
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @State private var searchText = ""
    // Returns an array of Speeches that has the name of searchText (ignoring upper and lower cases)
    var filteredSpeech: [SpeechModel] {
        // Filter goes through the array and get the items with the expressed conditions (localizedCaseInsensitiveContains)
        speechesVM.data.filter{ speech in
            speech.speechTitle.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView{
                // If the search returns no item, it is shown a "no founds" texts
                if filteredSpeech.isEmpty && !searchText.isEmpty {
                    Text("No speech found")
                        .font(.subheadline)
                        .padding()
                        .foregroundStyle(.gray)
                // If the search returns an array of items, it shows it
                } else {
                    // Four columns from columns array for the grid
                    LazyVGrid(columns: columns, spacing: 30) {
                        // Card for the single speech
                        ForEach(filteredSpeech){ speech in
                            CardView(actualSpeech: speech)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Search")
        }
        // The actual search bar, placed down the navigationTitle and always shown when you scroll down
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
    }
}
#Preview {
    SearchView()
        .environment(SpeechViewModel())
}

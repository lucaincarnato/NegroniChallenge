//
//  SearchView.swift
//  NegroniChallenge
//
//  Created by Michele Barbato on 12/11/24.
//

import SwiftUI

struct SearchView: View {
    let columns = [
        GridItem(.adaptive(minimum:150 , maximum:200)),
        GridItem(.adaptive(minimum:150 , maximum:200)),
        GridItem(.adaptive(minimum:150 , maximum:200)),
        GridItem(.adaptive(minimum:150 , maximum:200))
    ]
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ScrollView{
                // Four columns from columns array for the grid
                LazyVGrid(columns: columns, spacing: 50) {
                    // Card for the single speech
                    // For future: it is a button and needs to be iterated
                    CardView(speechTitle: "Benigni", dateOfPlay: "31/12/2024", numberOfPeople: 8, color: .red)
                }
                .padding()
            }
            .navigationTitle("Search")
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
    }
}
#Preview {
    SearchView()
    Spacer()
}

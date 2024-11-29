//
//  EditTextView.swift
//  NegroniChallenge
//
//  Created by Luca Maria Incarnato on 18/11/24.
//

import SwiftUI

struct EditTextView: View {
    // Speech speech starting point
    @Binding var actualSpeech: Speech
    // Boolean variable for modality
    @Binding var showModal: Bool
    // Integer to direct edit mode
    @State var editMode: Int = 0
    
    var body: some View {
        NavigationStack{
            // ZStack for the overlay of background and content
            ZStack{
                // Background
                Color.gray
                    .opacity(0.1)
                    .ignoresSafeArea()
                // Content
                VStack{
                    // Select and redirect the correct edit mode
                    Picker("", selection: $editMode){
                        Text("Edit text").tag(0)
                        Text("Edit subtext").tag(1)
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                    switch(editMode){
                    case 0:
                        EditTextMode(actualSpeech: $actualSpeech)
                    case 1:
                        EditSubtextMode(actualSpeech: $actualSpeech)
                    default:
                        EditDefaultMode()
                    }
                }
                .padding()
                .navigationTitle(actualSpeech.title)
                .navigationBarTitleDisplayMode(.inline)
                // Toolbar to save and cancel actions
                .toolbar{
                    ToolbarItem(placement: .cancellationAction){
                        Button("Cancel", action: {
                            showModal.toggle()
                        })
                    }
                    ToolbarItem(placement: .topBarTrailing){
                        Button("Save", action: {
                            showModal.toggle()
                        })
                    }
                }
            }
        }
    }
}

// Edits only the text
struct EditTextMode : View {
    // Speech speech starting point
    @Binding var actualSpeech: Speech
    
    var body: some View {
        // ZStack for the overlay of background and content
        ZStack {
            // Background
            Rectangle()
                .fill(Color.white)
                .cornerRadius(15)
                .padding()
            // Content
            TextEditor(text: $actualSpeech.text)
                .padding(30)
                .frame(alignment: .topLeading)
                .font(.title)
        }
    }
}

// Edits only the subtext
struct EditSubtextMode : View {
    // Speech speech starting point
    @Binding var actualSpeech: Speech
    // Default subtext SF symbols
    let dragItems = ["space", "base.unit", "arrow.up", "arrow.down"]
    
    var body: some View {
        VStack{
            // ZStack for the overlay of background and content related to the speech text
            ZStack {
                // Background
                Rectangle()
                    .fill(Color.white)
                    .cornerRadius(15)
                // Content
                ScrollView{
                    // Vertical grid where there'll be Speech words cards
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 130))], spacing: 10) {
                        // It creates unique ids for each word so that the ForEach can show it even if there's many occurrences of the same word
                        let words = Array(zip(actualSpeech.text.components(separatedBy: .whitespacesAndNewlines).indices, actualSpeech.text.components(separatedBy: .whitespacesAndNewlines)))
                        // Each single word card
                        ForEach(words, id: \.0) { _, word in
                            ZStack {
                                Rectangle()
                                    .fill(Color.gray)
                                    .opacity(0.3)
                                    .frame(width: 130, height: 40)
                                    .cornerRadius(10)
                                Text(word)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(20)
                }
            }
            .padding()
            // ZStack for the overlay of background and content related to the subtext elements
            ZStack{
                // Background
                Rectangle()
                    .fill(Color.white)
                    .cornerRadius(15)
                    .frame(maxHeight: 100)
                    .padding()
                // Color
                HStack{
                    // Each single subtext card
                    ForEach(dragItems, id:\.self) { symbol in
                        ZStack {
                            Rectangle()
                                .fill(Color.red)
                                .frame(width: 90, height: 40)
                                .cornerRadius(10)
                            Image(systemName: symbol)
                                .foregroundStyle(Color.white)
                        }
                    }
                }
            }
        }
    }
}

// Default view showed when error occurs
struct EditDefaultMode : View {
    var body: some View{
        Text("Something went wrong")
            .font(.title)
            .foregroundStyle(.gray)
    }
}

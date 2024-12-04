//
//  EditTextView.swift
//  NegroniChallenge
//
//  Created by Luca Maria Incarnato on 18/11/24.
//

import SwiftUI
import WrappingHStack

struct EditTextView: View {
    // Link to memory in order to retreive data
    @Environment(\.modelContext) private var context
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
                            try? context.save()
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
                    // Dynamic HStack where there'll be Speech words cards
                    WrappingHStack {
                        // Each single word card
                        ForEach(actualSpeech.separateWords(), id:\.self) {word in
                            Label(word, systemImage: "function")
                                .labelStyle(.titleOnly)
                                .padding()
                                .background(Color.gray.opacity(0.3), in: RoundedRectangle(cornerRadius: 15))
                        }
                    }
                    .frame(maxHeight: .infinity)
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
                        Label("Michele Parocazz", systemImage: symbol)
                            .labelStyle(.iconOnly)
                            .foregroundStyle(Color.white)
                            .padding()
                            .background(Color.red, in: RoundedRectangle(cornerRadius: 15))
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

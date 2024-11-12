//
//  EditView.swift
//  NegroniChallenge
//
//  Created by Jesus Sebastian Jaime Oviedo on 12/11/24.
//

import SwiftUI

struct EditView: View {
    @State var title: String = "" //has to be changed
    
    @State private var selectedEmoji = "📕"
    @State private var emojiOptions = [
        "📕",
        "📘",
        "📗",
        "📙",
        "✍️",
        "🎥",
        "📢",
        "🎤",
        "📻",
    ]
    
    @State var speaker: String = ""
    @State private var speakers: [String] = ["Me"]
    
    var body: some View {
        NavigationStack {
            
            Form {
                
                Section("Identifier") {
                    Picker("Select an emoji", selection: $selectedEmoji) {
                        ForEach(emojiOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.automatic)
                    
                    LabeledContent {
                        TextField("Required", text: $title)
                    } label: {
                        Text("Title")
                    }
                }
                
                Section ("Information") {
                    
                    LabeledContent {
                        TextField("Required", text: $title)
                    } label: {
                        Text("Duration")
                    }
                    
                    LabeledContent {
                        TextField("", text: $title)
                    } label: {
                        Text("Instructions")
                    }
                    
                    LabeledContent {
                        TextField("", text: $title)
                    } label: {
                        Text("Notes")
                    }
                }
                Section("Speakers (swipe for deletion)") {
                    ForEach(speakers, id: \.self) { item in
                        Text(item)
                    }
                    .onDelete { indexSet in
                        speakers.remove(atOffsets: indexSet)
                    }
                    HStack {
                        TextField("Name of speaker", text: $speaker)
                    //} label: {
                        Button("Add") {
                            speakers.append("$speaker")
                        }
                    }
                }
                Button("Save", action: {
                    print("Submit button tapped")
                })
            }
            .navigationTitle("New/Edit Speech")
        }
        
    }
}


#Preview {
    EditView()
}

//
//  EditTextView.swift
//  NegroniChallenge
//
//  Created by Luca Maria Incarnato on 18/11/24.
//

import SwiftUI

struct EditTextView: View {
    @Environment(SpeechViewModel.self) var speechesVM
    @Binding var showModal: Bool
    @Binding var actualSpeech: SpeechModel
    @State var editMode: Int = 0
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.gray
                    .opacity(0.1)
                    .ignoresSafeArea()
                VStack{
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
                .navigationTitle(actualSpeech.speechTitle)
                .navigationBarTitleDisplayMode(.inline)
                // Goes into edit mode
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

struct EditTextMode : View {
    @Binding var actualSpeech: SpeechModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .cornerRadius(15)
                .padding()
            TextEditor(text: $actualSpeech.speechText)
                .padding(30)
                .frame(alignment: .topLeading)
                .font(.title)
        }
    }
}

struct EditSubtextMode : View {
    @Binding var actualSpeech: SpeechModel
    let dragItems = ["space", "base.unit", "arrow.up", "arrow.down"]
    
    var body: some View {
        VStack{
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .cornerRadius(15)
                ScrollView{
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 130))], spacing: 10) {
                        // It creates unique ids for each word so that the ForEach can show it even if there's many occurrences of the same word
                        let words = Array(zip(actualSpeech.speechText.components(separatedBy: .whitespacesAndNewlines).indices, actualSpeech.speechText.components(separatedBy: .whitespacesAndNewlines)))
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
            ZStack{
                Rectangle()
                    .fill(Color.white)
                    .cornerRadius(15)
                    .frame(maxHeight: 100)
                    .padding()
                HStack{
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

struct EditDefaultMode : View {
    var body: some View{
        Text("Something went wrong")
            .font(.title)
            .foregroundStyle(.gray)
    }
}

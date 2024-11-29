//
//  TextSpeechView.swift
//  NegroniChallenge
//
//  Created by Paola Barbuto Ferraiuolo on 14/11/24.
//

import SwiftUI

import SwiftData

struct TextSpeechView : View {
    // Speech speech starting point
    @State var actualSpeech: Speech
    // Variables to differentiate the mode of rehearsing
    @State var textActivator: Bool = true
    @State var subtextActivator: Bool = false
    // Boolean variables for the modality
    @State private var editModal = false
    @State private var infoModal = false
    
    var body: some View {
        NavigationStack {
            // ZStack for the overlay of background and content
            ZStack {
                // Background
                Color.gray
                    .opacity(0.1)
                    .ignoresSafeArea()
                // Content
                VStack{
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .cornerRadius(15)
                        ScrollView{
                            // Displays the text only if its toggle is active
                            if(textActivator && !subtextActivator){
                                Text(actualSpeech.text)
                                    .padding(20)
                                    .frame(maxWidth: .infinity, alignment: .topLeading)
                                    .font(.title)
                            // Displays the subtext only if its toggle and text's is active
                            } else if(subtextActivator) {
                                LazyVGrid(columns: [GridItem(.adaptive(minimum: 130))], spacing: 10) {
                                    // It creates unique ids for each word so that the ForEach can show it even if there's many occurrences of the same word
                                    let words = Array(zip(actualSpeech.text.components(separatedBy: .whitespacesAndNewlines).indices, actualSpeech.text.components(separatedBy: .whitespacesAndNewlines)))
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
                            // Displays nothing if both toggles are not active
                            } else {
                                Text("Text disabled")
                                    .foregroundStyle(.gray)
                                    .padding(20)
                                    .frame(maxWidth: .infinity, alignment: .topLeading)
                                    .font(.title)
                            }
                        }
                    }
                    .padding()
                    .frame(height: 400)
                    // Toggle UI space
                    HStack {
                        Text("With text")
                        Toggle("Text", isOn: $textActivator)
                            // Uncheck subtext if text is unchecked
                            .onChange(of: textActivator, initial: true, {subtextActivator = !textActivator ? false : subtextActivator})
                            .toggleStyle(.switch)
                            .labelsHidden()
                        Spacer()
                        Text("With subtext")
                        Toggle("Subtext", isOn: $subtextActivator)
                            .toggleStyle(.switch)
                            .labelsHidden()
                            // Disables the toggle if the text one is off
                            .disabled(!textActivator)
                    }
                    .padding(.horizontal, 250)
                    // TODO: LIST OF RECORDINGS
                    VStack {}
                    .scrollContentBackground(.hidden)
                    // Buttons for info and start rehearsal
                    HStack{
                        // Info button
                        Button(action: {
                            infoModal.toggle()
                        }, label: {
                            HStack {
                                Image(systemName: "info.circle")
                            }
                        })
                        .buttonStyle(.bordered)
                        .controlSize(.large)
                        .buttonBorderShape(.capsule)
                        .tint(.blue)
                        // Rehearsal button
                        Button(action: {
                            print("CIAO")
                        }, label: {
                            HStack {
                                Image(systemName: "play.fill")
                                Text("Rehearse")
                            }
                            .padding(.horizontal, 50)
                        })
                        .buttonStyle(.bordered)
                        .controlSize(.large)
                        .buttonBorderShape(.capsule)
                        .tint(.red)
                    }
                    .padding(.vertical, 20)
                }
                .navigationTitle(actualSpeech.title)
                // Modal to Edit view
                .sheet(isPresented: $editModal){
                    EditTextView(actualSpeech: $actualSpeech, showModal: $editModal)
                }
                // Modal to Text info view
                .sheet(isPresented: $infoModal){
                    TextInfoView(actualSpeech: actualSpeech, infoModal: $infoModal)
                }
                // Toolbar for the edit button
                .toolbar {
                    ToolbarItem (placement: .topBarTrailing) {
                        Button {
                            editModal.toggle()
                        } label: {
                            Text("Edit")
                        }
                    }
                }
            }
        }
    }
}

//in riga 61 luca non ci ha aiutato ovviamente <3
// Michele non ricordo manco che cazzo c'era in riga 61, si è sminchiato tutto

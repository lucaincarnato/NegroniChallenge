//
//  TextSpeechView.swift
//  NegroniChallenge
//
//  Created by Paola Barbuto Ferraiuolo on 14/11/24.
//

import SwiftUI
import WrappingHStack
import SwiftData

struct TextSpeechView : View {
    // Link to memory in order to retreive data
    @Environment(\.modelContext) private var context
    // Speech speech starting point
    @State var actualSpeech: Speech
    // Variables to differentiate the mode of rehearsing
    @State var textActivator: Bool = true
    @State var subtextActivator: Bool = false
    // Boolean variables for the modality
    @State private var editModal = false
    @State private var infoModal = false
    // Manager for recording and speech recognition
    @StateObject private var rehearsalManager: RehearsalManager = RehearsalManager()
    // Shows alert for custom recording's name
    @State private var showAlert = false
    // Custom recording's name
    @State private var customName = ""
    
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
                    // List of recording
                    VStack{
                        List(actualSpeech.rehearsals, id: \.self) { rehearsal in
                            // Navigation to the feedback
                            NavigationLink{
                                FeedbackView(actualSpeech: actualSpeech, actualRehearsal: rehearsal)
                            } label: {
                                Text("\(rehearsal.fileURL.lastPathComponent)")
                            }
                            // MARK: Save context
                        }
                    }
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
                            // Starts and stop based on recording state
                            if rehearsalManager.isRecording {
                                showAlert = true
                                rehearsalManager.pauseRecording()
                            } else {
                                rehearsalManager.startRecording()
                            }
                            // Saves the changes and allows the recording to stay in memory
                            try? context.save()
                        }, label: {
                            HStack {
                                // Differentiate the button based on recording state
                                Image(systemName: rehearsalManager.isRecording ? "stop.fill" : "play.fill")
                                Text(rehearsalManager.isRecording ? "Stop rehearsal" : "Start rehearsal")
                                    .padding()
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .padding(.horizontal, 50)
                        })
                        .buttonStyle(.bordered)
                        .controlSize(.large)
                        .buttonBorderShape(.capsule)
                        // Changes button's color based on recroding state
                        .tint(rehearsalManager.isRecording ? Color.yellow : Color.red)
                        // Shows an alert to let the user decide a custom name for the recording
                        .alert("Alert Title!", isPresented: $showAlert) {
                            TextField(text: $customName) {}
                            Button("Save") {
                                if (customName != ""){
                                    rehearsalManager.stopRecording(customName)
                                } else {
                                    rehearsalManager.stopRecording("SpeechitRehearsal")
                                }
                                customName = ""
                            }
                        } message: {
                            Text("Enter channel name")
                        }
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
        .onAppear() {
            self.rehearsalManager.actualSpeech = self.actualSpeech
        }
    }
}

//in riga 61 luca non ci ha aiutato ovviamente <3
// Michele non ricordo manco che cazzo c'era in riga 61, si è sminchiato tutto

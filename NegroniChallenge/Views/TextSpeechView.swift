//
//  TextSpeechView.swift
//  NegroniChallenge
//
//  Created by Paola Barbuto Ferraiuolo on 14/11/24.
//

import SwiftUI

import SwiftData

struct TextSpeechView : View {
    @Environment(SpeechViewModel.self) var speechesVM
    //Start of spencer's tuto new section
    /*
     @Environment(\.modelContext) var context
     @Environment(AudioRecorder.self) private var audioRecorder : AudioRecorder
     
     @Query(sort: \Recording.createdAt, order: .reverse) var allRecordings: [Recording]
     */
    //End of spencer's tuto new section
    @ObservedObject private var audioRecorder: AudioRecorder = AudioRecorder()
    
    @State var actualSpeech: SpeechModel = SpeechModel(
        speechTitle: "Poesia per Natale",
        cardColor: .blue,
        dateOfPlay: Date.now,
        hourDuration: 0,
        minuteDuration: 0,
        secondDuration: 40,
        speechText: """
            Se ni’ mondo esistesse un po’ di bene
            e ognun si honsiderasse suo fratello
            ci sarebbe meno pensieri e meno pene
            e il mondo ne sarebbe assai più bello
            """,
        previousRecordings: [
            Recording(fileURL: URL(fileURLWithPath: "recordings"), createdAt: Date.now)
        ],
        numberOfPeople: 2,
        instructions: "Be expressive",
        additionalNotes: ""
    )
    /*
     RecordingModel(title: "Recording2", duration: "10"),
     RecordingModel(title: "Recording2", duration: "10"),
     RecordingModel(title: "Recording2", duration: "10"),
     RecordingModel(title: "Recording2", duration: "10"),
     RecordingModel(title: "Recording2", duration: "10"),
     RecordingModel(title: "Recording2", duration: "10"),
     RecordingModel(title: "Recording2", duration: "10"),
     RecordingModel(title: "Recording3", duration: "10")
     */
    // Variables to differentiate the mode of rehearsing
    @State var textActivator: Bool = true
    @State var subtextActivator: Bool = false
    @State private var editModal = false
    @State private var infoModal = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background color
                Color.gray
                    .opacity(0.1)
                    .ignoresSafeArea()
                VStack{
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .cornerRadius(15)
                        ScrollView{
                            // Displays the text only if its toggle is active
                            if(textActivator && !subtextActivator){
                                Text(actualSpeech.speechText)
                                    .padding(20)
                                    .frame(maxWidth: .infinity, alignment: .topLeading)
                                    .font(.title)
                            } else if(subtextActivator) {
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
                            .disabled(!textActivator) // Disables the toggle if the text one is off
                    }
                    .padding(.horizontal, 250)
                    VStack {
                        RecordingsList(actualSpeech: $actualSpeech, audioRecorder: audioRecorder)
                    }
                    .scrollContentBackground(.hidden)
                    // Buttons for info and start rehearsal
                    HStack{
                        // Goes to info
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
                        // Start of rehearsal button
                        if audioRecorder.recording == false {
                            Button(action: {
                                print("CIAO")
                                self.audioRecorder.startRecording()
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
                        } else {
                            Button(action: {
                                print("BYE")
                                self.audioRecorder.stopRecording()
                            }, label: {
                                HStack {
                                    Image(systemName: "stop.fill")
                                    Text("Stop recording")
                                }
                                .padding(.horizontal, 50)
                            })
                            .buttonStyle(.bordered)
                            .controlSize(.large)
                            .buttonBorderShape(.capsule)
                            .tint(.orange)
                            .padding(.horizontal, 20)
                        }
                        // End of rehearsal button
                        //RecordButtonView()
                    }
                    .padding(.vertical, 20)
                }
                .navigationTitle(actualSpeech.speechTitle)
                //modal to EditTextView
                .sheet(isPresented: $editModal){
                    EditTextView(speechesVM: _speechesVM, showModal: $editModal, actualSpeech: $actualSpeech)
                }
                //modal to TextInfoView
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

#Preview {
    TextSpeechView()
        .environment(SpeechViewModel())
}
//in riga 61 luca non ci ha aiutato ovviamente <3

//
//  TextSpeechView.swift
//  NegroniChallenge
//
//  Created by Paola Barbuto Ferraiuolo on 14/11/24.
//

import SwiftUI

import SwiftData

struct TextSpeechView : View {
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
                            if(textActivator){
                                Text(actualSpeech.speechText)
                                    .padding(20)
                                    .frame(maxWidth: .infinity, alignment: .topLeading)
                                    .font(.title)
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
                    Text("Previous Rehearsals")
                        .font(.title)
                        .padding(20)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    VStack {
                        RecordingsList(audioRecorder: audioRecorder)
                    }
                    .scrollContentBackground(.hidden)
                    .padding([.top],-50)
                    // Buttons for info and start rehearsal
                    HStack{
                        // Goes to info
                        Button(action: {
                            print("CIAO")
                        }, label: {
                            HStack {
                                Image(systemName: "info.circle")
                                Text("Speech info")
                            }
                            .padding(.horizontal, 40)
                        })
                        .buttonStyle(.bordered)
                        .controlSize(.large)
                        .buttonBorderShape(.capsule)
                        .tint(.blue)
                        .padding(.horizontal, 20)
                        
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
                            .padding(.horizontal, 20)
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
                // Goes into edit mode
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing){
                        Button("Edit", action: {print("CIAO")})
                    }
                }
            }
        }
    }
}

/*
@ViewBuilder
func previousRehearsalsSection(allRecordings: [Recording] , context: ModelContext ) -> some View {
    
    Section(header: Text("Previous Rehearsals")) {
        if allRecordings.isEmpty {
            Text("No recordings yet")
        } else {
            ForEach(allRecordings, id: \.id) { recording in
                VStack(alignment: .leading, spacing: 8) {
                    Text(recording.title)
                        .font(.headline)
                    Text(recording.createdAt.formatted(.dateTime))
                        .font(.caption)
                        .foregroundStyle(.gray)
                    // Play button for the recording
                    PlayAudioButtonView(audioURL: URL(fileURLWithPath: recording.fileName, relativeTo: .applicationDirectory))
                }
                .padding(.vertical, 8)
            }
            .onDelete { indexSet in
                indexSet.forEach { index in
                    context.delete(allRecordings[index])
                }
                do {
                    try context.save()
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
}

*/

struct TextSpeechView_Previews: PreviewProvider {
    static var previews: some View {
        TextSpeechView()
    }
}
 //in riga 61 luca non ci ha aiutato ovviamente <3

/*
 #Preview {
 let config = ModelConfiguration(isStoredInMemoryOnly: true)
 let container = try! ModelContainer(for: Recording.self  ,configurations: config)
 let audioRecorder = AudioRecorder()
 
 
 //RecordingsListView().modelContainer(createPreviewModelContainer())
 
 return NavigationStack { TextSpeechView()}
 .task {
 audioRecorder.setup()
 }
 .environment(audioRecorder)
 .modelContainer(container)
 }
 */

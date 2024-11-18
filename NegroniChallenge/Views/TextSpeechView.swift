//
//  TextSpeechView.swift
//  NegroniChallenge
//
//  Created by Paola Barbuto Ferraiuolo on 14/11/24.
//

import SwiftUI

struct TextSpeechView : View {
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
            RecordingModel(title: "Recording1", duration: "10"),
            RecordingModel(title: "Recording2", duration: "10"),
            RecordingModel(title: "Recording2", duration: "10"),
            RecordingModel(title: "Recording2", duration: "10"),
            RecordingModel(title: "Recording2", duration: "10"),
            RecordingModel(title: "Recording2", duration: "10"),
            RecordingModel(title: "Recording2", duration: "10"),
            RecordingModel(title: "Recording2", duration: "10"),
            RecordingModel(title: "Recording3", duration: "10")
        ],
        numberOfPeople: 2,
        instructions: "Be expressive",
        additionalNotes: ""
    )
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
                    List{
                        Section (header: Text("Previous Rehearsals")){
                            // Goes into feedback view
                            ForEach(actualSpeech.previousRecordings, id: \.id) { recording in
                                VStack(alignment: .leading) {
                                    Text(recording.title)
                                    Text(recording.duration)
                                        .font(.caption)
                                }
                            }
                            // Swipe to delete implementation
                            .onDelete {
                                indexSet in actualSpeech.previousRecordings.remove(atOffsets: indexSet)
                            }
                        }
                        .headerProminence(.increased)
                    }
                    .scrollContentBackground(.hidden)
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
                        // Goes to rehearsal
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
                        .padding(.horizontal, 20)
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

#Preview {
    TextSpeechView()
}
//in riga 61 luca non ci ha aiutato ovviamente <3

//
//  TextSpeechView.swift
//  NegroniChallenge
//
//  Created by Paola Barbuto Ferraiuolo on 14/11/24.
//

import SwiftUI
import SwiftData

func randomDate(daysBack: Int = 30) -> Date {
    let dayOffset = Int.random(in: 0...daysBack)
    let secondsInDay: TimeInterval = 86400
    return Date().addingTimeInterval(-secondsInDay * Double(dayOffset))
}

struct TextSpeechView : View {
    //copy paste esta linea si hay que extraer las grabaciones
    var audioRecorder = AudioRecorder()
    
    @State var text: String = ""
    @State var textActivator: Bool = false
    @State var subtextActivator: Bool = false
    
    @State var recordingList: [Recording] = [
        Recording(id: UUID(), title: "Bla bla bla", fileName:".m4a" , transcript:"ok", createdAt: randomDate())
    ]
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
                                Text("hola") //actualSpeech.speechText
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
                }
                /*
                Section (header: Text ("Recordings")) {
                    //Separated View
                    
                    List {
                        ForEach(recordingList, id: \.id) { recording in
                            VStack(alignment: .leading) {
                                Text(recording.title)
                                Text(recording.duration)
                                    .font(.caption)
                            }
                        }
                        .onDelete {
                            indexSet in recordingList.remove(atOffsets: indexSet)
                        }
                        
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
                 */
                .navigationTitle("example") //actualSpeech.speechTitle
                // Goes into edit mode
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing){
                        Button("Edit", action: {print("CIAO")})
                    }
                     
                }
                 
            }
            VStack {
                RecordingsListView()//.navigationTitle("Recordings")
            }.task {
                audioRecorder.setup()
            }.environment( audioRecorder)
            .modelContainer(for : [Recording.self])
        }
        
    }
}

#Preview {
    TextSpeechView()
}
//in riga 61 luca non ci ha aiutato ovviamente

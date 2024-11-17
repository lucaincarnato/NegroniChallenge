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
            Form {
                Section (header: Text("Enter speech")) {
                    TextField("bla bla bla", text: $text)
                        .frame(minHeight : 200, alignment: .topLeading)
                        .padding([.top],5)
                }
                Section (header: Text("Modes")) {
                    HStack {
                        Toggle("Text", isOn: $textActivator)
                            .toggleStyle(.button)
                        Spacer()
                        Toggle("Subtext", isOn: $subtextActivator)
                            .toggleStyle(.button)
                    }
                    .padding(.horizontal, 250)
                }
                Section (header: Text ("Recordings")) {
                    //Separated View
                    /*
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
                     */
                    
                    
                }
                
                Button("CIAO"){
                    
                }
                .buttonStyle(.bordered)
                .alignmentGuide(VerticalAlignment.center, computeValue: { $0[.bottom]})
                
                
            }
            .navigationTitle("Text to Speech")
            
        }
        NavigationStack {
            RecordingsListView().navigationTitle("Recordings")
        }.task {
            audioRecorder.setup()
        }.environment( audioRecorder)
        .modelContainer(for : [Recording.self])
    }
}
#Preview {
    TextSpeechView()
}

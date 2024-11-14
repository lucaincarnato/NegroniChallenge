//
//  TextSpeechView.swift
//  NegroniChallenge
//
//  Created by Paola Barbuto Ferraiuolo on 14/11/24.
//

import SwiftUI

struct TextSpeechView : View {
    @State var text: String = ""
    @State var textActivator: Bool = false
    @State var subtextActivator: Bool = false
    
    @State var recordingList: [RecordingModel] = [
        RecordingModel(id: UUID(), title: "Bla bla bla", duration: "10:00"),
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
                    .toolbar {
                        EditButton()
                    }
                }
                
                Button("CIAO"){
                    
                }
                .buttonStyle(.bordered)
                .alignmentGuide(VerticalAlignment.center, computeValue: { $0[.bottom]})
                
                
            }
            .navigationTitle("Text to Speech")
            
        }
    }
}
#Preview {
    TextSpeechView()
}

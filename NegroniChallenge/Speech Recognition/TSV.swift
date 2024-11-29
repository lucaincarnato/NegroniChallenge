//
//  TSV.swift
//  NegroniChallenge
//
//  Created by Jesus Sebastian Jaime Oviedo on 18/11/24.
//

//
//  ContentView.swift
//  Voice Recorder
//
//  Created by Pinlun on 2019/10/30.
//  Copyright © 2019 Pinlun. All rights reserved.
//

import SwiftUI

struct TSV: View {
    
    @ObservedObject var audioRecorder: AudioRecorder
    
    var body: some View {
        NavigationView {
            VStack {
                RecordingsList(actualSpeech: .constant(SpeechModel(speechTitle: "", hourDuration: 0, minuteDuration: 0, secondDuration: 0, speechText: "", previousRecordings: [], numberOfPeople: 0, instructions: "", additionalNotes: "")), audioRecorder: audioRecorder)
                
                if audioRecorder.recording == false {
                    Button(action: {self.audioRecorder.startRecording()}) {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 70, height: 70)
                            .clipped()
                            .foregroundColor(.red)
                            .padding(.bottom, 40)
                    }
                } else {
                    Button(action: {self.audioRecorder.stopRecording()}) {
                        Image(systemName: "stop.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 70, height: 70)
                            .clipped()
                            .foregroundColor(.red)
                            .padding(.bottom, 40)
                    }
                }
            }
            .navigationBarTitle("Voice Recorder")
            .navigationBarItems(trailing: EditButton())
        }
    }
}

struct TSV_Previews: PreviewProvider {
    static var previews: some View {
        TSV(audioRecorder: AudioRecorder())
    }
}

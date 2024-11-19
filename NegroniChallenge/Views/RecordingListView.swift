//
//  RecordingListView.swift
//  NegroniChallenge
//
//  Created by Jesus Sebastian Jaime Oviedo on 18/11/24.
//

import SwiftUI

struct RecordingsList: View {
    @Binding var actualSpeech: SpeechModel
    @ObservedObject var audioRecorder: AudioRecorder
    
    var body: some View {
        List {
            Section (header: Text("Previous rehearsal")){
                ForEach(audioRecorder.recordings, id: \.createdAt) { recording in
                    NavigationLink(destination: FeedbackView(speechText: actualSpeech.speechText, transcription: recording.transcript ?? "")){
                        RecordingRow(audioURL: recording.fileURL, audioCreatedAt: recording.createdAt, actualSpeech: $actualSpeech)
                    }
                }
                .onDelete(perform: delete)
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        var urlsToDelete = [URL]()
        for index in offsets {
            urlsToDelete.append(audioRecorder.recordings[index].fileURL)
        }
        audioRecorder.deleteRecording(urlsToDelete: urlsToDelete)
    }
}

struct RecordingRow: View {
    
    var audioURL: URL
    var audioCreatedAt: Date
    @Binding var actualSpeech: SpeechModel
    
    @ObservedObject var audioPlayer = AudioPlayer()
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(audioCreatedAt.formatted(.dateTime))
                    .font(.headline)
                Text("\(audioURL.lastPathComponent)")
                    .font(.caption)
            }
            Spacer()
            if audioPlayer.isPlaying == false {
                Button(action: {
                    self.audioPlayer.startPlayback(audio: self.audioURL)
                }) {
                    Image(systemName: "play.circle")
                        .imageScale(.large)
                }
            } else {
                Button(action: {
                    self.audioPlayer.stopPlayback()
                }) {
                    Image(systemName: "stop.fill")
                        .imageScale(.large)
                }
            }
        }
        .buttonStyle(BorderlessButtonStyle())
    }
}

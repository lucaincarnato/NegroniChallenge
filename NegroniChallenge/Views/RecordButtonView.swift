//
//  RecordButtonView.swift
//  NegroniChallenge
//
//  Created by Jesus Sebastian Jaime Oviedo on 17/11/24.
//

import SwiftUI
import SwiftData

struct RecordButtonView: View {
    @Environment(\.modelContext) private var context
    @Environment(AudioRecorder.self) private var audioRecorder : AudioRecorder
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray, lineWidth: 3)
                .frame(width: 60, height: 60)
            Button(action: {
                withAnimation(.easeOut(duration: 0.3)) {
                    if !audioRecorder.isRecording {
                        audioRecorder.record()
                    }else {
                        audioRecorder.stopRecording {
                            fileName in
                            guard let fileName else { print("The recording was not saved")
                                return
                            }
                            
                            let uuid = UUID()
                            let newTitle = "\(uuid).wav"
                            let transcript = ""
                            
                            let recording = Recording(id : uuid , title: newTitle, fileName: fileName, transcript: transcript, createdAt: Date())
                            context.insert(recording)
                            
                            do {
                                try context.save()
                            } catch {
                                print("Error saving: \(error.localizedDescription)")
                            }
                            
                        } 
                    }
                }
            }, label: {
                if audioRecorder.isRecording {
                    AudioWaveformView(waveformData: audioRecorder.audioPowerData)
                        .frame(width: 30, height: 50)
                }else {
                    Image(systemName: "mic.circle.fill")
                        .font(.system(size: 50))
                        .foregroundStyle(.red)
                }
            })
        }
    }
}

#Preview ("Idle state"){
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Recording.self,configurations: config)
    let audioRecorder = AudioRecorder()
    return RecordButtonView()
        .environment(audioRecorder)
        .modelContainer(container)
}

#Preview ("Recording state"){
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Recording.self,configurations: config)
    let audioRecorder = AudioRecorder()
    
    audioRecorder.isRecording = true
    audioRecorder.audioPowerData = [0.1,0.2,0.3,0.4,0.5]
    
    return RecordButtonView()
        .environment(audioRecorder)
        .modelContainer(container)
}

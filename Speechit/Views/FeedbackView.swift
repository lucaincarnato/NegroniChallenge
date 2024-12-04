//
//  FeedbackView.swift
//  NegroniChallenge
//
//  Created by Luca Maria Incarnato on 19/11/24.
//

import SwiftUI

struct FeedbackView: View {
    // Variables for the two text that will be checked
    @State var actualSpeech: Speech
    @State var actualRehearsal: Rehearsal
    
    var body: some View {
        NavigationStack{
            // VStack for the placement of the two text boxes
            VStack{
                // ZStack for the overlay of background and content
                ZStack {
                    // Background
                    Color.gray
                        .opacity(0.1)
                        .ignoresSafeArea()
                    // Content
                    VStack{
                        // Button that allows recording's playback
                        Button{
                            let rehearsalManager = RehearsalManager()
                            rehearsalManager.playRecording(actualRehearsal.fileURL)
                        } label: {
                            Text("\(actualRehearsal.fileURL.lastPathComponent)")
                        }
                        .buttonStyle(.bordered)
                        // Speech text box
                        ZStack {
                            Rectangle()
                                .fill(Color.white)
                                .cornerRadius(15)
                            ScrollView{
                                Text(actualSpeech.text)
                                    .padding(20)
                                    .frame(maxWidth: .infinity, alignment: .topLeading)
                                    .font(.title)
                            }
                        }
                        .padding()
                        // Transcription text box
                        ZStack {
                            Rectangle()
                                .fill(Color.white)
                                .cornerRadius(15)
                            ScrollView{
                                Text(actualRehearsal.transcription)
                                    .padding(20)
                                    .frame(maxWidth: .infinity, alignment: .topLeading)
                                    .font(.title)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle(actualRehearsal.title)
        }
    }
}

//
//  FeedbackView.swift
//  NegroniChallenge
//
//  Created by Luca Maria Incarnato on 19/11/24.
//

import SwiftUI

struct FeedbackView: View {
    // Variables for the two text that will be checked
    @State var speechText: String
    @State var transcription: String
    
    var body: some View {
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
                    // Speech text box
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .cornerRadius(15)
                        ScrollView{
                            Text(speechText)
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
                            Text(transcription)
                                .padding(20)
                                .frame(maxWidth: .infinity, alignment: .topLeading)
                                .font(.title)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

//
//  FeedbackView.swift
//  NegroniChallenge
//
//  Created by Luca Maria Incarnato on 19/11/24.
//

import SwiftUI

struct FeedbackView: View {
    @State var speechText: String
    @State var transcription: String
    
    var body: some View {
            VStack{
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
                                Text(speechText)
                                    .padding(20)
                                    .frame(maxWidth: .infinity, alignment: .topLeading)
                                    .font(.title)
                            }
                        }
                        .padding()
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

#Preview {
    FeedbackView(speechText: "Hello, World!", transcription: "Hello, World!")
}

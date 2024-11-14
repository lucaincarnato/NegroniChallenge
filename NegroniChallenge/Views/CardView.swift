//
//  CardView.swift
//  NegroniChallenge
//
//  Created by Michele Barbato on 13/11/24.
//

import SwiftUI

struct CardView: View {
    var actualSpeech: SpeechModel // Speech associated with the card
    
    var body: some View {
        ZStack{
            // Info
            VStack{
                Text(actualSpeech.speechTitle)
                    .bold()
                    .font(.title2)
                    .frame(maxWidth: 100, maxHeight: 100, alignment: .center)
                Text(actualSpeech.dateOfPlay)
                HStack{
                    Image(systemName: "person.fill")
                    Text("\(actualSpeech.numberOfPeople)")
                }
                .padding([.top], 5)
            }
            // Background
            RoundedRectangle(cornerRadius:15)
                .foregroundColor(actualSpeech.cardColor)
                .opacity(0.5)
                .padding(10)
        }
        .frame(height: 250) // The height is fixed, the width depends on the device
    }
}

#Preview {
    CardView(actualSpeech: SpeechModel(speechTitle: "Amlet", cardColor: .blue, dateOfPlay: "31/02/2025", hourDuration: 1, minuteDuration: 20, secondDuration: 20, numberOfPeople: 2, instructions: "Be expressive", additionalNotes: ""))
}

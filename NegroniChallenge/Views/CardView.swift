//
//  CardView.swift
//  NegroniChallenge
//
//  Created by Michele Barbato on 13/11/24.
//

import SwiftUI

struct CardView: View {
    var speechTitle: String
    var dateOfPlay: String
    var numberOfPeople: Int
    var color: Color
    
    var body: some View {
        ZStack{
            // Info
            VStack{
                Text(speechTitle)
                    .bold()
                    .font(.largeTitle)
                    .padding([.bottom], 5)
                Text(dateOfPlay)
                HStack{
                    Image(systemName: "person.fill")
                    Text("\(numberOfPeople)")
                }
                .padding([.top], 5)
            }
            // Background
            RoundedRectangle(cornerRadius:15)
                .foregroundColor(color)
                .opacity(0.5)
                .padding(10)
        }
        .frame( height: 200) // The height is fixed, the width depends on the device
    }
}

#Preview {
    CardView(speechTitle: "Benigni", dateOfPlay: "13/11/24", numberOfPeople: 8, color: .red)
}

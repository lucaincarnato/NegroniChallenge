//
//  EditSpeechView.swift
//  NegroniChallenge
//
//  Created by Jesus Sebastian Jaime Oviedo on 12/11/24.
//

import Foundation

@Observable
class SpeechViewModel {
    // Data set for all the speeches available (in future needs to be connected with memory)
    var data: [SpeechModel] = [
        SpeechModel(speechTitle: "Amlet", cardColor: .blue, dateOfPlay: "31/02/2025", hourDuration: 1, minuteDuration: 20, secondDuration: 20, numberOfPeople: 2, instructions: "Be expressive", additionalNotes: ""),
        SpeechModel(speechTitle: "Romeo and Juliet", cardColor: .red, dateOfPlay: "31/02/2025", hourDuration: 1, minuteDuration: 20, secondDuration: 20, numberOfPeople: 2, instructions: "Be expressive", additionalNotes: ""),
        SpeechModel(speechTitle: "The merchant of Venice", cardColor: .cyan, dateOfPlay: "31/02/2025", hourDuration: 1, minuteDuration: 20, secondDuration: 20, numberOfPeople: 2, instructions: "Be expressive", additionalNotes: ""),
        SpeechModel(speechTitle: "Unconference #1", cardColor: .green, dateOfPlay: "31/02/2025", hourDuration: 1, minuteDuration: 20, secondDuration: 20, numberOfPeople: 2, instructions: "Be expressive", additionalNotes: ""),
        SpeechModel(speechTitle: "What's your name", cardColor: .yellow, dateOfPlay: "31/02/2025", hourDuration: 1, minuteDuration: 20, secondDuration: 20, numberOfPeople: 2, instructions: "Be expressive", additionalNotes: ""),
        SpeechModel(speechTitle: "WWDC 2025", cardColor: .brown, dateOfPlay: "31/02/2025", hourDuration: 1, minuteDuration: 20, secondDuration: 20, numberOfPeople: 2, instructions: "Be expressive", additionalNotes: ""),
    ]
}

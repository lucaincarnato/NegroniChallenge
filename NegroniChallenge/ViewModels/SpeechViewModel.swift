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
        SpeechModel(speechTitle: "Amlet", cardColor: .blue, dateOfPlay: Date.now, hourDuration: 1, minuteDuration: 20, secondDuration: 20, numberOfPeople: 2, instructions: "Be expressive", additionalNotes: ""),
        SpeechModel(speechTitle: "The merchant of Venice", cardColor: .green, dateOfPlay: Date.now, hourDuration: 1, minuteDuration: 20, secondDuration: 20, numberOfPeople: 2, instructions: "Be expressive", additionalNotes: ""),
        SpeechModel(speechTitle: "Romeo and Juliet", cardColor: .yellow, dateOfPlay: Date.now, hourDuration: 1, minuteDuration: 20, secondDuration: 20, numberOfPeople: 2, instructions: "Be expressive", additionalNotes: ""),
        SpeechModel(speechTitle: "WWDC25", cardColor: .cyan, dateOfPlay: Date.now, hourDuration: 1, minuteDuration: 20, secondDuration: 20, numberOfPeople: 2, instructions: "Be expressive", additionalNotes: ""),
        SpeechModel(speechTitle: "Unconference #1", cardColor: .red, dateOfPlay: Date.now, hourDuration: 1, minuteDuration: 20, secondDuration: 20, numberOfPeople: 2, instructions: "Be expressive", additionalNotes: "")
    ]
    
    func addSpeech(_ speech: SpeechModel) {
        data.append(speech)
    }
    
    func removeSpeech(_ speech: SpeechModel) {
        data.removeAll(where: { $0.speechTitle == speech.speechTitle })
    }
}

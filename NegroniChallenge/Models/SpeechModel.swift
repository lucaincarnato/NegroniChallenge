//
//  Speech.swift
//  NegroniChallenge
//
//  Created by Jesus Sebastian Jaime Oviedo on 12/11/24.
//

/*
 TO BE DONE:
 Change dateOfPlay's type into Date
 */

import Foundation
import SwiftUI

struct SpeechModel: Identifiable {
    var id: UUID = UUID()
    var speechTitle: String
    var cardColor: Color = .black
    var dateOfPlay: String
    // Duration of the speech in hours, minutes and seconds
    var hourDuration: Int
    var minuteDuration: Int
    var secondDuration: Int
    
    var numberOfPeople: Int // Number of people that act in the speech
    var instructions: String // Info for the stage (for example, gestures or space managment)
    var additionalNotes: String // Additional info (for example, budget or place)
}

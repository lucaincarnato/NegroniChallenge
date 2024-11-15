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
    var speechTitle: String // Required
    var cardColor: Color = .blue // Required
    var dateOfPlay: Date = Date.now // Required
    // Duration of the speech in hours, minutes and seconds
    var hourDuration: Int
    var minuteDuration: Int
    var secondDuration: Int
    // Actual body of the speech
    var speechText: String
    // Array of already done rehearsal
    var previousRecordings: [RecordingModel]
    var numberOfPeople: Int // (Required) Number of people that act in the speech
    var instructions: String // Info for the stage (for example, gestures or space managment)
    var additionalNotes: String // Additional info (for example, budget or place)
}

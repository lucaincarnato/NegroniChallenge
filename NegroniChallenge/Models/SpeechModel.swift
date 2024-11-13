//
//  Speech.swift
//  NegroniChallenge
//
//  Created by Jesus Sebastian Jaime Oviedo on 12/11/24.
//

import Foundation
import SwiftUI

struct SpeechModel: Identifiable {
    var id: UUID = UUID()
    var title: String
    var duration: String
    var instructions: String
    var notes: String
}

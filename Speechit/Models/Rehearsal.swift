//
//  RecordingModel.swift
//  NegroniChallenge
//
//  Created by Paola Barbuto Ferraiuolo on 14/11/24.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Rehearsal: Identifiable{
    var id: UUID = UUID()
    @Attribute(.unique) var fileURL: URL // Required
    var title: String = "SpeechitRehearsal"
    var dateOfRehearsal: Date = Date.now
    var transcription: String = ""
    
    // Initializer for default title
    init(_ fileURL: URL){
        self.fileURL = fileURL
        self.dateOfRehearsal = Date.now
        self.title = fileURL.lastPathComponent
    }
    
    // Initializer for custom title
    init(_ fileURL: URL, _ transcription: String){
        self.fileURL = fileURL
        self.dateOfRehearsal = Date.now
        self.transcription = transcription
    }
}

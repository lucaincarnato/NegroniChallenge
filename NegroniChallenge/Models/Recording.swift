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
class Recording: Identifiable {
    var id: UUID
    var title: String
    //var duration: String
    var fileName: String
    var transcript: String
    var createdAt = Date()
    
    init(id: UUID, title: String, fileName: String, transcript: String, createdAt: Date) {
        self.id = id
        self.title = title
        //self.duration = duration
        self.fileName = fileName
        self.transcript = transcript
        self.createdAt = createdAt
    }
}



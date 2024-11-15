//
//  RecordingModel.swift
//  NegroniChallenge
//
//  Created by Paola Barbuto Ferraiuolo on 14/11/24.
//

import Foundation
import SwiftUI

struct RecordingModel: Identifiable {
    let id: UUID = UUID()
    let title: String
    let duration: String // This should not be a string but we'll wait till we know how it is registered in memory
}



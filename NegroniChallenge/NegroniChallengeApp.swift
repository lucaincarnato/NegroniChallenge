//
//  NegroniChallengeApp.swift
//  NegroniChallenge
//
//  Created by Luca Maria Incarnato on 04/11/24.
//

import SwiftUI
import SwiftData

@main
struct NegroniChallengeApp: App {
    //@Environment(\.modelContext) var context
    //@Environment(AudioRecorder.self) private var audioRecorder : AudioRecorder
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        //.modelContainer (for : [Recording.self]) //fixes fatal error audiorecording
        
    }
}

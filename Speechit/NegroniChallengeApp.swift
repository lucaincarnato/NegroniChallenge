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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Speech.self)
    }
}

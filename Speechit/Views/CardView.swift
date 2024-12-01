//
//  CardView.swift
//  NegroniChallenge
//
//  Created by Michele Barbato on 13/11/24.
//

import SwiftUI

struct CardView: View {
    // Link to takes the file for sharing
    @State private var fileURL: URL?    
    // Speech associated with the card
    var actualSpeech: Speech
    // Function for the deletion, delegated the definition
    var remove: (_ speech: Speech) -> Void
    
    var body: some View {
        // ZStack for the overlay of card's background and its info
        ZStack{
            // Info
            VStack{
                Text(actualSpeech.title)
                    .bold()
                    .font(.title2)
                    .frame(maxHeight: 80, alignment: .center)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                Text(actualSpeech.date.formatted(date: .numeric, time: .shortened))
                HStack{
                    Image(systemName: "person.fill")
                    Text("\(actualSpeech.numberOfPeople)")
                }
                .padding(.vertical, 5)
            }
            // Background
            RoundedRectangle(cornerRadius:15)
                .foregroundColor(actualSpeech.getColor())
                .opacity(0.5)
                .padding(10)
        }
        // TODO: SEE IF ON OTHER SIZES IT CHANGES SOMETHING
        .frame(height: 250)
        // Creates the txt file when the card appears
        .onAppear {
            createTextFile()
        }
        // Allow the long press for the deletion and the share
        .contextMenu {
            // Delete
            Button (role: .destructive) {
                remove(actualSpeech)
            } label: {
                Label("Delete", systemImage: "trash")
            }
            // Share
            if let fileURL = fileURL {
                // ShareLink with the txt file already created
                ShareLink(item: fileURL, preview: SharePreview("Text file"))
                    .padding()
            } else {
                Text("Creating file...")
            }
        }
    }
    
    // NEED TO BE MOVED INTO VIEWMODEL
    // It creates the txt file from the actual Speech of the card
    private func createTextFile() {
        // Get temporary directory
        let tempDir = FileManager.default.temporaryDirectory
        // Define file .txt's path
        let filePath = tempDir.appendingPathComponent("\(actualSpeech.title).json")
        do {
            // Writes the text in the file
            try actualSpeech.text.write(to: filePath, atomically: true, encoding: .utf8)
            // Assign file's URL to state variable
            self.fileURL = filePath
        } catch {
            print("Error while creating the file \(error)")
        }
    }
}

//
//  CardView.swift
//  NegroniChallenge
//
//  Created by Michele Barbato on 13/11/24.
//

import SwiftUI

struct CardView: View {
    @State private var fileURL: URL? // txt file's URL
    
    var actualSpeech: SpeechModel // Speech associated with the card
    var remove: (_ speech: SpeechModel) -> Void // Function for the deletion, delegated the definition
    
    var body: some View {
        ZStack{
            // Info
            VStack{
                Text(actualSpeech.speechTitle)
                    .bold()
                    .font(.title2)
                    .frame(maxHeight: 100, alignment: .center)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                Text(actualSpeech.dateOfPlay.formatted(date: .numeric, time: .shortened))
                HStack{
                    Image(systemName: "person.fill")
                    Text("\(actualSpeech.numberOfPeople)")
                }
                .padding([.top], 5)
            }
            // Background
            RoundedRectangle(cornerRadius:15)
                .foregroundColor(actualSpeech.cardColor)
                .opacity(0.5)
                .padding(10)
        }
        // The height is fixed, the width depends on the device
        .frame(height: 250)
        // Creates the txt file when the link appears
        .onAppear {
            createTextFile()
        }
        // Allow the long press for the deletion and the share
        .contextMenu {
            Button (role: .destructive) {
                remove(actualSpeech)
            } label: {
                Label("Delete", systemImage: "trash")
            }
            if let fileURL = fileURL {
                // ShareLink with the txt file already created
                ShareLink(item: fileURL, preview: SharePreview("File di testo"))
                    .padding()
            } else {
                Text("Creazione file in corso...")
            }
        }
    }
    
    // NEED TO BE MOVED INTO VIEWMODEL
    // It creates the txt file from the actual Speech of the card
    private func createTextFile() {
        // Get temporary directory
        let tempDir = FileManager.default.temporaryDirectory
        // Define file .txt's path
        let filePath = tempDir.appendingPathComponent("\(actualSpeech.speechTitle)BlaBlaBla.txt")
        do {
            // Writes the text in the file
            try actualSpeech.speechText.write(to: filePath, atomically: true, encoding: .utf8)
            // Assign file's URL to state variable
            self.fileURL = filePath
        } catch {
            print("Error while creating the file \(error)")
        }
    }
}

#Preview {
    CardView(actualSpeech: SpeechModel(
        speechTitle: "Poesia per Natale",
        cardColor: .blue,
        dateOfPlay: Date.now,
        hourDuration: 0,
        minuteDuration: 0,
        secondDuration: 40,
        speechText: """
        Se ni’ mondo esistesse un po’ di bene
        e ognun si honsiderasse suo fratello
        ci sarebbe meno pensieri e meno pene
        e il mondo ne sarebbe assai più bello
        """,
        previousRecordings: [
            RecordingModel(title: "Recording1", duration: "10"),
            RecordingModel(title: "Recording1", duration: "10"),
            RecordingModel(title: "Recording1", duration: "10")
        ],
        numberOfPeople: 2,
        instructions: "Be expressive",
        additionalNotes: ""
    ), remove: {speech in })
}

//
//  EditView.swift
//  NegroniChallenge
//
//  Created by Jesus Sebastian Jaime Oviedo on 12/11/24.
//


/*
 TO BE DONE:
 Adding date picker
 */

import SwiftUI

struct NewSpeechView: View {
    // Speech speech starting point
    @State var actualSpeech: SpeechModel = SpeechModel(
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
    )
    @Binding var showModal: Bool
    @State var cannotSave: Bool = false
    var add: (_ speech: SpeechModel) -> Void
    var body: some View {
        NavigationStack {
            Form {
                // Title and card color selection
                Section {
                    LabeledContent("Title") {
                        TextField("Required", text: $actualSpeech.speechTitle)
                    }
                    LabeledContent("Select a color") {
                        ColorPicker("", selection: $actualSpeech.cardColor)
                            .pickerStyle(.automatic)
                    }
                }
                // Duration (in h/min/sec) and number of people selection
                Section {
                    LabeledContent("Date") {
                        DatePicker("", selection: $actualSpeech.dateOfPlay)
                            .datePickerStyle(.compact)
                    }
                    LabeledContent("Duration") {
                        Picker("Hours", selection: $actualSpeech.hourDuration){
                            ForEach(0..<24) {
                                Text("\($0) h")
                            }
                        }
                        .pickerStyle(.wheel)
                        Picker("Minutes", selection: $actualSpeech.minuteDuration){
                            ForEach(0..<60) {
                                Text("\($0) min")
                            }
                        }
                        .pickerStyle(.wheel)
                        Picker("Seconds", selection: $actualSpeech.secondDuration){
                            ForEach(0..<60) {
                                Text("\($0) sec")
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                    .frame(height: 100)
                    LabeledContent("Number of people") {
                        Stepper(value: $actualSpeech.numberOfPeople, in: 0...10) {
                            Text("\(actualSpeech.numberOfPeople)")
                        }
                    }
                }
                // Additional info selection
                Section(header: Text("Stage instructions")){
                    TextField("Optional", text: $actualSpeech.instructions)
                        .frame(minHeight: 100, alignment: .topLeading)
                        .padding([.top], 5)
                }
                Section(header: Text("Additional Notes")){
                    TextField("Optional", text: $actualSpeech.additionalNotes)
                        .frame(minHeight: 100, alignment: .topLeading)
                        .padding([.top], 5)
                }
            }
            .navigationTitle("New Speech")
            // Checks for changes and validates input, then add; otherwise it shows an alert
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Next") {
                        // Adds only if the title is not empty and if the date is not on the past
                        if(actualSpeech.speechTitle != "" && actualSpeech.dateOfPlay > Date.now){
                            add(actualSpeech)
                        } else {
                            cannotSave.toggle()
                        }
                    }
                    .alert("Something \nwent wrong", isPresented: $cannotSave) {
                        Button("OK", role: .cancel) {
                            cannotSave.toggle()
                        }
                    }
                }
                // Shows action sheet if there's been changes
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        showModal.toggle()
                    }
                }
            }
        }
    }
}

#Preview{
    NewSpeechView(actualSpeech: SpeechModel(
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
    ),showModal: .constant(true), add: {speech in })
}

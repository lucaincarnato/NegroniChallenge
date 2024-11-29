//
//  EditView.swift
//  NegroniChallenge
//
//  Created by Jesus Sebastian Jaime Oviedo on 12/11/24.
//

import SwiftUI

struct NewSpeechView: View {
    // Default speech
    @State var actualSpeech: Speech = Speech("", .red, Date.now)
    // Placeholder for the color
    @State var color: Color = .red
    // Boolean variable for the modality
    @Binding var showModal: Bool
    // Boolean variable that allows to save if speech is not default
    @State var cannotSave: Bool = false
    // Function for the add, delegated the definition
    var add: (_ speech: Speech) -> Void
    
    var body: some View {
        NavigationStack {
            // Allows the user to insert infos
            Form {
                // Title and card color selection
                Section {
                    LabeledContent("Title") {
                        TextField("Required", text: $actualSpeech.title)
                    }
                    LabeledContent("Select a color") {
                        ColorPicker("", selection: $color)
                            .pickerStyle(.automatic)
                    }
                }
                // Duration (in h/min/sec) and number of people selection
                Section {
                    LabeledContent("Date") {
                        DatePicker("", selection: $actualSpeech.date, in: Date.now...)
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
                    TextField("Optional", text: $actualSpeech.stageInstructions)
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
                        if(actualSpeech.isNotDefault()){
                            actualSpeech.setColor(color)
                            add(actualSpeech)
                            showModal.toggle()
                        } else {
                            cannotSave.toggle()
                        }
                    }
                    // Alerts the user when it cannot save 
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

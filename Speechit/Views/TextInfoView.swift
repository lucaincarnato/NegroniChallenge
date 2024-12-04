//
//  TextInfoView.swift
//  NegroniChallenge
//
//  Created by Luca Maria Incarnato on 18/11/24.
//

import SwiftUI

struct TextInfoView: View {
    // Link to memory in order to retreive data
    @Environment(\.modelContext) private var context
    // Speech speech starting point
    @State var actualSpeech: Speech
    // Placeholder for the color
    @State var color: Color = .red
    // Boolean variable for the modality
    @Binding var infoModal: Bool
    // Boolean variable for the edit mode
    @State var editMode: Bool = false
    
    var body: some View {
        NavigationStack{
            // Shows the edit mode only when it is toggled
            if(!editMode){
                VStack{
                    // List of information that need to be displayed
                    List{
                        Section(header: Text("Date")){
                            Text(actualSpeech.date.formatted(.dateTime))
                        }
                        Section(header: Text("Duration")){
                            Text("\(actualSpeech.hourDuration)h:\(actualSpeech.minuteDuration)min:\(actualSpeech.secondDuration)s")
                        }
                        Section(header: Text("Number of people")){
                            Text("\(actualSpeech.numberOfPeople)" + " people")
                        }
                        // Additional info selection
                        Section(header: Text("Stage instructions")){
                            Text(actualSpeech.stageInstructions)
                                .frame(minHeight: 100, alignment: .topLeading)
                                .padding([.top], 5)
                        }
                        Section(header: Text("Additional Notes")){
                            Text(actualSpeech.additionalNotes)
                                .frame(minHeight: 100, alignment: .topLeading)
                                .padding([.top], 5)
                        }
                    }
                }
                .navigationTitle(actualSpeech.title)
                // Toolbar for the edit and the cancel actions
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing){
                        Button("Edit"){
                            editMode.toggle()
                        }
                    }
                    ToolbarItem(placement: .cancellationAction){
                        Button("Cancel", role: .cancel){
                            infoModal.toggle()
                        }
                    }
                }
            } else {
                // List of information that need to be edited
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
                            DatePicker("", selection: $actualSpeech.date)
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
                // Toolbar for the saving and the canceling actions
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing){
                        Button("Save"){
                            // The color isn't directly connected to the object for simulation purposes
                            actualSpeech.setColor(color)
                            try? context.save()
                            editMode.toggle()
                        }
                    }
                    ToolbarItem(placement: .cancellationAction){
                        Button("Cancel", role: .cancel){
                            editMode.toggle()
                        }
                    }
                }
            }
        }
    }
}

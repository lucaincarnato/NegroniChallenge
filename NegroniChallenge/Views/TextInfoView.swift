//
//  TextInfoView.swift
//  NegroniChallenge
//
//  Created by Luca Maria Incarnato on 18/11/24.
//

import SwiftUI

struct TextInfoView: View {
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
            RecordingModel(title: "Recording2", duration: "10"),
            RecordingModel(title: "Recording2", duration: "10"),
            RecordingModel(title: "Recording2", duration: "10"),
            RecordingModel(title: "Recording2", duration: "10"),
            RecordingModel(title: "Recording2", duration: "10"),
            RecordingModel(title: "Recording2", duration: "10"),
            RecordingModel(title: "Recording2", duration: "10"),
            RecordingModel(title: "Recording3", duration: "10")
        ],
        numberOfPeople: 2,
        instructions: "Be expressive",
        additionalNotes: ""
    )
    @Binding var infoModal: Bool
    @State var editMode: Bool = false
    
    var body: some View {
        NavigationStack{
            if(!editMode){
                VStack{
                    List{
                        Section(header: Text("Color")){
                            Text(actualSpeech.dateOfPlay.formatted(.dateTime))
                        }
                        Section(header: Text("Date")){
                            Text(actualSpeech.dateOfPlay.formatted(.dateTime))
                        }
                        Section(header: Text("Duration")){
                            Text("\(actualSpeech.hourDuration)h:\(actualSpeech.minuteDuration)min:\(actualSpeech.secondDuration)s")
                        }
                        Section(header: Text("Number of people")){
                            Text("\(actualSpeech.numberOfPeople)" + " people")
                        }
                        // Additional info selection
                        Section(header: Text("Stage instructions")){
                            Text(actualSpeech.instructions)
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
                .navigationTitle(actualSpeech.speechTitle)
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
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing){
                        Button("Save"){
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

#Preview {
    TextInfoView(infoModal: .constant(true))
}

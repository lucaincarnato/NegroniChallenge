//
//  EditView.swift
//  NegroniChallenge
//
//  Created by Jesus Sebastian Jaime Oviedo on 12/11/24.
//

import SwiftUI

struct NewSpeechView: View {
    @State var title: String = "" //has to be changed
    @State var numberOfPeople: Int = 1
    @State var hour: Int = 0
    @State var minutes: Int = 0
    @State var speaker: String = ""
    @State var cardColor: Color = .red
    
    var body: some View {
        NavigationStack {
            Form {
                // Title and card color selection
                Section {
                    LabeledContent("Title") {
                        TextField("Required", text: $title)
                    }
                    LabeledContent("Select a color") {
                        ColorPicker("", selection: $cardColor)
                            .pickerStyle(.automatic)
                    }
                }
                // Duration (in h/min/sec) and number of people selection
                Section {
                    LabeledContent("Duration") {
                        Picker("Minutes", selection: $title){
                            ForEach(0..<24) {
                                Text("\($0) h")
                            }
                        }
                        .pickerStyle(.wheel)
                        Picker("Minutes", selection: $title){
                            ForEach(0..<60) {
                                Text("\($0) min")
                            }
                        }
                        .pickerStyle(.wheel)
                        Picker("Seconds", selection: $title){
                            ForEach(0..<60) {
                                Text("\($0) sec")
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                    LabeledContent("Number of people") {
                        Stepper(value: $numberOfPeople, in: 0...10) {
                            Text(numberOfPeople.formatted(.number))
                        }
                    }
                }
                // Additional info selection
                Section {
                    LabeledContent(""){
                        TextField("Stage Instructions", text: $title)
                            .frame(minHeight: 100, alignment: .topLeading)
                            .padding([.top], 5)
                    }
                    LabeledContent(""){
                        TextField("Additional Notes", text: $title)
                            .frame(minHeight: 100, alignment: .topLeading)
                            .padding([.top], 5)
                    }
                }
            }
            .navigationTitle("New Speech")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        print("Pressed")
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        print("Pressed")
                    }
                }
            }
        }
    }
}


#Preview {
    NewSpeechView()
}

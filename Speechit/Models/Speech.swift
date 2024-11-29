//
//  Speech.swift
//  NegroniChallenge
//
//  Created by Jesus Sebastian Jaime Oviedo on 12/11/24.
//

/*
 TO BE DONE:
 Change dateOfPlay's type into Date
 */

import Foundation
import SwiftUI
import SwiftData

@Model
class Speech: Identifiable{
    var id: UUID = UUID()
    @Attribute(.unique) var title: String = "" // Required
    var date: Date = Date.now // Required to be not in past
    
    // Info about the color. Required, custom because SwiftData doesn't support SwiftUI/Color
    var red: CGFloat = 0.9921568632125854
    var green: CGFloat = 0.7803921699523926
    var blue: CGFloat = 0.0
    var alpha: CGFloat = 0.0
    
    
    // h:min:s for the duration of the speech
    var hourDuration: Int = 0
    var minuteDuration: Int  = 0
    var secondDuration: Int = 0
    
    // How many people act in the speech
    var numberOfPeople: Int = 1
    
    // Additional information
    var stageInstructions: String = ""
    var additionalNotes: String = ""
    
    // Speech text
    var text: String = ""
    
    // Previous rehearsals
    var rehearsals: [Rehearsal] = []
    
    // Initializer for minimum requirements
    init(_ title: String, _ color: Color, _ date: Date){
        self.title = title
        setColor(color)
        if(date > Date.now) {
            self.date = date
        }
    }
    
    // Initializer for full data
    init(_ title: String, _ color: Color, _ date: Date, _ hourDuration: Int, _ minuteDuration: Int, _ secondDuration: Int, _ numberOfPeople: Int, _
        stageInstructions: String, _ additionalNotes: String){
        @Environment(\.self) var environment
        self.title = title
        setColor(color)
        if(date > Date.now) {self.date = date}
        self.hourDuration = hourDuration
        self.minuteDuration = minuteDuration
        self.secondDuration = secondDuration
        self.numberOfPeople = numberOfPeople
        self.stageInstructions = stageInstructions
        self.additionalNotes = additionalNotes
    }
    
    // Checks if the actual object has been changed, to avoid having the defalut values
    func isNotDefault() -> Bool{
        if(self.title == "" && date < Date.now) {return false}
        return true
    }
    
    func getColor() -> Color{
        print(Color(red: self.red, green: self.green, blue: self.blue, opacity: self.alpha))
        return Color(red: self.red, green: self.green, blue: self.blue, opacity: self.alpha)
    }
    
    func setColor(_ color: Color){
        let colorBuffer = UIColor(color)
        colorBuffer.getRed(&self.red, green: &self.green, blue: &self.blue, alpha: &self.alpha)
    }
}

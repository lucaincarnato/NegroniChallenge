//
//  AudioWaveformView.swift
//  NegroniChallenge
//
//  Created by Jesus Sebastian Jaime Oviedo on 17/11/24.
//

import SwiftUI

struct AudioWaveformView: View {
    var waveformData : [CGFloat]
    
    //create var for values to bars
    private let barWidth: CGFloat = 3
    private let spacing: CGFloat = 2
    
    var body: some View {
        HStack (spacing:spacing) {
            Spacer()
            if waveformData.count >= 6 {
                ForEach(waveformData.indices, id:\.self) { index in
                    BarView(value : waveformData[index])
                        .frame(width: barWidth)
                }
            }
            Spacer()
        }
    }
}

struct BarView : View {
    var value : CGFloat
    private let height: CGFloat = 25
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.blue.opacity(value))
            .frame(height: value*height)
            .animation(.easeInOut(duration: 0.1), value: value)
    }
}

#Preview {
    AudioWaveformView(waveformData: [
        CGFloat(0.2),
        CGFloat(0.6),
        CGFloat(0.2),
        CGFloat(0.6),
        CGFloat(0.2),
        CGFloat(0.6)
    ])
}

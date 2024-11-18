//
//  AudioRecorder.swift
//  NegroniChallenge
//
//  Created by Jesus Sebastian Jaime Oviedo on 15/11/24.
//

import Foundation
import AVFoundation

@Observable
class AudioRecorder : NSObject {
    var isRecording: Bool = false
    var hasMicAccess: Bool = false
    var showMicAccessAlert: Bool = false
    var audioPowerData: [CGFloat] = []
    
    var audioRecorder: AVAudioRecorder?
    var timer: Timer?
    
    private func requestMicrophoneAccess() {
        AVAudioApplication.requestRecordPermission { granted in
            if granted {
                self.hasMicAccess = true
            }else {
                self.showMicAccessAlert = true
            }
        }
    }
    
    // normalizes output saved audio to better understanding AI
    private func normalizedAudioPower(power: Float) -> CGFloat {
        let minDb : Float = -80.0
        if power < minDb {
            return 0.0
        }
        if power > minDb {
            return 1.0
        }
        return CGFloat( (abs(minDb)-abs(power)) / abs(minDb) )
    }
    
    private func updateWavefrom() {
        guard let recorder = self.audioRecorder else { return }
        recorder.updateMeters()
        
        recorder.updateMeters()
        let averagePower = recorder.averagePower(forChannel: 0)
        self.audioPowerData.append(normalizedAudioPower(power: averagePower))
        
        if self.audioPowerData.count > 6 {
            self.audioPowerData.removeFirst()
        }
    }
    
    func setup() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
            
            //lets take the setting
            let settings: [String: Any] = [
                AVFormatIDKey : Int(kAudioFormatLinearPCM), //no AAC still
                AVSampleRateKey : 44100.0,
                AVNumberOfChannelsKey : 1,
                AVEncoderAudioQualityKey : AVAudioQuality.high.rawValue
            ]
            
            self.audioRecorder = try AVAudioRecorder(url: FileSystemManager.getRecordingTempURL(), settings: settings)
            self.audioRecorder?.isMeteringEnabled = true
            
            //
            self.audioRecorder?.delegate = self
            
            //finally asking access mic function
            self.requestMicrophoneAccess()
            
        } catch {
            print("error setting up audio session: \(error.localizedDescription)")
        }
    }
    
    func record() {
        if hasMicAccess {
            self.audioPowerData.removeAll()
            self.audioRecorder?.record()
            self.isRecording = true
            
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: {_ in
                self.updateWavefrom()
            })
        } else {
            self.requestMicrophoneAccess()
        }
    }
    
    func stopRecording(completion: (String?) -> Void)  {
        self.audioRecorder?.stop()
        
        let fileName = FileSystemManager.saveRecordingFile()
        completion(fileName)
        
        self.isRecording = false
        
    }
}


extension AudioRecorder : AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        self.isRecording = false
        
        if let timer = self.timer, timer.isValid {
            timer.invalidate()
        }
        
        self.audioPowerData.removeAll()
    }
}

//
//  RehearsalManager.swift
//  Speechit
//
//  Created by Luca Maria Incarnato on 30/11/24.
//

import Foundation
import SwiftUI
import AVFAudio
import Speech

// TODO: REFACTOR
class RehearsalManager: NSObject, ObservableObject, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    // Speech the user is rehearsing
    @Published var actualSpeech: Speech?
    // Helps the UI adapt based on the recording state
    @Published var isRecording = false
    // References to the future AudioRecorder and AudioPlayer object (can be nil, hopefully won't)
    private var audioRecorder: AVAudioRecorder?
    private var audioPlayer: AVAudioPlayer?
    // String for the recording's name
    @Published var recordingName: String = ""
    // Buffer to pass the recording's url through methods
    private var bufferURL: URL?
    
    // Pointer to the directory where the recordings will be saved (creates if not found)
    private let recordingsDirectory: URL = {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Recordings")
        try? FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        return directory
    }()
    
    // Responsible for setting up the app's audio session
    func configureAudioSession() {
        // Get the shared instance of the audio session
        let audioSession = AVAudioSession.sharedInstance()
        do {
            // Configures the type of use for the audio session
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker])
            try audioSession.setActive(true)
        } catch {
            print("Error in audio session's configuration: \(error.localizedDescription)")
        }
    }
    
    // Allows the user to start record its voice while rehearsing
    func startRecording() {
        // Creates a placeholder file name for the recording and appends it to the recordingsDirectory
        let audioFilename = recordingsDirectory.appendingPathComponent("SpeechitRehearsal_\(recordingName).m4a")
        bufferURL = audioFilename // MARK: CHE SERVE?
        // Defines a dictionary with settings for the recording
        let settings: [String: Any] = [
            AVFormatIDKey: kAudioFormatMPEG4AAC, // Audio format
            AVSampleRateKey: 44100, // Sample rate (in kHz)
            AVNumberOfChannelsKey: 1, // Number of channels
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue // Quality of audio encoder
        ]
        // Exception handling
        do {
            // Creates an AVAudioRecorder instance with the specified file URL and settings
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            // Assigns a delegate (if needed) to handle events like errors or recording completion
            audioRecorder?.delegate = self
            // Begins recording audio
            audioRecorder?.record()
            isRecording = true
        } catch {
            print("Error during registration: \(error.localizedDescription)")
        }
    }
    
    // Stops the recording of user's rehearsal
    func stopRecording(_ customName: String) {
        // Stops recording the audio
        audioRecorder?.stop()
        isRecording = false
        // Assign custom name to recording's name buffer
        recordingName = customName
        // Creates a Rehearsal object and translate the text
        let rehearsal = Rehearsal(renameRecording(customName))
        transcribeRecording(rehearsal.fileURL, rehearsal)
    }
    
    // Pauses the recording of user's rehearsal
    func pauseRecording(){
        // Pauses recording the audio
        audioRecorder?.pause()
        isRecording = false
    }
    
    // Allows the user to rename the recording (and so rehearsal), returns the new url in order to append to speech
    private func renameRecording(_ customName: String) -> URL {
        // Get recording's name buffer and creates the url
        let newURL = recordingsDirectory.appendingPathComponent("\(customName).m4a")
        // Exception handling
        do {
            // Moves the data in (the old) url to the new url
            try FileManager.default.moveItem(at: bufferURL!, to: newURL)
            return newURL
        } catch {
            print("Error while renaming recording: \(error.localizedDescription)")
            return bufferURL!
        }
        // MARK: BAD PRACTICE, UNWRAPPING bufferURL
    }
    
    // Transcribe rehearsal's recording and update its transcription
    func transcribeRecording(_ url: URL, _ rehearsal: Rehearsal) {
        // Instantiate a new Speech Recognizer with the device default language
        let speechRecognizer = SFSpeechRecognizer()
        // Get or request the authorization
        guard SFSpeechRecognizer.authorizationStatus() == .authorized else {
            SFSpeechRecognizer.requestAuthorization { status in
                if status != .authorized {
                    print("Speech recognition not authorized")
                }
            }
            return
        }
        // Instantiate and set up the request to recognize speech in the recorded audio file
        let recognitionRequest = SFSpeechURLRecognitionRequest(url: url)
        recognitionRequest.shouldReportPartialResults = false // Return also intermediate results
        recognitionRequest.requiresOnDeviceRecognition = false // Send data into the network to transcribe
        recognitionRequest.taskHint = .dictation // Type of speech recognition
        // Start recognition task
        speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
            if let result = result {
                // Associates transcription to rehearsal if results are present
                rehearsal.transcription = result.bestTranscription.formattedString
                self.actualSpeech?.rehearsals.append(rehearsal)
            } else if let error = error {
                print("Transcription error: \(error.localizedDescription)")
            }
        }
    }

    // Plays user's rehearsal
    func playRecording(_ url: URL) {
        // Exception handling
        do {
            // Creates an AVAudioPlayer instance with the specified file URL to allow playing
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            // Plays specified file
            audioPlayer?.play()
        } catch {
            print("Error while playing recording: \(error.localizedDescription)")
        }
    }
    
    // Custom initializer
    override init(){
        super.init()
        // Sets up audio session
        configureAudioSession()
    }
}

//
//  FileSystemManager.swift
//  NegroniChallenge
//
//  Created by Jesus Sebastian Jaime Oviedo on 15/11/24.
//

import Foundation

class FileSystemManager {
    enum FSError: Error {
        case failedToGetDocumentDir
        case failedToGetRecordingsDir
        case failedToSaveRecording
    }
    static var documentDirectory: URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    static func getRecordingTempURL() -> URL {
        let tempDir = FileManager.default.temporaryDirectory
        let filePath = "tempRecording.caf"
        return tempDir.appendingPathComponent(filePath)
    }
    static func getRecordingsDirectoryURL() -> URL? {
        guard let dir = documentDirectory else { return nil }
        return dir.appending(path: "recordings")
    }
    static func makerecordingsDirectory() throws {
        guard let dir = getRecordingsDirectoryURL() else { throw FSError.failedToGetRecordingsDir }
        do {
            try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        } catch {
            throw FSError.failedToGetRecordingsDir
        }
    }
    static func isRecordingsDirectoryPresent() -> Bool {
        guard let recordingsDirectoryURL = self .getRecordingsDirectoryURL() else { return false }
        var isDirectory: ObjCBool = false
        
        return FileManager.default.fileExists(atPath: recordingsDirectoryURL.path, isDirectory: &isDirectory)
        && isDirectory.boolValue
    }
    
    static func saveRecordingFile() -> String? {
        let tempURL = getRecordingTempURL()
        let fileName = UUID().uuidString + "." + tempURL.pathExtension
        
        if(!self.isRecordingsDirectoryPresent()) {
            do {
                try self.makerecordingsDirectory()
            } catch {
                return nil
            }
        }
        
        guard let recordingsDir = self.getRecordingsDirectoryURL() else { return nil }
        let target = recordingsDir.appending(path: fileName)
        
        do {
            try FileManager.default.moveItem(at: tempURL, to: target)
        } catch {
            return nil
        }
        
        return fileName
    }
    
    static func getRecordingURL(_ fileName: String) -> URL? {
        guard let dir = getRecordingsDirectoryURL() else { return nil }
        return dir.appendingPathComponent(fileName)
    }
}

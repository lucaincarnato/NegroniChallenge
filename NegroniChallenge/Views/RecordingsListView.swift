//
//  RecordingsListView.swift
//  NegroniChallenge
//
//  Created by Jesus Sebastian Jaime Oviedo on 15/11/24.
//

import SwiftUI
import SwiftData

struct RecordingsListView: View {
    @Environment(\.modelContext) var context
    @Environment(AudioRecorder.self) private var audioRecorder : AudioRecorder
    
    @Query(sort: \Recording.createdAt, order: .reverse) var allRecordings: [Recording]
    
    var body: some View {
        if(allRecordings.isEmpty) {
            ContentUnavailableView("No recordings yet", systemImage: "Waveform")
        }else {
            List {
                ForEach(allRecordings) { recording in
                    VStack(alignment: .leading) {
                        Text(recording.title)
                            .font(.headline)
                        //show date
                        Text(recording.createdAt.formatted(.dateTime))
                            
                    }
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        context.delete(allRecordings[index])
                    }
                    do {
                        try context.save()
                    } catch {
                        print("Error: \(error.localizedDescription)")
                    }
                }
                
                
            }
            
        }
        
        //mic section
        VStack {
            Spacer()
            VStack (alignment:.center) {
                RecordButtonView()
            }
            .padding(.bottom,0)
            .frame(maxWidth:.infinity) //it expands
            .frame(height:120)
            .background(Color.clear)
        }
    }
}

// Function to create a pre-populated model container
@MainActor private func createPreviewModelContainer() -> ModelContainer {
    do {
        let container = try ModelContainer(for: Recording.self)
        let context = container.mainContext
        
        // Sample data
        let sampleRecordings = [
            Recording(
                id: UUID(),
                title: "Team Meeting",
                fileName: "team_meeting.m4a",
                transcript: "Discussion about sprint planning...",
                createdAt: Date()
            ),
            Recording(
                id: UUID(),
                title: "Design Review",
                fileName: "design_review.m4a",
                transcript: "Feedback on the new app design...",
                createdAt: Date().addingTimeInterval(-3600 * 24) // 1 day ago
            )
        ]
        
        // Insert sample data
        sampleRecordings.forEach { context.insert($0) }
        try context.save()
        
        return container
    } catch {
        fatalError("Failed to create preview model container: \(error)")
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Recording.self  ,configurations: config)
    let audioRecorder = AudioRecorder()
    
    
    //RecordingsListView().modelContainer(createPreviewModelContainer())
    
    return NavigationStack { RecordingsListView()
            .navigationTitle("Recordings")
    }
    .task {
        audioRecorder.setup()
    }
    .environment(audioRecorder)
    .modelContainer(container)
}


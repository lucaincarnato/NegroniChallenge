//
//  TextSpeechView.swift
//  NegroniChallenge
//
//  Created by Paola Barbuto Ferraiuolo on 14/11/24.
//

import SwiftUI

struct TextSpeechView : View {
    @State var text: String =  """
                                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi pharetra dolor vitae hendrerit imperdiet. Mauris sed sem ut lacus lacinia placerat egetbdisvbfsdivbaoivhadsivhdsailhvalsik
                                
                                eget sapien. Praesent dolor lectus, pretium a accumsan ac, malesuada eu leo. Aenean aliquam ultrices arcu vitae suscipit. Suspendisse tristique aliquet odio, id convallis metus ultricies id. Aenean sollicitudin dictum tempor. Etiam condimentum magna nisl, et iaculis lectus pretium at. Nam lacus nunc, viverra bibendum malesuada at, porttitor sit amet nisl. Duis mattis ex vel mauris porta, ut scelerisque orci feugiat. Cras rhoncus efficitur suscipit. Aliquam a ante turpis. Quisque dictum odio sed ligula bibendum consequat id vel turpis.

                                Ut in ligula risus. Praesent ac pellentesque velit. Maecenas vel erat augue. Donec varius dolor nulla, at egestas nunc molestie ut. Nunc pharetra eleifend urna quis commodo. Etiam euismod aliquet diam quis convallis. Morbi bibendum ullamcorper erat at vehicula. Integer at tempus nisl. Praesent cursus malesuada eros, at ultrices justo malesuada et. Sed id fringilla orci. Duis in maximus lorem.

                                Curabitur tempor feugiat elementum. Etiam vel congue tellus. Donec eget hendrerit felis, ut dictum arcu. Nulla vel elementum leo. Vestibulum porta rhoncus tellus, non pretium augue ornare a. Cras blandit finibus urna, sed rutrum tortor interdum a. Sed cursus enim sed massa lacinia viverra. Ut eget tristique neque. In blandit quam non imperdiet laoreet. Etiam tincidunt mi vitae sapien egestas ornare.

                                Nulla fringilla, purus at fringilla tincidunt, mauris diam vehicula ex, ac semper eros arcu a ex. Sed placerat sapien nec malesuada efficitur. Nullam eleifend sodales tellus, et tempor massa condimentum ut. Vivamus sed sagittis nisi, eget tempor sapien. Interdum et malesuada fames ac ante ipsum primis in faucibus. Quisque lobortis magna at turpis bibendum laoreet nec auctor arcu. Quisque hendrerit, elit eu pharetra gravida, augue tortor consectetur ex, id porttitor diam ligula luctus enim.

                                Maecenas vestibulum gravida iaculis. Morbi sed ex sem. Nullam fermentum quam nec interdum dignissim. Sed mattis augue ac lorem molestie ornare. Quisque interdum elementum mollis. Donec a commodo leo. Aliquam tempor pulvinar justo, vel venenatis enim vulputate vel. Proin laoreet, leo a auctor cursus, mi quam fringilla ligula, vitae rhoncus felis augue in augue. Donec nibh metus, condimentum non lectus in, sollicitudin lacinia nisl. Duis hendrerit, augue id dapibus euismod, nunc urna iaculis diam, ac eleifend enim arcu ac augue. Pellentesque porttitor erat pretium, ultrices est et, maximus nunc. Sed maximus venenatis massa, vitae placerat nunc eleifend vitae. Pellentesque suscipit fermentum sem sed sagittis.
                                """
    @State var textActivator: Bool = false
    @State var subtextActivator: Bool = false
    
    @State var recordingList: [RecordingModel] = [
        RecordingModel(id: UUID(), title: "Bla bla bla", duration: "10:00"),
        RecordingModel(id: UUID(), title: "Bla bla bla", duration: "10:00"),
        RecordingModel(id: UUID(), title: "Bla bla bla", duration: "10:00"),
    ]
    var body: some View {
        NavigationStack {
            VStack{
                //need to change the opacity
                ZStack {
                    Rectangle()
                        .fill(Color.gray)
                        .opacity(0.3)
                        .cornerRadius(15)
                        .frame(minHeight: 380)
                    ScrollView{
                        Text(text)
                            .padding(20)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            .font(.title)
                    }
                }
                .padding()
                
                HStack {
                    Toggle("Text", isOn: $textActivator)
                        .toggleStyle(.button)
                    Spacer()
                    Toggle("Subtext", isOn: $subtextActivator)
                        .toggleStyle(.button)
                }
                .padding(.horizontal, 250)
                //need to add the view of recording
                List {
                    ForEach(recordingList, id: \.id) { recording in
                        VStack(alignment: .leading) {
                            Text(recording.title)
                            Text(recording.duration)
                                .font(.caption)
                        }
                    }
                    .onDelete {
                        indexSet in recordingList.remove(atOffsets: indexSet)
                    }
                }
                .listStyle(.inset)
                .toolbar {
                    EditButton()
                }
                
                Button(action: {
                    print("CIAO")
                }, label: {
                    HStack {
                        Image(systemName: "play.fill")
                        Text("PLAY")
                    }
                    .padding(.horizontal, 100)
                })
                .buttonStyle(.bordered)
                .controlSize(.large)
                .buttonBorderShape(.capsule)
                .tint(.red)
                .padding(.bottom, 50)
                
            }
            .navigationTitle("Text to Speech")
            
        }
    }
}

#Preview {
    TextSpeechView()
}
//in riga 61 luca non ci ha aiutato ovviamente <3

//
//  EditTextView.swift
//  NegroniChallenge
//
//  Created by Luca Maria Incarnato on 18/11/24.
//

import SwiftUI

struct EditTextView: View {
    @Environment(SpeechViewModel.self) var speechesVM
    @State var actualSpeech: SpeechModel = SpeechModel(
        speechTitle: "Odi et amo",
        cardColor: .red,
        dateOfPlay: Date.now,
        hourDuration: 0,
        minuteDuration: 0,
        secondDuration: 40,
        speechText: """
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum facilisis purus vitae purus pellentesque, sit amet scelerisque quam commodo. Suspendisse purus nibh, pulvinar sit amet erat quis, malesuada feugiat velit. Etiam semper interdum dolor. Praesent iaculis nisl augue, nec consectetur metus aliquam quis. Vestibulum sit amet augue ut turpis consectetur molestie. Curabitur in odio ut sem tincidunt consectetur nec ut felis. Nulla interdum dolor justo, mollis scelerisque odio cursus et. Phasellus a fermentum metus, in molestie purus. Praesent vulputate mollis arcu, ac aliquam ligula. Vestibulum nec urna vel magna vehicula egestas ut sit amet sapien. Sed faucibus varius elit quis malesuada.
            Vestibulum hendrerit, mauris vitae hendrerit efficitur, dui nunc elementum risus, in consectetur odio ligula vitae erat. Cras a venenatis eros, id tincidunt elit. Donec blandit augue eget ipsum elementum vehicula. Donec leo ligula, cursus et molestie non, rhoncus sit amet urna. Cras dapibus sed orci eget maximus. Quisque vel erat leo. Nullam nec finibus nibh. Nulla dignissim viverra cursus. Phasellus aliquet maximus lectus, eu bibendum ligula. Duis mattis enim vitae ex pellentesque blandit. Donec commodo molestie mattis. Nullam lectus sapien, pellentesque vitae condimentum quis, mattis sed leo. Donec et tortor in eros convallis consectetur. Aliquam id porta sem.
            Cras rhoncus erat nisl, at vestibulum ante mollis sit amet. Aenean feugiat diam odio, ut cursus tellus consequat sed. Curabitur venenatis blandit urna vitae porttitor. Nunc vitae lectus nec justo efficitur vulputate. Curabitur condimentum diam aliquet tellus semper tempor. Aliquam ac facilisis arcu, id dignissim dui. Suspendisse eu suscipit enim, vitae tincidunt purus. Praesent posuere sem id venenatis luctus. Vivamus ac ligula lacus. Proin ac dui nec tellus tincidunt malesuada eu placerat libero. Curabitur varius massa lobortis purus elementum, at ultricies erat suscipit. Aliquam at facilisis urna. Donec aliquam imperdiet tempus. Mauris tristique quis ipsum sit amet fermentum. Duis sollicitudin, arcu ac ornare tincidunt, quam leo vulputate metus, at posuere sem mi id tellus.
            Aliquam egestas ex urna, id pellentesque ipsum venenatis ornare. Cras a dolor condimentum, interdum lacus eu, varius felis. Morbi eu quam nisi. Vivamus sollicitudin vel augue at condimentum. Phasellus rhoncus aliquet porta. Maecenas nisl tortor, luctus ut massa sed, vestibulum tempus dolor. Nunc hendrerit tortor eu ligula facilisis posuere. Nulla posuere fringilla vulputate. Integer sapien felis, sagittis vitae faucibus laoreet, viverra sit amet erat.
            Aenean mattis, massa vitae ornare mollis, lectus quam tincidunt ipsum, quis volutpat augue odio in nisl. Mauris pharetra in sem in efficitur. Praesent vestibulum, sapien et dapibus finibus, eros sem mollis felis, ullamcorper porta odio diam et magna. Nulla gravida volutpat ex, ut posuere nisi hendrerit at. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nam a dignissim augue, quis gravida est. Sed dapibus consectetur lacus. Quisque sed orci nunc. Pellentesque imperdiet at nisi et finibus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Quisque ornare convallis neque, at faucibus arcu tempor sit amet. Curabitur a fermentum quam, eget egestas elit. Vestibulum neque est, efficitur ut metus id, malesuada gravida magna. Integer tincidunt ligula quis risus accumsan ornare. Curabitur laoreet eleifend orci feugiat laoreet.
            """,
        previousRecordings: [
            Recording(fileURL: URL(fileURLWithPath: "recordings"), createdAt: Date.now)
        ],
        numberOfPeople: 1,
        instructions: "Be expressive",
        additionalNotes: ""
    )
    @State var editMode: Int = 1
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.gray
                    .opacity(0.1)
                    .ignoresSafeArea()
                VStack{
                    Picker("", selection: $editMode){
                        Text("Edit text").tag(0)
                        Text("Edit subtext").tag(1)
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                    switch(editMode){
                    case 0:
                        EditTextMode(actualSpeech: actualSpeech)
                    case 1:
                        EditSubtextMode(actualSpeech: actualSpeech)
                    default:
                        EditDefaultMode()
                    }
                }
                .padding()
                .navigationTitle(actualSpeech.speechTitle)
                // Goes into edit mode
                .toolbar{
                    ToolbarItem(placement: .cancellationAction){
                        Button("Cancel", action: {
                            print("CIAO")
                        })
                    }
                }
            }
        }
    }
}

struct EditTextMode : View {
    @State var actualSpeech: SpeechModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .cornerRadius(15)
            TextEditor(text: $actualSpeech.speechText)
                .padding(20)
                .frame(alignment: .topLeading)
                .font(.title)
        }
        .padding()
    }
}

struct EditSubtextMode : View {
    @State var actualSpeech: SpeechModel
    let dragItems = ["space", "base.unit", "arrow.up", "arrow.down"]
    
    var body: some View {
        VStack{
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .cornerRadius(15)
                ScrollView{
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 130))], spacing: 10) {
                        // It creates unique ids for each word so that the ForEach can show it even if there's many occurrences of the same word
                        let words = Array(zip(actualSpeech.speechText.components(separatedBy: .whitespacesAndNewlines).indices, actualSpeech.speechText.components(separatedBy: .whitespacesAndNewlines)))
                        ForEach(words, id: \.0) { _, word in
                            ZStack {
                                Rectangle()
                                    .fill(Color.gray)
                                    .opacity(0.3)
                                    .frame(width: 130, height: 40)
                                    .cornerRadius(10)
                                Text(word)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(20)
                }
            }
            .padding()
            ZStack{
                Rectangle()
                    .fill(Color.white)
                    .cornerRadius(15)
                    .frame(maxHeight: 100)
                HStack{
                    ForEach(dragItems, id:\.self) { symbol in
                        ZStack {
                            Rectangle()
                                .fill(Color.red)
                                .frame(width: 130, height: 40)
                                .cornerRadius(10)
                            Image(systemName: symbol)
                                .foregroundStyle(Color.white)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct EditDefaultMode : View {
    var body: some View{
        Text("Something went wrong")
            .font(.title)
            .foregroundStyle(.gray)
    }
}

#Preview {
    EditTextView()
        .environment(SpeechViewModel())
}

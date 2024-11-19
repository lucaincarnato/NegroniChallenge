//
//  EditSpeechView.swift
//  NegroniChallenge
//
//  Created by Jesus Sebastian Jaime Oviedo on 12/11/24.
//

import Foundation

@Observable
class SpeechViewModel {
    // Data set for all the speeches available (in future needs to be connected with memory)
    var data: [SpeechModel] = [
        SpeechModel(
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
                Recording(fileURL: URL(fileURLWithPath: "recordings"), createdAt: Date.now)
            ],
            numberOfPeople: 2,
            instructions: "Be expressive",
            additionalNotes: ""
        ),
        SpeechModel(
            speechTitle: "Poesia per Natale 2",
            cardColor: .yellow,
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
                Recording(fileURL: URL(fileURLWithPath: "recordings"), createdAt: Date.now)
            ],
            numberOfPeople: 2,
            instructions: "Be expressive",
            additionalNotes: ""
        ),
        SpeechModel(
            speechTitle: "Lorem ipsum",
            cardColor: .green,
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
            numberOfPeople: 2,
            instructions: "Be expressive",
            additionalNotes: ""
        ),
        SpeechModel(
            speechTitle: "Lorem ipsum 2",
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
            numberOfPeople: 2,
            instructions: "Be expressive",
            additionalNotes: ""
        )
    ]
    
    func addSpeech(_ speech: SpeechModel) {
        data.append(speech)
    }
    
    func removeSpeech(_ speech: SpeechModel) {
        data.removeAll(where: { $0.speechTitle == speech.speechTitle })
    }
}

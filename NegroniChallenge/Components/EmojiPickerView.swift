//
//  EmojiPickerView.swift
//  NegroniChallenge
//
//  Created by Jesus Sebastian Jaime Oviedo on 12/11/24.
//

import SwiftUI
import MCEmojiPicker

struct EmojiPickerView: UIViewControllerRepresentable {
    @Binding var selectedEmoji: String
    @Environment(\.presentationMode) var presentationMode

    func makeUIViewController(context: Context) -> MCEmojiPickerViewController {
        let emojiPicker = MCEmojiPickerViewController()
        emojiPicker.delegate = context.coordinator
        return emojiPicker
    }

    func updateUIViewController(_ uiViewController: MCEmojiPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MCEmojiPickerDelegate {
        var parent: EmojiPickerView

        init(_ parent: EmojiPickerView) {
            self.parent = parent
        }

        func didGetEmoji(emoji: String) {
            parent.selectedEmoji = emoji
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
#Preview {
    EmojiPickerView(selectedEmoji: .constant(""))
}
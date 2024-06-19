import SwiftUI

extension SuggestionTextField {
    public class TextCoordinator: NSObject, NSTextFieldDelegate {
        let textField: NSTextField
        let text: Binding<String>
        let suggestionData: [Content]
        var onSelection: ((Content) -> Void)?

        private let suggestionsController: SuggestionsWindowController<Content> = .init()

        init(
            textField: NSTextField,
            text: Binding<String>,
            suggestionData: [Content],
            onSelection: ((Content) -> Void)? = nil
        ) {
            self.textField = textField
            self.text = text
            self.suggestionData = suggestionData
            self.onSelection = onSelection
        }

        var filteredSuggestion: [Content] {
            guard !text.wrappedValue.isEmpty else { return [] }

            return suggestionData.filter { suggestion in
                suggestion.suggestionText.lowercased().contains(text.wrappedValue.lowercased())
            }
        }

        // MARK: - NSTextFieldDelegate

        public func controlTextDidChange(_ obj: Notification) {
            text.wrappedValue = textField.stringValue
            print(#function, text.wrappedValue, filteredSuggestion)
            suggestionsController.showSuggestions(filteredSuggestion, for: textField)
        }

        public func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
            if commandSelector == #selector(NSTextView.moveUp(_:)) {
                suggestionsController.moveUp()
                return true
            }

            if commandSelector == #selector(NSTextView.moveDown(_:)) {
                suggestionsController.moveDown()
                return true
            }

            if commandSelector == #selector(NSTextView.insertNewline(_:)) {
                guard let suggestion = suggestionsController.selectedElement else { return false }
                textField.stringValue = suggestion.suggestionText
                text.wrappedValue = suggestion.suggestionText
                suggestionsController.orderOut()
                onSelection?(suggestion)
                return true
            }

            if commandSelector == #selector(NSTextView.cancelOperation(_:)) {
                suggestionsController.orderOut()
                return true
            }

            return false
        }

        public func controlTextDidEndEditing(_ obj: Notification) {
            suggestionsController.orderOut()
        }
    }
}

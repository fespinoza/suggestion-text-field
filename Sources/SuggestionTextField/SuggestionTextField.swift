import SwiftUI
import Combine

public struct SuggestionTextField<Content: SuggestionContent>: NSViewRepresentable {
    let title: String
    @Binding var text: String
    let suggestionData: [Content]
    var onSelection: ((Content) -> Void)?

    private let view = NSTextField()
    
    /// - Parameters:
    ///   - title: Placeholder title of the text field
    ///   - text: Binding to the text
    ///   - suggestionData: List of all possible suggestions, it will be filtered internally based on `suggestionText`
    ///   - onSelection: Optional callback to get the full structure that was selected
    ///
    /// Example:
    ///
    /// Given a data structure like:
    /// ```swift
    /// struct Element: SuggestionContent {
    ///     let id = UUID()
    ///     let title: String
    ///     let value: Int
    ///
    ///     var suggestionText: String { title }
    ///
    ///     static let sampleElements: [Element] = [
    ///         .init(title: "One", value: 1),
    ///         .init(title: "Two", value: 2),
    ///         .init(title: "Three", value: 3),
    ///         .init(title: "Four", value: 4),
    ///         .init(title: "Five", value: 5),
    ///     ]
    /// }
    /// ```
    ///
    /// You can use the component like
    ///
    /// ```swift
    /// SuggestionTextField(
    ///     "Title",
    ///     text: $text,
    ///     suggestionData: Element.sampleElements,
    ///     onSelection: { suggestion in
    ///         print("selected suggestion")
    ///     }
    /// )
    /// ```
    public init(
        _ title: String,
        text: Binding<String>,
        suggestionData: [Content],
        onSelection: ((Content) -> Void)? = nil
    ) {
        self.title = title
        self._text = text
        self.suggestionData = suggestionData
        self.onSelection = onSelection
    }

    public func makeNSView(context: Context) -> NSTextField {
        view.delegate = context.coordinator
        view.stringValue = text
        view.placeholderString = title
        return view
    }

    public func updateNSView(_ textField: NSTextField, context: Context) {
        // if the text changed somewhere else
        // updated it in the internal `textField`
        textField.stringValue = text
    }

    public func makeCoordinator() -> TextCoordinator {
        TextCoordinator(
            textField: view,
            text: $text,
            suggestionData: suggestionData,
            onSelection: onSelection
        )
    }
}

public extension SuggestionTextField where Content == TextSuggestion {
    init(
        _ title: String,
        text: Binding<String>,
        suggestionData: [String],
        onSelection: ((Content) -> Void)? = nil
    ) {
        self.title = title
        self._text = text
        self.suggestionData = suggestionData.map { TextSuggestion(stringLiteral: $0) }
        self.onSelection = onSelection
    }
}

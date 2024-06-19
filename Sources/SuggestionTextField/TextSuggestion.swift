import Foundation

/// Convenience to use strings as `SuggestionContent` for `SuggestionTextField`
///
/// It's recommended to use your own `SuggestionContent`
public struct TextSuggestion: SuggestionContent, ExpressibleByStringLiteral {
    public var suggestionText: String

    public typealias StringLiteralType = String

    public var id: String { suggestionText }

    public init(stringLiteral value: String) {
        self.suggestionText = value
    }

    public init(suggestionText: String) {
        self.suggestionText = suggestionText
    }
}

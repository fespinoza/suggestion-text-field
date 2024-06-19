import Foundation

public protocol SuggestionContent: Identifiable & Hashable & Equatable {
    var suggestionText: String { get }
}

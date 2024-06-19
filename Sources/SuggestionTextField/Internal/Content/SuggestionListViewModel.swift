import SwiftUI

class SuggestionListViewModel<Content: SuggestionContent>: ObservableObject {
    @Published var selectedElement: Content?
    @Published var suggestionData: [Content]

    init(selectedElement: Content? = nil, suggestionData: [Content] = []) {
        self.selectedElement = selectedElement
        self.suggestionData = suggestionData
    }

    func selectFirst() {
        selectedElement = suggestionData.first
    }

    func selectNext() {
        if let currentValue = selectedElement,
           let index = suggestionData.firstIndex(of: currentValue),
           index + 1 < suggestionData.count {
            selectedElement = suggestionData[index + 1]
        } else {
            selectedElement = suggestionData.first
        }
    }

    func selectPrevious() {
        if let currentValue = selectedElement,
           let index = suggestionData.firstIndex(of: currentValue),
           index - 1 >= 0 {
            selectedElement = suggestionData[index - 1]
        } else {
            selectedElement = suggestionData.last
        }
    }
}

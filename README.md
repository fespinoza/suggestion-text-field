# SuggestionTextField

## Usage

```swift
import SuggestionTextField

struct Demo: View {
    @State var text: String = "Hi"

    struct Element: SuggestionContent {
        let id = UUID()
        let title: String
        let value: Int

        var suggestionText: String { title }

        static let sampleElements: [Element] = [
            .init(title: "One", value: 1),
            .init(title: "Two", value: 2),
            .init(title: "Three", value: 3),
            .init(title: "Four", value: 4),
            .init(title: "Five", value: 5),
        ]
    }

    var body: some View {
        SuggestionTextField(
            "Title",
            text: $text,
            suggestionData: Element.sampleElements,
            onSelection: { suggestion in
                print("selected suggestion")
            }
        )
    }
}
```

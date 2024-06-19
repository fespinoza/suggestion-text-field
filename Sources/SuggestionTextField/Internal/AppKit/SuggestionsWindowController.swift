import SwiftUI

class SuggestionsWindowController<Content: SuggestionContent>: NSWindowController {
    let viewModel: SuggestionListViewModel<Content> = .init()

    private lazy var swiftUIContent: NSView = {
        let view = NSHostingView(
            rootView: SuggestionListContent(viewModel: viewModel)
                .frame(height: 200)
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var selectedElement: Content? {
        viewModel.selectedElement
    }

    convenience init() {
        let window = NSWindow(contentViewController: NSViewController())
        window.styleMask = .borderless
        window.contentView = NSView()

        self.init(window: window)

        guard let contentView = window.contentView else { return }
        contentView.addSubview(swiftUIContent)
        NSLayoutConstraint.activate([
            swiftUIContent.topAnchor.constraint(equalTo: contentView.topAnchor),
            swiftUIContent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            swiftUIContent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            swiftUIContent.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    override func windowDidLoad() {
        super.windowDidLoad()

        window?.contentView?.layer?.cornerRadius = 16
    }

    func orderOut() {
        window?.orderOut(nil)
    }

    func showSuggestions(_ suggestions: [Content], for textField: NSTextField) {
        if suggestions.isEmpty {
            orderOut()
        } else {
            viewModel.suggestionData = suggestions
            guard
                let textFieldWindow = textField.window,
                let window = self.window
            else { return }

            print("showing suggestions!")

            var textFieldRect = textField.convert(textField.bounds, to: nil)
            textFieldRect = textFieldWindow.convertToScreen(textFieldRect)
            textFieldRect.origin.y -= 5
            window.setFrameTopLeftPoint(textFieldRect.origin)

            var frame = window.frame
            frame.size.width = textField.frame.width
            window.setFrame(frame, display: false)
            textFieldWindow.addChildWindow(window, ordered: .above)
        }
    }

    func moveUp() {
        viewModel.selectPrevious()
    }

    func moveDown() {
        viewModel.selectNext()
    }
}

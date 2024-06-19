import SwiftUI

struct SuggestionListContent<Content: SuggestionContent>: View {
    @ObservedObject var viewModel: SuggestionListViewModel<Content>

    var body: some View {
        List(viewModel.suggestionData, selection: $viewModel.selectedElement) { element in
            Text(element.suggestionText)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 4)
                .padding(.vertical, 2)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundStyle(
                            element == viewModel.selectedElement ? AnyShapeStyle(.selection) : AnyShapeStyle(.clear))
                )
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.selectedElement = element
                }
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .onAppear(perform: viewModel.selectFirst)
        .focusable()
        .focusEffectDisabled()
    }
}

#if canImport(SwiftUI) && !os(watchOS)

    import SwiftUI

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, *)
    public struct AttributedText: View {
        @StateObject private var textViewStore = TextViewStore()

        private let attributedText: NSAttributedString
        @Binding var testme: Bool
        @Binding var testmeUrl: String

        public init(_ attributedText: NSAttributedString, _ testme: Binding<Bool>, _ testmeUrl: Binding<String>) {
            self.attributedText = attributedText
            self._testme = testme
            self._testmeUrl = testmeUrl
        }

        public var body: some View {
            GeometryReader { geometry in
                TextViewWrapper(
                    testme: $testme,
                    testmeUrl: $testmeUrl,
                    attributedText: attributedText,
                    maxLayoutWidth: geometry.maxWidth,
                    textViewStore: textViewStore
                )
            }
            .frame(
                idealWidth: textViewStore.intrinsicContentSize?.width,
                idealHeight: textViewStore.intrinsicContentSize?.height
            )
            .fixedSize(horizontal: false, vertical: true)
            
        }
    }

    @available(macOS 11.0, iOS 14.0, tvOS 14.0, *)
    private extension GeometryProxy {
        var maxWidth: CGFloat {
            size.width - safeAreaInsets.leading - safeAreaInsets.trailing
        }
    }

#endif

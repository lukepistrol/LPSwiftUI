//
//  LPTextView.swift
//  LPSwiftUI
//
//  Created by Lukas Pistrol on 11.01.22.
//

import SwiftUI

#if os(iOS)
/// Text View with Placeholder
public struct LPTextView: View {
	@Binding var text: String
	var placeholder: String
	var minHeight: Double = 50
	@State private var height: Double?

	public init(_ text: Binding<String>, placeholder: String, minHeight: Double = 50) {
		self._text = text
		self.placeholder = placeholder
		self.minHeight = minHeight
	}

	public var body: some View {
		WrappedTextView(text: $text, placeholder: placeholder, configuration: self.didChange(_:))
			.frame(height: height ?? minHeight)
	}

	private func didChange(_ textView: CustomTextView) {
		self.height = max(textView.contentSize.height, minHeight)
	}
}

fileprivate struct WrappedTextView: UIViewRepresentable {

	public init(text: Binding<String>,
				placeholder: String = "",
				configuration: @escaping Configuration = { _ in }) {
			self._text = text
			self.placeholder = placeholder
			self.configuration = configuration
		}

	@Binding public var text: String
	private var placeholder: String
	private let configuration: Configuration

	public typealias Configuration = (CustomTextView) -> Void

	public func makeUIView(context: Context) -> CustomTextView {
		let view = CustomTextView()
		view.backgroundColor = .secondarySystemGroupedBackground
		view.isScrollEnabled = true
		view.isEditable = true
		view.isUserInteractionEnabled = true
		view.font = .preferredFont(forTextStyle: .body)
		view.delegate = context.coordinator
		view.placeholderLabel.text = placeholder

		return view
	}

	public func makeCoordinator() -> Coordinator {
		Coordinator(text: $text, configuration: configuration)
	}

	public func updateUIView(_ uiView: CustomTextView, context: Context) {
		uiView.text = text
		uiView.placeholderLabel.isHidden = uiView.text.isEmpty ? false : true
		configuration(uiView)
	}

	public class Coordinator: NSObject, UITextViewDelegate {
		public init(text: Binding<String>, configuration: @escaping Configuration) {
			self._text = text
			self.configuration = configuration
		}

		@Binding public var text: String
		let configuration: Configuration

		public func textViewDidChange(_ textView: UITextView) {
			guard let textView = textView as? CustomTextView else { return }
			text = textView.text
			self.configuration(textView)
		}
	}
}

struct TextView_Previews: PreviewProvider {
	static var previews: some View {
		List {
			LPTextView(.constant(""), placeholder: "Text Here...")
		}
		.preferredColorScheme(.dark)
	}
}
#endif

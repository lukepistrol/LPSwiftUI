//
//  File.swift
//  
//
//  Created by Lukas Pistrol on 11.01.22.
//

import SwiftUI

#if os(iOS)
/// A UITextView subclass with placeholder text support.
/// It uses another UILabel to show the placeholder, shown when text is empty.
public class CustomTextView: UITextView {

	lazy var placeholderLabel: UILabel = {
		let label = UILabel()
		label.textColor = UIColor(white: 0.5, alpha: 0.85)
		label.backgroundColor = .clear
		return label
	}()

	override public init(frame: CGRect, textContainer: NSTextContainer?) {
		super.init(frame: frame, textContainer: textContainer)
		setupNotificationObserver()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupNotificationObserver()
	}

	deinit {
		NotificationCenter.default.removeObserver(self)
	}

	private func setupNotificationObserver() {
		NotificationCenter.default.addObserver(self,
											   selector: #selector(textDidChangeHandler(notification:)),
											   name: UITextView.textDidChangeNotification,
											   object: self)
	}

	override public func layoutSubviews() {
		super.layoutSubviews()

		if text.isEmpty {
			placeholderLabel.copyProperties(from: self)
			placeholderLabel.frame.origin = CGPoint(x: 5, y: (self.font?.pointSize)! / 2)
			addSubview(placeholderLabel)
			bringSubviewToFront(placeholderLabel)
		} else {
			placeholderLabel.removeFromSuperview()
		}
	}

	@objc func textDidChangeHandler(notification: Notification) {
		setNeedsLayout()
	}
}

private extension UILabel {
	/// Copies common properties from UITextView. You can add more.
	func copyProperties(from textView: UITextView) {
		sizeToFit()
		lineBreakMode = textView.textContainer.lineBreakMode
		textAlignment = textView.textAlignment
		numberOfLines = textView.textContainer.maximumNumberOfLines
	}
}
#endif

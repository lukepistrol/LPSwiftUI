//
//  LPLabelStyle.swift
//  LPSwiftUI
//
//  Created by Lukas Pistrol on 27.12.21.
//

import SwiftUI

// MARK: - CUSTOM LabelStyle
@available(iOS 15.0, *)
public struct LPLabelStyle: LabelStyle {
	var imagePosition: ImagePosition
	var imageFont: Font
	var imageColor: Color
	var spacing: Double
	
	@ViewBuilder
	public func makeBody(configuration: Configuration) -> some View {
		// Leading & Trailing
		if imagePosition == .leading || imagePosition == .trailing {
			HStack(spacing: spacing) {
				if imagePosition == .leading {
					configuration.icon
						.foregroundColor(imageColor)
						.font(imageFont)
				}
				configuration.title
				if imagePosition == .trailing {
					configuration.icon
						.foregroundColor(imageColor)
						.font(imageFont)
				}
			}
		} else { // Top & Bottom
			VStack(spacing: spacing) {
				if imagePosition == .top {
					configuration.icon
						.foregroundColor(imageColor)
						.font(imageFont)
				}
				configuration.title
				if imagePosition == .bottom {
					configuration.icon
						.foregroundColor(imageColor)
						.font(imageFont)
				}
			}
		}
	}
	
	enum ImagePosition {
		case leading, trailing, top, bottom
	}
}

@available(iOS 15.0, *)
public extension LabelStyle where Self == LPLabelStyle {
	
	static private func custom(position imagePosition: LPLabelStyle.ImagePosition = .leading,
							   imageFont: Font = .body,
							   imageColor: Color = .primary,
							   spacing: Double = 4) -> Self {
		LPLabelStyle(imagePosition: imagePosition,
						 imageFont: imageFont,
						 imageColor: imageColor,
						 spacing: spacing)
	}
	
	// MARK: Leading Icon LabelStyle
	/// A label style that shows both the title and icon of the label.
	/// The label is arranged horizontally with the icon leading.
	static var leadingIcon: Self {
		custom(position: .leading)
	}
	
	/// A label style that shows both the title and icon of the label.
	/// The label is arranged horizontally with the icon leading.
	/// - Parameters:
	///   - imageFont: The font of the icon
	///   - imageColor: The color of the icon
	///   - spacing: The horizontal spacing between icon and title
	/// - Returns: Self
	static func leadingIcon(imageFont: Font = .body,
							imageColor: Color = .primary,
							spacing: Double = 8) -> Self {
		custom(position: .leading, imageFont: imageFont, imageColor: imageColor, spacing: spacing)
	}
	
	// MARK: Trailing Icon LabelStyle
	/// A label style that shows both the title and icon of the label.
	/// The label is arranged horizontally with the icon trailing.
	static var trailingIcon: Self {
		custom(position: .trailing)
	}
	
	/// A label style that shows both the title and icon of the label.
	/// The label is arranged horizontally with the icon trailing.
	/// - Parameters:
	///   - imageFont: The font of the icon
	///   - imageColor: The color of the icon
	///   - spacing: The horizontal spacing between icon and title
	/// - Returns: Self
	static func trailingIcon(imageFont: Font = .body,
							 imageColor: Color = .primary,
							 spacing: Double = 8) -> Self {
		custom(position: .trailing, imageFont: imageFont, imageColor: imageColor, spacing: spacing)
	}
	
	// MARK: Top Icon LabelStyle
	/// A label style that shows both the title and icon of the label.
	/// The label is arranged vertically with the icon on top.
	static var topIcon: Self {
		custom(position: .top)
	}
	
	/// A label style that shows both the title and icon of the label.
	/// The label is arranged vertically with the icon on top.
	/// - Parameters:
	///   - imageFont : The font of the icon
	///   - imageColor: The color of the icon
	///   - spacing: The vertical spacing between icon and title
	/// - Returns: Self
	static func topIcon(imageFont: Font = .body,
						imageColor: Color = .primary,
						spacing: Double = 8) -> Self {
		custom(position: .top, imageFont: imageFont, imageColor: imageColor, spacing: spacing)
	}
}

//
//  Font+RoundedFont.swift
//  
//
//  Created by Lukas Pistrol on 24.01.22.
//

import SwiftUI

public struct SerifFont: ViewModifier {

	var style: Font.TextStyle
	var weight: Font.Weight

	public func body(content: Content) -> some View {
		content
			.font(.system(style, design: .serif).weight(weight))
	}
}

public struct MonospacedFont: ViewModifier {

	var style: Font.TextStyle
	var weight: Font.Weight

	public func body(content: Content) -> some View {
		content
			.font(.system(style, design: .monospaced).weight(weight))
	}
}

public struct RoundedFont: ViewModifier {

	var style: Font.TextStyle
	var weight: Font.Weight

	public func body(content: Content) -> some View {
		content
			.font(.system(style, design: .rounded).weight(weight))
	}
}

public extension View {
	/// Serif System Font which supports Dynamic Type
	/// - Parameters:
	///   - style: The font style (.headline, .title, etc...)
	///   - weight: The weight (default: .regular)
	/// - Returns: some View
	func serifFont(_ style: Font.TextStyle, weight: Font.Weight = .regular) -> some View {
		modifier(SerifFont(style: style, weight: weight))
	}

	/// Monospaced System Font which supports Dynamic Type
	/// - Parameters:
	///   - style: The font style (.headline, .title, etc...)
	///   - weight: The weight (default: .regular)
	/// - Returns: some View
	func monospacedFont(_ style: Font.TextStyle, weight: Font.Weight = .regular) -> some View {
		modifier(MonospacedFont(style: style, weight: weight))
	}

	/// Rounded System Font which supports Dynamic Type
	/// - Parameters:
	///   - style: The font style (.headline, .title, etc...)
	///   - weight: The weight (default: .regular)
	/// - Returns: some View
	func roundedFont(_ style: Font.TextStyle, weight: Font.Weight = .regular) -> some View {
		modifier(RoundedFont(style: style, weight: weight))
	}
}

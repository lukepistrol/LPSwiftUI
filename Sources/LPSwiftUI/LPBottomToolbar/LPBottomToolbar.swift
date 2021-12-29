//
//  LPBottomToolbar.swift
//  LPSwiftUI
//
//  Created by Lukas Pistrol on 28.12.21.
//

import SwiftUI
#if !os(watchOS)
@available(iOS 15.0, *)
/// A Modifier which wraps the content in a view imitating a system bottom toolbar
///
/// Recommended use inside '.safeAreaInset(edge: .bottom)'  on a ScrollView or List
public struct LPBottomToolbarModifier: ViewModifier {
	var height: Double
	public func body(content: Content) -> some View {
		content
			.padding(.vertical, 8)
			.padding(.horizontal)
			.frame(maxWidth: .infinity, alignment: .center)
			.frame(height: height)
			.background(
				Rectangle()
					.foregroundStyle(.regularMaterial)
					.shadow(color: .separator, radius: 0, x: 0, y: -0.5)
					.ignoresSafeArea(.all, edges: .bottom)
			)
	}
}

@available(iOS 15.0, *)
public extension View {
	/// A Modifier which wraps the content in a view imitating a system bottom toolbar
	///
	/// Recommended use inside '.safeAreaInset(edge: .bottom)'  on a ScrollView or List
	/// - Returns: some View
	func lpBottomToolbar(height: Double = 50) -> some View {
		modifier(LPBottomToolbarModifier(height: height))
	}
}
#endif

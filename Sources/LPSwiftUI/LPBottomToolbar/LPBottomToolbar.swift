//
//  LPBottomToolbar.swift
//  
//
//  Created by Lukas Pistrol on 28.12.21.
//

import SwiftUI

/// A Modifier which wraps the content in a view imitating a system bottom toolbar
///
/// Recommended use inside '.safeAreaInset(edge: .bottom)'  on a ScrollView or List
struct LPBottomToolbarModifier: ViewModifier {
	func body(content: Content) -> some View {
		content
			.padding(.vertical, 8)
			.padding(.horizontal)
			.frame(maxWidth: .infinity, alignment: .center)
			.background(
				Rectangle()
					.foregroundStyle(.regularMaterial)
					.shadow(color: .separator, radius: 0, x: 0, y: -0.5)
					.ignoresSafeArea(.all, edges: .bottom)
			)
	}
}

extension View {
	/// A Modifier which wraps the content in a view imitating a system bottom toolbar
	///
	/// Recommended use inside '.safeAreaInset(edge: .bottom)'  on a ScrollView or List
	/// - Returns: some View
	func lpBottomToolbar() -> some View {
		modifier(LPBottomToolbarModifier())
	}
}

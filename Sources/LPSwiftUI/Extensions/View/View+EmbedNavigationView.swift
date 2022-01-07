//
//  View+EmbedNavigationView.swift
//  LPSwiftUI
//
//  Created by Lukas Pistrol on 07.01.22.
//

import SwiftUI

public extension View {
	
	/// Embedds the View inside a NavigationView
	/// - Returns: some View
	func embedInNavigationView() -> some View {
		NavigationView {
			self
		}
	}
	
	/// Embedds the View inside a NavigationView with a given title
	/// - Parameter title: The title of the Navigation View
	/// - Returns: some View
	func embedInNavigationView(_ title: String) -> some View {
		NavigationView {
			self
				.navigationTitle(title)
		}
	}
}

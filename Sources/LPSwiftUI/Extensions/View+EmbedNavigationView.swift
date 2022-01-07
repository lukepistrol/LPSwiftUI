//
//  File.swift
//  
//
//  Created by Lukas Pistrol on 07.01.22.
//

import SwiftUI

extension View {
	
	/// Embedds the View inside a NavigationView
	/// - Returns: some View
	public func embedInNavigationView() -> some View {
		NavigationView {
			self
		}
	}
	
	/// Embedds the View inside a NavigationView with a given title
	/// - Parameter title: The title of the Navigation View
	/// - Returns: some View
	public func embedInNavigationView(_ title: String) -> some View {
		NavigationView {
			self
				.navigationTitle(title)
		}
	}
}

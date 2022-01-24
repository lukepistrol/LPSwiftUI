//
//  File.swift
//  
//
//  Created by Lukas Pistrol on 25.01.22.
//

import SwiftUI

public extension View {
	/// Convenience Method for setting a views width
	///
	/// **Usage:**
	/// ```
	/// Text("Hello")
	///     .width(100)
	/// ```
	func width(_ width: Double) -> some View {
		self.frame(width: width)
	}

	/// Convenience Method for setting a views height
	///
	/// **Usage:**
	/// ```
	/// Text("Hello")
	///     .height(100)
	/// ```
	func height(_ height: Double) -> some View {
		self.frame(height: height)
	}

	/// Convenience Method for setting a views frame
	///
	/// **Usage:**
	/// ```
	/// Text("Hello")
	///     .size(w: 100, h: 100)
	/// ```
	func size(w width: Double, h height: Double) -> some View {
		self.frame(width: width, height: height)
	}
}

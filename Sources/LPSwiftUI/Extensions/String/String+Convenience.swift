//
//  String+Convenience.swift
//  LPSwiftUI
//
//  Created by Lukas Pistrol on 28.12.21.
//

import Foundation

public extension String {
	/// Returns a single `space` Character
	static var space: String { String(" ") }
	
	/// Returns an empty String
	static var empty: String { String("") }
	
	/// Returns the decimal separator for the current `Locale`
	///
	/// e.g: For US this returns "."
	static var localizedDecimalSeparator: String { Locale.current.decimalSeparator ?? "." }
	
	/// Returns the grouping separator for the current `Locale`
	///
	/// e.g: For US this returns ","
	static var localizedGroupingSeparator: String { Locale.current.groupingSeparator ?? space }
}

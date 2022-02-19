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

	/// Returns a linebreak character
	static var newLine: String { String("\n") }

	/// Returns a tab character
	static var tab: String { String("\t") }

	/// Returns the decimal separator for the current `Locale`
	///
	/// e.g: For US this returns "."
	static var localizedDecimalSeparator: String { Locale.current.decimalSeparator ?? "." }
	
	/// Returns the grouping separator for the current `Locale`
	///
	/// e.g: For US this returns ","
	static var localizedGroupingSeparator: String { Locale.current.groupingSeparator ?? space }
}

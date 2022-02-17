//
//  String+Trimmed+Slug.swift
//  LPSwiftUI
//
//  Created by Lukas Pistrol on 17.02.22.
//

import Foundation

public extension String {
	/// Cuts off whitespaces and newlines at each end of the String
	var trimmed: String {
		return trimmingCharacters(in: .whitespacesAndNewlines)
	}

	/// The first Character of the String as a new String
	var firstCharacterAsString: String? {
		guard let first = first else { return nil }
		return String(first)
	}

	/// The last Character of the String as a new String
	var lastCharacterAsString: String? {
		guard let last = last else { return nil }
		return String(last)
	}

	/// Creates a slug of the current String
	var slug: String {
		let lowercased = self.lowercased()
		let withDashes = lowercased.replacingOccurrences(of: " ", with: "-")

		let alphanumerics = NSCharacterSet.alphanumerics
		var filtered = withDashes.filter {
			guard String($0) != "-" else { return true }
			guard String($0) != "&" else { return true }
			return String($0).rangeOfCharacter(from: alphanumerics) != nil
		}

		while filtered.lastCharacterAsString == "-" {
			filtered = String(filtered.dropLast())
		}

		while filtered.firstCharacterAsString == "-" {
			filtered = String(filtered.dropFirst())
		}

		return filtered.replacingOccurrences(of: "--", with: "-")
	}
}

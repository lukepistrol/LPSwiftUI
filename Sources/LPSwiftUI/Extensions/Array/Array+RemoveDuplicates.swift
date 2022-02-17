//
//  Array+RemoveDuplicates.swift
//  LPSwiftUI
//
//  Created by Lukas Pistrol on 17.02.22.
//

import Foundation

public extension Array where Element: Equatable {
	/// Removes duplicate Elements from the String
	/// - Returns: Array with all duplicate Elements removed
	mutating func removeDuplicates() -> [Element] {
		self = reduce(into: [Element]()) {
			if !$0.contains($1) {
				$0.append($1)
			}
		}
		return self
	}

	/// Removes duplicate Elements from the String
	/// - Returns: Array with all duplicate Elements removed
	func withoutDuplicates() -> [Element] {
		return reduce(into: [Element]()) {
			if !$0.contains($1) {
				$0.append($1)
			}
		}
	}
}

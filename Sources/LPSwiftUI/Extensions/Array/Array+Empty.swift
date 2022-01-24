//
//  Array+Empty.swift
//  
//
//  Created by Lukas Pistrol on 24.01.22.
//

import Foundation

public extension Array {
	/// Declarative Syntax for creating an empty array  `[]`
	///
	/// **Usage:**
	/// ```
	/// let numbers: [Int] = .empty
	/// ```
	static var empty: Self { [] }
}

public extension Dictionary {
	/// Declarative Syntax for creating an empty dictionary `[:]`
	///
	/// **Usage:**
	/// ```
	/// let numbers: [Int] = .empty
	/// ```
	static var empty: Self { [:] }
}

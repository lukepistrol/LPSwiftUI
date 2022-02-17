//
//  String+Initializers.swift
//  LPSwiftUI
//
//  Created by Lukas Pistrol on 17.02.22.
//

import Foundation

public extension String {
	/// Creates a new random String of given length
	/// - Parameter length: number of characters
	init(randomLength length: Int) {
		guard length > 0 else {
			self.init()
			return
		}

		let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
		var randomString = ""

		for _ in 1...length {
			randomString.append(base.randomElement()!)
		}
		self = randomString
	}
}

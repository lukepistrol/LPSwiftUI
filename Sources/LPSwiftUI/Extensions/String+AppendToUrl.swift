//
//  String+AppendToUrl.swift
//  LPSwiftUI
//
//  Created by Lukas Pistrol on 28.12.21.
//

import Foundation

extension String {
	func appendLineToURL(fileURL: URL) throws {
		try (self + "\n").appendToURL(fileURL: fileURL)
	}
	
	func appendToURL(fileURL: URL) throws {
		let data = self.data(using: String.Encoding.utf8)!
		try data.append(to: fileURL)
	}
}

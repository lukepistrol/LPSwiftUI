//
//  String+AppendToUrl.swift
//  LPSwiftUI
//
//  Created by Lukas Pistrol on 28.12.21.
//

import Foundation

public extension String {
	
	/// Appends this String to a file at given URL and adds a line-break to the end.
	/// - Parameter fileURL: The URL of the file
	func appendLineToURL(fileURL: URL) throws {
		try (self + "\n").appendToURL(fileURL: fileURL)
	}
	
	/// Adds this String to the end of the file at the given URL.
	/// - Parameter fileURL: The URL of the file
	func appendToURL(fileURL: URL) throws {
		let data = self.data(using: String.Encoding.utf8)!
		try data.append(to: fileURL)
	}
}

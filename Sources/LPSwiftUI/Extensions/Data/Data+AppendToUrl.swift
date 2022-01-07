//
//  Data+AppendToUrl.swift
//  LPSwiftUI
//
//  Created by Lukas Pistrol on 28.12.21.
//

import Foundation

public extension Data {
	
	/// Adds the Data to a file at the given URL
	/// - Parameter fileURL: The URL of the file
	func append(to fileURL: URL) throws {
		if let fileHandle = FileHandle(forWritingAtPath: fileURL.path) {
			defer {
				fileHandle.closeFile()
			}
			fileHandle.seekToEndOfFile()
			fileHandle.write(self)
		}
		else {
			try write(to: fileURL, options: .atomic)
		}
	}
}

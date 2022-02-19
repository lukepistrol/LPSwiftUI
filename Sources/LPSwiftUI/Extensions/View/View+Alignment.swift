//
//  File.swift
//  
//
//  Created by Lukas Pistrol on 19.02.22.
//

import SwiftUI

public extension View {

	/// Aligns the View to the given alignment
	/// - Parameter alignment: alignment to apply
	/// - Returns: some View
	func aligned(_ alignment: Alignment) -> some View {
		self.frame(alignment: alignment)
	}

}

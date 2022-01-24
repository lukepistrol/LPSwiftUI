//
//  View+CenterHorizontally.swift
//  
//
//  Created by Lukas Pistrol on 24.01.22.
//

import SwiftUI

public extension View {
	/// Centers the view in a HStack
	func centeredHorizontally() -> some View {
		HStack {
			Spacer()
			self
			Spacer()
		}
	}

	/// Equal to `frame(maxWidth: .infinity)`
	func infiniteWidth() -> some View {
		self.frame(maxWidth: .infinity)
	}
}

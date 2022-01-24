//
//  View+CenterHorizontally.swift
//  
//
//  Created by Lukas Pistrol on 24.01.22.
//

import SwiftUI

public extension View {
	func centeredHorizontally() -> some View {
		HStack {
			Spacer()
			self
			Spacer()
		}
	}

	func infiniteWidth() -> some View {
		self.frame(maxWidth: .infinity)
	}
}

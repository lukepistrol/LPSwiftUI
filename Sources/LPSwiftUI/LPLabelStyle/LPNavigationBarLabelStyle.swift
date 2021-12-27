//
//  LPNavigationBarLabelStyle.swift
//  
//
//  Created by Lukas Pistrol on 27.12.21.
//

import SwiftUI

// MARK: - NAVIGATION BAR LabelStyle

public struct LPNavigationBarLabelStyle: LabelStyle {
	public func makeBody(configuration: Configuration) -> some View {
		configuration.icon
			.symbolRenderingMode(.hierarchical)
			.font(.title2)
	}
}

public extension LabelStyle where Self == LPNavigationBarLabelStyle {
	
	/// A label style that shows only the icon of the Label for use in a Navigation Bar or Toolbar.
	/// The icon has a rendering mode of 'hierachial' and a font of 'title2'.
	static var navigationBar: Self {
		LPNavigationBarLabelStyle()
	}
}

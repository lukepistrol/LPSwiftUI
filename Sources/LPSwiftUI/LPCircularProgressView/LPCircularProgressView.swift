//
//  LPCircularProgressView.swift
//  
//
//  Created by Lukas Pistrol on 25.01.22.
//

import SwiftUI

public struct LPCircularProgressView: View {
	@Binding var progress: Double
	private var lineWidth: Double
	private var tint: Color

	public init(_ progress: Binding<Double>, lineWidth: Double = 2, tint: Color = .accentColor) {
		self._progress = progress
		self.lineWidth = lineWidth
		self.tint = tint
	}

	public var body: some View {
		ZStack {
			Circle()
				.stroke(lineWidth: lineWidth)
				.opacity(0.3)
				.foregroundColor(tint)

			Circle()
				.trim(from: min(0.0, abs(self.progress)), to: min(self.progress, 1.0))
				.stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
				.foregroundColor(tint)
				.rotationEffect(Angle(degrees: 270.0))
				.animation(.linear, value: progress)
		}
		.padding(2)
		.aspectRatio(1, contentMode: .fit)
		.onChange(of: progress) { newValue in
			if newValue < 0 {
				self.progress = 0
			}
			if newValue > 1 {
				self.progress = 1
			}
		}
	}
}

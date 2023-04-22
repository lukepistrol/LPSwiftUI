//
//  UIImage+Cropped.swift
//  LPSwiftUI
//
//  Created by Lukas Pistrol on 07.01.22.
//

#if !os(macOS) && !os(watchOS)
import UIKit

public extension UIImage {
	func cropped() -> UIImage {
		// calculate the minimum side length
		let sideLength = min(self.size.width, self.size.height)
		
		// calculate the offset to center the crop rect
		let offsetX = (self.size.width - sideLength)/2
		let offsetY = (self.size.height - sideLength)/2
		
		// create the crop rect
		let cropRect = CGRect(x: offsetX,
							  y: offsetY,
							  width: sideLength,
							  height: sideLength
		).integral
		
		// crop the image
		let croppedCGImage = self.cgImage!.cropping(to: cropRect)!
		
		// return cropped UIImage
		return UIImage(cgImage: croppedCGImage, scale: self.imageRendererFormat.scale, orientation: self.imageOrientation)
	}
}
#endif

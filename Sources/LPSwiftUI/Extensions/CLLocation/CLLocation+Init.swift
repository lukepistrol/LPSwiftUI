//
//  CLLocation+Init.swift
//  
//
//  Created by Lukas Pistrol on 25.01.22.
//

import CoreLocation
import Foundation

public extension CLLocation {
	/// Convenience Initializer taking a CLLocationCoordinate2D as an argument
	/// - Parameter coordinates: a CLLocationCoordinate2D
	convenience init(_ coordinates: CLLocationCoordinate2D) {
		self.init(latitude: coordinates.latitude, longitude: coordinates.longitude)
	}
}

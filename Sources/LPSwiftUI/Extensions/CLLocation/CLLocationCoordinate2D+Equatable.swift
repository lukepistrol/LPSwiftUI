//
//  CLLocationCoordinate2D+Equatable.swift
//  
//
//  Created by Lukas Pistrol on 25.01.22.
//

import CoreLocation
import Foundation

extension CLLocationCoordinate2D: Equatable {
	public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
		lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
	}
}

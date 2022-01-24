//
//  Date+Components.swift
//  
//
//  Created by Lukas Pistrol on 25.01.22.
//

import Foundation

public extension Date {
	/// The second component for the Date
	var second: Int {
		Calendar.current.component(.second, from: self)
	}

	/// The minute component for the Date
	var minute: Int {
		Calendar.current.component(.minute, from: self)
	}

	/// The hour component for the Date
	var hour: Int {
		Calendar.current.component(.hour, from: self)
	}

	/// The day component for the Date
	var day: Int {
		Calendar.current.component(.day, from: self)
	}

	/// The weekday component for the Date
	var weekday: Int {
		Calendar.current.component(.weekday, from: self)
	}

	/// The weekOfYear component for the Date
	var weekOfYear: Int {
		Calendar.current.component(.weekOfYear, from: self)
	}

	/// The month component for the Date
	var month: Int {
		Calendar.current.component(.month, from: self)
	}

	/// The year component for the Date
	var year: Int {
		Calendar.current.component(.year, from: self)
	}
}

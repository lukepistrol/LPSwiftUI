import XCTest
@testable import LPSwiftUI

final class LPSwiftUITests: XCTestCase {
	
	override func setUpWithError() throws {
		#if DEBUG
		print("DEBUG")
		#else
		print("RELEASE")
		#endif
	}
	
	override func tearDownWithError() throws {
		XCTAssert(!LPLog.getLogsFromFile().isEmpty)
		LPLog.deleteLogFile()
	}
	
	func testLogsWithStats() throws {
		LPLog.Options.logStats = true
		LPLog.Options.debugLevel = .debug
		logAllCases()
	}
	
	func testLogsWithOutStats() throws {
		LPLog.Options.logStats = false
		LPLog.Options.debugLevel = .debug
		logAllCases()
	}
	
	func testLogsInfo() throws {
		LPLog.Options.logStats = false
		LPLog.Options.debugLevel = .info
		logAllCases()
	}
	
	func testLogsError() throws {
		LPLog.Options.logStats = false
		LPLog.Options.debugLevel = .error
		logAllCases()
	}
	
	
	func logAllCases() {
		log(.debug("Debug"))
		log(.info("Info"))
		log(.notice("Notice"))
		log(.success("Success"))
		log(.warning("Warning"))
		log(.error("Error"))
	}
}

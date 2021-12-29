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
		LPLog.setup(debugLevel: .debug, logStats: true, saveToFile: true)
		logAllCases()
	}
	
	func testLogsWithOutStats() throws {
		LPLog.setup(debugLevel: .debug, logStats: false, saveToFile: true)
		logAllCases()
	}
	
	func testLogsInfo() throws {
		LPLog.setup(debugLevel: .info, logStats: false, saveToFile: true)
		logAllCases()
	}
	
	func testLogsError() throws {
		LPLog.setup(debugLevel: .error, logStats: false, saveToFile: true)
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

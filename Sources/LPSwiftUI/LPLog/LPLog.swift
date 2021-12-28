//
//  LPLog.swift
//  LPSwiftUI
//
//  Created by Lukas Pistrol on 28.12.21.
//

import Foundation

/// A Log Framework to display logs in the console and also save logs to a local file
public struct LPLog {
	
	/// The directory the logfile is saved in
	private static var logSaveDirectory: URL {
		FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
	}
	
	/// The URL to the local logfile's location
	fileprivate static var logfileUrl: URL {
		logSaveDirectory.appendingPathComponent(LPLog.filename + "." + LPLog.fileExtension)
	}
	
	/// The filename the local logfile uses
	private static var filename: String {
		String("Logs")
	}
	
	/// The file extension the local logfile uses
	private static var fileExtension: String {
		String("txt")
	}
	
	
	/// Generates a formatted String including stats about the log
	///
	/// Includes a mark if the log was called from main thread, timestamp, filename, function and line number
	///
	/// - Parameters:
	///   - file: the file the log was called from
	///   - function: the function the log was called from
	///   - line: the line in the file the log was called from
	/// - Returns: A String
	public static func stats(_ file: String = #file,
							 function: String = #function,
							 line: Int = #line) -> String {
		let fileString: NSString = NSString(string: file)
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = Options.dateFormatter
		if Thread.isMainThread {
			return "[M] [\(dateFormatter.string(from: .now))] [\(fileString.lastPathComponent): \(function), line:\(line)]:\n\t →"
		} else {
			return "[!=M] [\(dateFormatter.string(from: .now))] [\(fileString.lastPathComponent): \(function), line:\(line)]:\n\t →"
		}
	}
	
	/// Gets the content of the local logfile
	public static func getLogsFromFile() -> String {
		let url = logfileUrl
		let logs = try? String(contentsOf: url)
		return logs ?? "No Logs Found"
	}
	
	/// Deletes the local logfile
	public static func deleteLogFile() {
		let url = logfileUrl
		try? FileManager.default.removeItem(at: url)
	}
	
	
	/// Options to configure logging behavior globally
	public struct Options {
		
		/// A DateFormat String
		public static var dateFormatter = "yyyy-MM-dd HH:mm:ss:SSS"
		
		/// The debug level for logs [0...5]
		///
		/// - **.debug:** lowest possible level, showing all logs (0)
		/// - **.info:** showing info, notice, success, warning & error logs (1)
		/// - **.notice:** showing notice, success, warning & error logs (2)
		/// - **.success:** showing success, warning & error logs (3)
		/// - **.warning:** showing warning & error logs (4)
		/// - **.error:** highest possible level, showing only errors (5)
		public static var debugLevel: DebugLevel = .debug
		
		/// Flag to setup if stats are included in logs
		public static var logStats: Bool = true
		
		/// Flag to setup if logs are saved to a local file
		public static var logToLocalFile: Bool = true
		
	}
	
	
	/// Indicates which logs are being displayed or not
	///
	/// - Attention: Debug logs itself only show in DEBUG build configuration. Make sure  the `-DDEBUG` flag is set in Build Configuration
	public enum DebugLevel: Int, Comparable {
		
		/// lowest possible level, showing all logs
		///
		/// - Attention: Debug logs itself only show in DEBUG build configuration. Make sure  the `-DDEBUG` flag is set in Build Configuration
		case debug = 0
		
		/// showing info, notice, success, warning & error logs
		case info = 1
		
		/// showing notice, success, warning & error logs
		case notice = 2
		
		/// showing success, warning & error logs
		case success = 3
		
		/// showing warning & error logs
		case warning = 4
		
		/// highest possible level, showing only errors
		case error = 5
		
		/// Make DebugLevel Comparable
		public static func < (lhs: LPLog.DebugLevel, rhs: LPLog.DebugLevel) -> Bool {
			lhs.rawValue < rhs.rawValue
		}
	}
	
	/// Types of logs that can be created
	///
	/// - Attention: Debug logs itself only show in DEBUG build configuration. Make sure  the `-DDEBUG` flag is set in Build Configuration
	public enum Message {
		
		/// lowest possible level, showing all logs
		///
		/// - Attention: Debug logs itself only show in DEBUG build configuration. Make sure  the `-DDEBUG` flag is set in Build Configuration
		case debug(_: String)
		
		/// showing info, notice, success, warning & error logs
		case info(_: String)
		
		/// showing notice, success, warning & error logs
		case notice(_: String)
		
		/// showing success, warning & error logs
		case success(_: String)
		
		/// showing warning & error logs
		case warning(_: String)
		
		/// highest possible level, showing only errors
		case error(_: String)
	}
}

// MARK: Global Log Function

/// Global function that logs the given message to the console and a local logfile
///
/// If also specified in ``LPLog/Options/logToLocalFile`` logs will also be saved to a local file.
///
/// Set ``LPLog/Options/logStats`` to `true` to include information when, where this method was called.
///
/// Consider changing the ``LPLog/Options/debugLevel`` accordingly.
///
/// Do not change the `file`, `function` or `line` parameters, since they will
/// reference to the location where this method was called from
///
/// - Attention: Debug logs itself only show in DEBUG build configuration. Make sure  the `-DDEBUG` flag is set in Build Configuration
///
/// - Parameters:
///   - type: A ``LPLog/Message`` object containing the message as a ``String``
public func log(_ type: LPLog.Message,
				file: String = #file,
				function: String = #function,
				line: Int = #line) {
	
	/// Saves the log to the defined logfile
	/// - Parameter message:the already formatted log
	func save(_ message: String) throws {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = LPLog.Options.dateFormatter
		let timeString: String = dateFormatter.string(from: .now)
		let url = LPLog.logfileUrl
		try (timeString + ": " + message).appendLineToURL(fileURL: url)
	}
	
	/// Logs the given parameters formatted to the console
	/// - Parameters:
	///   - prefix: The begin of the line
	///   - message: the actual message of the log
	///   - stats: a formatted String containing info about time, and code location
	func log(_ prefix: String, message: String, stats: String) {
		// generate log message
		let log: String = prefix + String.space + (LPLog.Options.logStats ? (stats + String.space) : String.empty) + message
		
		// print to console
		print(log)
		
		// save to file
		if LPLog.Options.logToLocalFile {
			do {
				try save(log)
			} catch {
				fatalError("FATAL ERROR: \(LPLog.stats()) \(error.localizedDescription)")
			}
		}
	}
	
	// get formatted stats String
	let stats = LPLog.stats(file, function: function, line: line)
	
	// log depending on Message and DebugLevel
	switch type {
	case .debug(let message):
#if DEBUG
		if LPLog.Options.debugLevel <= .debug {
			log("🚫 Debug:", message: message, stats: stats)
		}
#endif
	case .info(let message):
		if LPLog.Options.debugLevel <= .info {
			log("ℹ️ Info:", message: message, stats: stats)
		}
	case .notice(let message):
		if LPLog.Options.debugLevel <= .notice {
			log("✳️ Notice:", message: message, stats: stats)
		}
	case .success(let message):
		if LPLog.Options.debugLevel <= .success {
			log("✅ Success:", message: message, stats: stats)
		}
	case .warning(let message):
		if LPLog.Options.debugLevel <= .warning {
			log("⚠️ Warning:", message: message, stats: stats)
		}
	case .error(let message):
		if LPLog.Options.debugLevel <= .error {
			log("🛑 Error:", message: message, stats: stats)
		}
	}

}





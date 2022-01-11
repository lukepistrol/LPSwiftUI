//
//  LPListRow.swift
//  LPSwiftUI
//
//  Created by Lukas Pistrol on 11.01.22.
//

import SwiftUI

/// List Row with a leading title
public struct LPListRow: View {
	private var title: String

	private var padding: Double

	public init(_ title: String, padding: Double = 0) {
		self.title = title
		self.padding = padding
	}

	@ViewBuilder
	public var body: some View {
		Text(title)
			.padding(.vertical, padding)
	}
}

/// List Row with a leading title embedded in a Navigation Link
public struct LPListLink<D>: View where D: View {
	private var title: String
	private var destination: () -> D

	private var padding: Double

	public init(_ title: String, padding: Double = 0, destination: @escaping () -> D) {
		self.title = title
		self.destination = destination
		self.padding = padding
	}

	@ViewBuilder
	public var body: some View {
		NavigationLink {
			destination()
				.navigationTitle(title)
		} label: {
			LPListRow(title, padding: padding)
		}
    }
}

/// List Row with a leading title and a trailing detail text
public struct LPListRowDetail: View {
	private var title: String
	private var detail: String

	private var padding: Double

	public init(_ title: String, detail: String, padding: Double = 0) {
		self.title = title
		self.detail = detail
		self.padding = padding
	}

	public var body: some View {
		HStack {
			Text(title)
			Spacer()
			Text(detail)
				.foregroundColor(.secondary)
				.font(.callout)
		}
		.padding(.vertical, padding)
	}
}

/// List Row with a leading title and a trailing detail text embedded in a Navigation Link
public struct LPListDetailLink<D>: View where D: View {
	private var title: String
	private var detail: String
	private var destination: () -> D

	private var padding: Double

	public init(_ title: String, detail: String, padding: Double = 0, destination: @escaping () -> D) {
		self.title = title
		self.detail = detail
		self.destination = destination
		self.padding = padding
	}

	@ViewBuilder
	public var body: some View {
		NavigationLink {
			destination()
				.navigationTitle(title)
		} label: {
			LPListRowDetail(title, detail: detail, padding: padding)
		}
	}
}

/// List Row with a leading title and a detail text vertically stacked
public struct LPListRowBottomDetail: View {
	private var title: String
	private var detail: String

	private var padding: Double

	public init(_ title: String, detail: String, padding: Double = 4) {
		self.title = title
		self.detail = detail
		self.padding = padding
	}

	public var body: some View {
		VStack(alignment: .leading) {
			Text(title)
			Text(detail)
				.foregroundColor(.secondary)
				.font(.subheadline)
		}
		.padding(.vertical, padding)
	}
}

/// List Row with a leading title and a trailing detail text embedded in a Navigation Link
public struct LPListBottomDetailLink<D>: View where D: View {
	private var title: String
	private var detail: String
	private var destination: () -> D

	private var padding: Double

	public init(_ title: String, detail: String, padding: Double = 4, destination: @escaping () -> D) {
		self.title = title
		self.detail = detail
		self.destination = destination
		self.padding = padding
	}

	@ViewBuilder
	public var body: some View {
		NavigationLink {
			destination()
				.navigationTitle(title)
		} label: {
			LPListRowBottomDetail(title, detail: detail, padding: padding)
		}
	}
}

private struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView {
			List {
				Section {
					LPListRow("Title")
					LPListLink("Title") {
						Text("Title")
					}
				}
				Section {
					LPListRowDetail("Title", detail: "Detail")
					LPListDetailLink("Title", detail: "Detail") {
						Text("Title")
					}
				}
				Section {
					LPListRowBottomDetail("Title", detail: "Detail")
					LPListBottomDetailLink("Title", detail: "Detail") {
						Text("Title")
					}
				}
			}
		}
    }
}

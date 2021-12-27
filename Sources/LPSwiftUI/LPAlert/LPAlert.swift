//
//  LPAlert.swift
//  
//
//  Created by Lukas Pistrol on 27.12.21.
//

import SwiftUI

public extension View {
	/// A custom implementation of an alert which can show any view in its header
	/// - Parameters:
	///   - isPresented: Binding wether  alert is shown or not
	///   - actions: Array of Alert Actions
	///   - message: A view to display on top of the action buttons
	/// - Returns: some View
	@ViewBuilder func lpAlert<M>(_ isPresented: Binding<Bool>,
								 actions: Array<LPAlert<M>.LPAlertAction>,
								 message: @escaping () -> M) -> some View where  M : View {
		
		self
			.overlay(alignment: .center) {
				Color.black
					.opacity(isPresented.wrappedValue ? 0.25 : 0)
					.allowsHitTesting(false)
					.ignoresSafeArea()
					.overlay(alignment: .center) {
						if isPresented.wrappedValue {
							LPAlert(message: message,
									isPresented: isPresented,
									actions: actions)
								.transition(.opacity)
						}
					}
					.scaleEffect(isPresented.wrappedValue ? 1 : 1.1)
			}
			.animation(.easeInOut(duration: 0.15),
					   value: isPresented.wrappedValue)
	}
	
}

public struct LPAlert<M>: View where M: View {
	var message: () -> M
	var isPresented: Binding<Bool>
	var actions: Array<LPAlertAction>
	
	init(message: @escaping () -> M, isPresented: Binding<Bool>, actions: Array<LPAlertAction>) {
		self.message = message
		self.isPresented = isPresented
		self.actions = actions
	}
	
	public var body: some View {
		VStack(spacing: 0) {
			message()
				.padding(.bottom)
			VStack(spacing: 0) {
				ForEach(actions) { action in
					Divider()
					LPAlertButton(title: action.title, role: action.role) {
						action.action()
						isPresented.wrappedValue = false
					}
				}
			}
		}
		.frame(maxWidth: 300)
		.clipShape(RoundedRectangle(cornerRadius: 14))
		.background(RoundedRectangle(cornerRadius: 14).foregroundStyle(.regularMaterial))
		.padding(.horizontal, 30)
	}
	
	public struct LPAlertAction: Identifiable {
		public var id = UUID()
		var title: String
		var role: Style
		var action: () -> Void
		
		init(title: String, role: Style = .primary, action: @escaping () -> Void) {
			self.title = title
			self.role = role
			self.action = action
		}
		
		enum Style {
			case cancel, primary, destructive
		}
	}
	
	/// A Button for a Custom Alert
	private struct LPAlertButton: View {
		
		var title: String
		var role: LPAlertAction.Style
		var action: () -> Void
		
		init(title: String, role: LPAlertAction.Style = .primary, action: @escaping () -> Void) {
			self.title = title
			self.role = role
			self.action = action
		}
		
		@State private var hovered = false
		
		var body: some View {
			Button(role: .cancel) {
				action()
			} label: {
				Text(title)
					.padding(16)
					.frame(maxWidth: .infinity)
					.foregroundColor(role == .destructive ?
										.red : .blue)
					.font(role == .primary ?
							.headline : .body)
			}
			.background(hovered ?
						Rectangle().foregroundStyle(.regularMaterial) :
							Rectangle().foregroundStyle(.thinMaterial))
			.onHover { isHovered in
				self.hovered = isHovered
			}
		}
	}
}

//
//  LPImagePicker.swift
//  LPSwiftUI
//
//  Created by Lukas Pistrol on 07.01.22.
//

#if os(iOS)
import SwiftUI
import PhotosUI

/// An Image Picker to pick images from photos
public struct LPImagePicker: UIViewControllerRepresentable {
	
	@Binding private var image: UIImage?
	
	private var scaledSize: CGSize?
	private var sourceType: UIImagePickerController.SourceType
	
	public init(_ image: Binding<UIImage?>,
				size: CGSize? = nil,
				sourceType: UIImagePickerController.SourceType = .photoLibrary) {
		self._image = image
		self.scaledSize = size
		self.sourceType = sourceType
	}
	
	public func makeUIViewController(context: Context) -> UIImagePickerController {
		let picker = UIImagePickerController()
		picker.delegate = context.coordinator
		picker.allowsEditing = true
		picker.sourceType = sourceType
		return picker
	}
	
	public func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
	
	public func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
}

public extension LPImagePicker {
	class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
		let parent: LPImagePicker
		
		init(_ parent: LPImagePicker) {
			self.parent = parent
		}
		
		public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
			if let image = info[.editedImage] as? UIImage {
				if let scaledSize = parent.scaledSize {
					self.parent.image = image.cropped().scale(to: scaledSize)
				} else {
					self.parent.image = image
				}
				picker.dismiss(animated: true)
			} else if let image = info[.originalImage] as? UIImage {
				if let scaledSize = parent.scaledSize {
					self.parent.image = image.cropped().scale(to: scaledSize)
				} else {
					self.parent.image = image
				}
				picker.dismiss(animated: true)
			}
		}
	}
}
#endif

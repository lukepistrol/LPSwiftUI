//
//  LPImagePicker.swift
//  LPSwiftUI
//
//  Created by Lukas Pistrol on 07.01.22.
//

#if os(iOS)
import SwiftUI
import PhotosUI

@available(iOS 16, *)
public struct LPCameraPicker<Content: View>: View {

    private var content: Content
    @State private var displayCamera: Bool = false
    @Binding private var selection: CameraPickerItem?

    public init(_ selection: Binding<CameraPickerItem?>, content: @escaping () -> Content) {
        self._selection = selection
        self.content = content()
    }

    public var body: some View {
        Button {
            displayCamera.toggle()
        } label: {
            content
        }
        .fullScreenCover(isPresented: $displayCamera) {
            LPCameraPickerRepresentable($selection)
                .ignoresSafeArea()
        }
    }
}

@available(iOS 16, *)
internal struct LPCameraPickerRepresentable: UIViewControllerRepresentable {

    @Binding private var selection: CameraPickerItem?

    init(_ selection: Binding<CameraPickerItem?>) {
        self._selection = selection
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera

        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        private let parent: LPCameraPickerRepresentable

        init(_ parent: LPCameraPickerRepresentable) {
            self.parent = parent
        }

        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
        ) {
            if let image = info[.originalImage] as? UIImage,
               let data = image.pngData() {
                parent.selection = CameraPickerItem(imageData: data)
                picker.dismiss(animated: true)
            }
        }
    }
}

@available(iOS 16, *)
public struct CameraPickerItem: Codable, Transferable, Equatable {

    public static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .image)
    }

    public let imageData: Data
}


/// An Image Picker to pick images from photos
@available(iOS, deprecated: 16.0, message: "Use PhotosUI's `PhotosPicker` instead")
public struct LPImagePicker: UIViewControllerRepresentable {
	
	@Binding private var image: UIImage?
	
	private var scaledSize: CGSize
	private var sourceType: UIImagePickerController.SourceType
	private var cropped: Bool
	
	public init(_ image: Binding<UIImage?>,
				size: CGSize = CGSize(width: 312, height: 312),
				cropped: Bool = false,
				sourceType: UIImagePickerController.SourceType = .photoLibrary) {
		self._image = image
		self.scaledSize = size
		self.cropped = cropped
		self.sourceType = sourceType
	}
	
	public func makeUIViewController(context: Context) -> UIImagePickerController {
		let picker = UIImagePickerController()
		picker.delegate = context.coordinator
		picker.allowsEditing = cropped ? true : false
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
				if parent.cropped {
					self.parent.image = image.cropped().scale(to: parent.scaledSize)
				} else {
					self.parent.image = image.scale(to: parent.scaledSize)
				}
				picker.dismiss(animated: true)
			} else if let image = info[.originalImage] as? UIImage {
				if parent.cropped {
					self.parent.image = image.cropped().scale(to: parent.scaledSize)
				} else {
					self.parent.image = image.scale(to: parent.scaledSize)
				}
				picker.dismiss(animated: true)
			}
		}
	}
}
#endif


//
//  ImagePicker.swift
//  97EatsTask
//
//  Created by System Admin on 01/12/21.
//

import Foundation
import UIKit
import Photos

public protocol ImagePickerDelegate: class {
    var selectedImage : (_ image: UIImage?)->() { get set }
}

open class ImagePicker: NSObject,ImagePickerDelegate, UINavigationControllerDelegate {
    public var selectedImage: (UIImage?) -> () = {_ in }
    
    static let shared = ImagePicker()
    
    public override init() {
        self.pickerController = UIImagePickerController()
        super.init()
    }

    var pickerController: UIImagePickerController
    var presentationController: UIViewController?
    var delegate: ImagePickerDelegate?
    
    
    private func set(presentationController: UIViewController, selectedImageValue : @escaping (UIImage?) -> ()){
        
        self.presentationController = presentationController
        selectedImage = selectedImageValue
        
        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
        self.pickerController.mediaTypes = ["public.image"]
    }
    
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }
        
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            if self.checkPermission(sourceType: type){
                self.showPicketcontroller(sourceType: type)
            }
        }
    }
    private func showPicketcontroller(sourceType : UIImagePickerController.SourceType){
        DispatchQueue.main.async {
            self.pickerController.sourceType = sourceType
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }
   
    private func checkPermission(sourceType : UIImagePickerController.SourceType)->Bool{
        switch sourceType {
       
        case .photoLibrary:
            return isPhotoLibraryAccess(sourceType: sourceType)
            
        case .camera:
            return isCameraAccess()
            
        case .savedPhotosAlbum:
            return isPhotoLibraryAccess(sourceType: sourceType)
            
        @unknown default:
            break
            
        }
        return false
    }
    

    func isCameraAccess() ->Bool{
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authStatus {
        case .authorized:
            return true
        case .denied,.restricted: break
//            openSettings(msg: "Camera access required for capturing photos!")
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { (response) in
                if response{
                    self.showPicketcontroller(sourceType: .camera)
                }
            }
        default:
            return true
             //Done
        }
        return false
    }

    
    
    func isPhotoLibraryAccess(sourceType : UIImagePickerController.SourceType)->Bool{
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            return true
        //handle authorized status
        case .denied, .restricted :
//            openSettings()
            break
        //handle denied status
        case .notDetermined:
            // ask for permissions
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized:
                    self.showPicketcontroller(sourceType: sourceType)
                    break
                // as above
                case .denied, .restricted:
                    break
                // as above
                case .notDetermined:
                    break
                // won't happen but still
                @unknown default:
                    fatalError()
                }
            }
        default:
             return true
        }
        return false
    }
    
//    func openSettings(msg : String = "Access required for getting photos!") {
//        let deleteAlert = UIAlertController(title: LSString(.AppName), message: LSString(.DeleteUser), preferredStyle: UIAlertController.Style.alert)
//
//        deleteAlert.addAction(UIAlertAction(title: "Goto Setting", style: .default, handler: { (action: UIAlertAction!) in
//                                                if let url = URL(string: UIApplication.openSettingsURLString) {
//                                                    if #available(iOS 10.0, *) {
//                                                        UIApplication.shared.open(url, options: [:], completionHandler: { _ in
//                                                            // Handle
//                                                        })
//                                                    } else {
//                                                        // Fallback on earlier versions
//                                                    }
//                                                }        }))
//
//        deleteAlert.addAction(UIAlertAction(title: LSString(.cancel), style: .cancel, handler: { (action: UIAlertAction!) in
//            self.dismiss(animated: true, completion: nil)
//        }))
//        present(deleteAlert, animated: true, completion: nil)
//
//    }

    public func present(from sourceView: UIView? = nil,presentationController: UIViewController, selectedImageValue : @escaping (UIImage?) -> ()) {
        set(presentationController: presentationController, selectedImageValue: selectedImageValue)
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
      
        if let action = self.action(for: .camera, title: "Take Photo") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .savedPhotosAlbum, title: "Camera Roll") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .photoLibrary, title: "Photo Library") {
            alertController.addAction(action)
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        if UIDevice.current.userInterfaceIdiom == .pad, let srcView = sourceView{
            alertController.popoverPresentationController?.sourceView = srcView
            alertController.popoverPresentationController?.sourceRect = srcView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }
//        alertController.view.tintColor = AppColor.app_red[.black]
        self.presentationController?.present(alertController, animated: true)
    }
    
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)
        selectedImage(image)
    }
}

extension ImagePicker: UIImagePickerControllerDelegate {
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return self.pickerController(picker, didSelect: nil)
        }
        self.pickerController(picker, didSelect: image)
    }
    
}


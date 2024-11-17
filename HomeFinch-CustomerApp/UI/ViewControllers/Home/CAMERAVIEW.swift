//
//  CAMERAVIEW.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 04/12/20.
//

import UIKit
import AVFoundation
import SwiftyCam
import BSImagePicker


class CAMERAVIEW: SwiftyCamViewController, SwiftyCamViewControllerDelegate , YMSPhotoPickerViewControllerDelegate
{
   
    
    @IBOutlet weak var btnTakePhoto: SwiftyRecordButton!
    @IBOutlet weak var btnLibrary: UIButton!
    @IBOutlet weak var btnCross: UIButton!
    @IBOutlet weak var btnflash: UIButton!
    @IBOutlet weak var btnFlip: UIButton!

    @IBOutlet weak var TopView: UIView!
    @IBOutlet weak var BottomView: UIView!
    @IBOutlet weak var lblDesc: UILabel!

    weak var delegate: cameracaptureDelegate? = nil

    
    var ImgSelectCount : Int = 5
    
    var strCome : String = ""


    override func viewDidLoad() {
        super.viewDidLoad()

        shouldPrompToAppSettings = true
        cameraDelegate = self
        maximumVideoDuration = 10.0
        shouldUseDeviceOrientation = true
        allowAutoRotate = true
        audioEnabled = false
        flashMode = .auto
        btnTakePhoto.buttonEnabled = true
        pinchToZoom = true
        maxZoomScale = 2.0
        
        btnTakePhoto.delegate = self
        
        if strCome != "detail"
        {
            UserSettings.shared.images.removeAll()
        }
        if strCome == "profile"
        {
            lblDesc.text = "Tap for photo"
            btnTakePhoto.gestureRecognizers?.removeLast()
        }
       
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
        if UserSettings.shared.images.count < 5
        {
            ImgSelectCount = 5 - UserSettings.shared.images.count
        }
        else
        {
            ImgSelectCount = 0
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        ImgSelectCount = 5 - UserSettings.shared.images.count
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func swiftyCamSessionDidStartRunning(_ swiftyCam: SwiftyCamViewController) {
        print("Session did start running")
        btnTakePhoto.buttonEnabled = true
    }
    
    func swiftyCamSessionDidStopRunning(_ swiftyCam: SwiftyCamViewController) {
        print("Session did stop running")
        btnTakePhoto.buttonEnabled = false
    }
    

    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didTake photo: UIImage) {
        
        if strCome == "profile"
        {
            self.delegate?.didSelectProfileImage(imageProfile: photo)
            self.navigationController?.popViewController(animated: false)
            return
        }
        
        ImgSelectCount = ImgSelectCount + 1
        let imageName = String(format: "Picture_%.f.jpg", Date().timeIntervalSince1970)
        
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let photoURL = NSURL(fileURLWithPath: documentDirectory)
        let localPath = photoURL.appendingPathComponent(imageName)
        do
        {
            try photo.jpegData(compressionQuality: 0.5)?.write(to: localPath!)
            let dict = ["imagename":imageName ,"videoname":""] as [String : Any]
            UserSettings.shared.images.append(dict)
            
            let preview = PREVIEW.create(isVideo: false, image: nil, videourl: nil, comeFrom: self.strCome)
            self.navigationController?.pushViewController(preview, animated: false)

            
        }
        catch
        {
            print("error saving file")
        }
    }

    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didBeginRecordingVideo camera: SwiftyCamViewController.CameraSelection) {
        print("Did Begin Recording")
        btnTakePhoto.growButton()
        hideButtons()
    }

    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishRecordingVideo camera: SwiftyCamViewController.CameraSelection) {
        print("Did finish Recording")
        btnTakePhoto.shrinkButton()
        showButtons()
    }

    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishProcessVideoAt url: URL) {
        
        self.encodeVideo(at: url) { [self] videourl, error1 in
            
            DispatchQueue.main.async {
                
                if let url1 = videourl
                {
                    self.ImgSelectCount = self.ImgSelectCount + 1
                    
                    let videoName = String(format: "video_%.f.mp4", Date().timeIntervalSince1970)
                    
            //        let data = CommonFunction.shared.getThumbnailImage(forUrl: url)!.jpegData(compressionQuality: 0.5)

            //        let base64Encoded = data?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))

                    let videoData = NSData(contentsOf: url1)
            //
            //        let dict = ["image": base64Encoded, "url" : url,"name":imageName,"videodata": videoData] as [String : Any]
            //        UserSettings.shared.images.append(dict)
                    
                    
                    let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
                    let photoURL = NSURL(fileURLWithPath: documentDirectory)
                    let localPath = photoURL.appendingPathComponent(videoName)
                    do
                    {
                        try videoData?.write(to: localPath!)
                        let dict = ["imagename":"" ,"videoname":videoName] as [String : Any]
                        UserSettings.shared.images.append(dict)
                        
                        let preview = PREVIEW.create(isVideo: true, image: nil, videourl: url1, comeFrom: self.strCome)
                        self.navigationController?.pushViewController(preview, animated: false)

                        
                    }
                    catch
                    {
                        print("error saving file")
                    }
                }
            }
            
            
        }

    }

    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFocusAtPoint point: CGPoint) {
        print("Did focus at point: \(point)")
        focusAnimationAt(point)
    }
    
    func swiftyCamDidFailToConfigure(_ swiftyCam: SwiftyCamViewController) {
        let message = NSLocalizedString("Unable to capture media", comment: "Alert message when something goes wrong during capture session configuration")
        let alertController = UIAlertController(title: "AVCam", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"), style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didChangeZoomLevel zoom: CGFloat) {
        print("Zoom level did change. Level: \(zoom)")
        print(zoom)
    }

    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didSwitchCameras camera: SwiftyCamViewController.CameraSelection) {
        print("Camera did change to \(camera.rawValue)")
        print(camera)
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFailToRecordVideo error: Error) {
        print(error)
    }
    
    //MARK: Encode Video
    func encodeVideo(at videoURL: URL, completionHandler: ((URL?, Error?) -> Void)?)  {
        let avAsset = AVURLAsset(url: videoURL, options: nil)
            
        //Create Export session
        guard let exportSession = AVAssetExportSession(asset: avAsset, presetName: AVAssetExportPresetPassthrough) else {
            completionHandler?(nil, nil)
            return
        }
            
        //Creating temp path to save the converted video
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as URL
        
        let imagename = String(format: "video_%.f.mp4", Date().timeIntervalSince1970)
        let filePath = documentsDirectory.appendingPathComponent(imagename)
            
        //Check if the file already exists then remove the previous file
//        if FileManager.default.fileExists(atPath: filePath.path) {
//            do {
//                try FileManager.default.removeItem(at: filePath)
//            } catch {
//                completionHandler?(nil, error)
//            }
//        }
            
        exportSession.outputURL = filePath
        exportSession.outputFileType = AVFileType.mp4
        exportSession.shouldOptimizeForNetworkUse = true
        let start = CMTimeMakeWithSeconds(0.0, preferredTimescale: 0)
        let range = CMTimeRangeMake(start: start, duration: avAsset.duration)
        exportSession.timeRange = range
            
        exportSession.exportAsynchronously(completionHandler: {() -> Void in
            switch exportSession.status {
            case .failed:
                print(exportSession.error ?? "NO ERROR")
                completionHandler?(nil, exportSession.error)
            case .cancelled:
                print("Export canceled")
                completionHandler?(nil, nil)
            case .completed:
                //Video conversion finished
                print("Successful!")
                print(exportSession.outputURL ?? "NO OUTPUT URL")
                completionHandler?(exportSession.outputURL, nil)
                    
                default: break
            }
                
        })
    }

    
    //MARK: Button methods
    
    
    @IBAction func btnFlashClick(_ sender: Any) {
        
        toggleFlashAnimation()

    }
    
    @IBAction func btnCrossClick(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }

    
    @IBAction func btnFlipClick(_ sender: Any) {
        switchCamera()

    }
    
    @IBAction func btnLibraryClick(_ sender: Any) {
        
//        let pickerViewController = YMSPhotoPickerViewController.init()
//        pickerViewController.numberOfMediaToSelect =  UInt(ImgSelectCount)
//        pickerViewController.configuration.sourceType = .photo
//        pickerViewController.delegate = self
//
//        // Theme setting
//        let customColor = UserSettings.shared.themeColor()
//        pickerViewController.theme.titleLabelTextColor = UserSettings.shared.ScreentitleColor()
//        pickerViewController.theme.navigationBarBackgroundColor = customColor
//        pickerViewController.theme.tintColor = UIColor.black
//        pickerViewController.theme.orderTintColor = customColor
//        pickerViewController.theme.orderLabelTextColor = UIColor.white
//        pickerViewController.theme.cameraVeilColor = customColor
//        pickerViewController.theme.cameraIconColor = UIColor.white
//        pickerViewController.theme.statusBarStyle = .default
//
//        self.present(pickerViewController, animated: true, completion: nil)
        AppDelegate.shared.statusView.isHidden = true
        
        let imagePicker = ImagePickerController()
        imagePicker.settings.selection.max = ImgSelectCount
        imagePicker.settings.selection.unselectOnReachingMax = false
        imagePicker.settings.fetch.assets.supportedMediaTypes = [.image]
        imagePicker.albumButton.tintColor = UserSettings.shared.themeColor2()
        imagePicker.cancelButton.tintColor = UIColor.black
        imagePicker.doneButton.tintColor = UserSettings.shared.themeColor2()
        imagePicker.navigationBar.backgroundColor = UserSettings.shared.themeColor()
        imagePicker.settings.theme.backgroundColor = .black
        imagePicker.settings.theme.selectionFillColor = UserSettings.shared.themeColor()
        imagePicker.settings.theme.selectionStrokeColor = UserSettings.shared.themeColor2()
        imagePicker.settings.theme.selectionShadowColor = UserSettings.shared.themeColor2()
        imagePicker.settings.theme.previewTitleAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),NSAttributedString.Key.foregroundColor: UIColor.white]
        imagePicker.settings.theme.previewSubtitleAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),NSAttributedString.Key.foregroundColor: UIColor.white]
        imagePicker.settings.theme.albumTitleAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),NSAttributedString.Key.foregroundColor: UIColor.white]

        if strCome == "profile"
        {
            imagePicker.settings.preview.enabled = true
            imagePicker.settings.selection.max = 1
        }
        

        presentImagePicker(imagePicker, select: { (asset) in
            // User selected an asset. Do something with it. Perhaps begin processing/upload?
           

        }, deselect: { (asset) in
            // User deselected an asset. Cancel whatever you did when asset was selected.
        }, cancel: { (assets) in
            // User canceled selection.
            AppDelegate.shared.statusView.isHidden = false

        }, finish: { (assets) in
            
            AppDelegate.shared.statusView.isHidden = false

            print(assets.count)
            let imageManager = PHImageManager.init()
            let options = PHImageRequestOptions.init()
            options.deliveryMode = .highQualityFormat
            options.resizeMode = .none
            options.isSynchronous = true

            var i = 0
            for asset: PHAsset in assets
            {
                let scale = UIScreen.main.scale
                let targetSize = CGSize(width: (200) * scale, height: (200) * scale)
                imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: options) { (image,info) in
                    
                    let imageName = String(format: "%dPicture_%.f.jpg",i, Date().timeIntervalSince1970)
                    
                    i = i + 1
                    
                    if image != nil
                    {
                        if self.strCome == "profile"
                        {
                            self.delegate?.didSelectProfileImage(imageProfile: image!)
                            self.navigationController?.popViewController(animated: true)
                            return
                        }
                        
                        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
                        let photoURL = NSURL(fileURLWithPath: documentDirectory)
                        let localPath = photoURL.appendingPathComponent(imageName)
                        do
                        {
                            try image?.jpegData(compressionQuality: 0.5)?.write(to: localPath!)
                            let dict = ["imagename":imageName ,"videoname":""] as [String : Any]
                            UserSettings.shared.images.append(dict)
                            
                            let preview = PREVIEW.create(isVideo: false, image: nil, videourl: nil, comeFrom: self.strCome)
                            self.navigationController?.pushViewController(preview, animated: false)
                            
                        }
                        catch
                        {
                            print("error saving file")
                        }
                    }
                }
            }
            
        })

        
        
    }
    
    
    
    // MARK: YMS Picker Delegate   // Not Used
    func photoPickerViewControllerDidReceivePhotoAlbumAccessDenied(_ picker: YMSPhotoPickerViewController!)
    {
        let alertController = UIAlertController.init(title:"Allow photo album access?", message:"Need your permission to access photo album", preferredStyle: .alert)
        let dismissAction = UIAlertAction.init(title:"Cancel",style: .cancel, handler: nil)
        let settingsAction = UIAlertAction.init(title:"Settings", style: .default) { (action) in
            UIApplication.shared.openURL(URL.init(string: UIApplication.openSettingsURLString)!)
        }
        alertController.addAction(dismissAction)
        alertController.addAction(settingsAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func photoPickerViewControllerDidReceiveCameraAccessDenied(_ picker: YMSPhotoPickerViewController!)
    {
        let alertController = UIAlertController.init(title:"Allow camera album access?", message:"Need your permission to take a photo", preferredStyle: .alert)
        
        let dismissAction = UIAlertAction.init(title:"cancel",style: .cancel, handler: nil)
        
        let settingsAction = UIAlertAction.init(title:"Settings", style: .default) { (action) in
            UIApplication.shared.openURL(URL.init(string: UIApplication.openSettingsURLString)!)
        }
        alertController.addAction(dismissAction)
        alertController.addAction(settingsAction)
        
        // The access denied of camera is always happened on picker, present alert on it to follow the view hierarchy
        picker.present(alertController, animated: true, completion: nil)
    }
    
    func photoPickerViewController(_ picker: YMSPhotoPickerViewController!, didFinishPickingMedias assets: [PHAsset]!) {
        picker.dismiss(animated: true) {
            let imageManager = PHImageManager.init()
            let options = PHImageRequestOptions.init()
            options.deliveryMode = .highQualityFormat
            options.resizeMode = .none
            options.isSynchronous = true
            
            var i = 0
            for asset: PHAsset in assets
            {
                let scale = UIScreen.main.scale
                let targetSize = CGSize(width: (200) * scale, height: (200) * scale)
                imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: options) { (image,info) in
                    
                    let imageName = String(format: "%dPicture_%.f.jpg",i, Date().timeIntervalSince1970)
                    
                    i = i + 1
                    
                    if image != nil
                    {
//                        let data = image!.jpegData(compressionQuality: 0.5)
//                        let base64Encoded = data?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
//                        let dict = ["image":base64Encoded , "url" : nil,"name":imageName] as [String : Any]
//                        UserSettings.shared.images.append(dict)
                        
                        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
                        let photoURL = NSURL(fileURLWithPath: documentDirectory)
                        let localPath = photoURL.appendingPathComponent(imageName)
                        do
                        {
                            try image?.jpegData(compressionQuality: 0.5)?.write(to: localPath!)
                            let dict = ["imagename":imageName ,"videoname":""] as [String : Any]
                            UserSettings.shared.images.append(dict)
                            
                        }
                        catch
                        {
                            print("error saving file")
                        }
                    }
                }
            }
            
            do
            {
                let preview = PREVIEW.create(isVideo: false, image: nil, videourl: nil, comeFrom: self.strCome)
                self.navigationController?.pushViewController(preview, animated: false)

            }
        }
    }
    
    func photoPickerViewController(_ picker: YMSPhotoPickerViewController!, didFinishPickingMedia asset: PHAsset!)
    {
        let imageManager = PHImageManager.init()
        let options = PHImageRequestOptions.init()
        options.deliveryMode = .highQualityFormat
        options.resizeMode = .none
        options.isSynchronous = true
        
        picker.dismiss(animated: true)
        {
            let scale = UIScreen.main.scale
            let targetSize = CGSize(width: (200) * scale, height: (200) * scale)
            imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: options) { (image,info) in

                let imageName = String(format: "Picture_%.f.jpg", Date().timeIntervalSince1970)

                if image != nil
                {
//                    let data = image!.jpegData(compressionQuality: 0.5)
//                    let base64Encoded = data?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
//
//                    let dict = ["image":base64Encoded , "url" : nil,"name":imageName] as [String : Any]
//                    UserSettings.shared.images.append(dict)
                    


                    let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
                    let photoURL = NSURL(fileURLWithPath: documentDirectory)
                    let localPath = photoURL.appendingPathComponent(imageName)
                    do
                    {
                        try image?.jpegData(compressionQuality: 0.5)?.write(to: localPath!)
                        let dict = ["imagename":imageName ,"videoname":""] as [String : Any]
                        UserSettings.shared.images.append(dict)
                        
                        let preview = PREVIEW.create(isVideo: false, image: nil, videourl: nil, comeFrom: self.strCome)
                        self.navigationController?.pushViewController(preview, animated: false)

                        
                    }
                    catch
                    {
                        print("error saving file")
                    }
                    
                }
            }
        }
    }
   
}
extension CAMERAVIEW {
    
    fileprivate func hideButtons() {
        UIView.animate(withDuration: 0.25) {
            self.btnflash.alpha = 0.0
            self.btnFlip.alpha = 0.0
        }
    }
    
    fileprivate func showButtons() {
        UIView.animate(withDuration: 0.25) {
            self.btnflash.alpha = 1.0
            self.btnFlip.alpha = 1.0
        }
    }
    
    fileprivate func focusAnimationAt(_ point: CGPoint) {
        let focusView = UIImageView(image: #imageLiteral(resourceName: "focus"))
        focusView.center = point
        focusView.alpha = 0.0
        view.addSubview(focusView)
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
            focusView.alpha = 1.0
            focusView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }) { (success) in
            UIView.animate(withDuration: 0.15, delay: 0.5, options: .curveEaseInOut, animations: {
                focusView.alpha = 0.0
                focusView.transform = CGAffineTransform(translationX: 0.6, y: 0.6)
            }) { (success) in
                focusView.removeFromSuperview()
            }
        }
    }
    
    fileprivate func toggleFlashAnimation() {
        //flashEnabled = !flashEnabled
        if flashMode == .auto
        {
            flashMode = .on
            btnflash.setImage(UIImage(named: "Flash_on"), for: UIControl.State())
        }
        else if flashMode == .on
        {
            flashMode = .off
            btnflash.setImage(UIImage(named: "flashOutline"), for: UIControl.State())
        }
        else if flashMode == .off{
            flashMode = .auto
            btnflash.setImage(UIImage(named: "flashauto"), for: UIControl.State())
        }
    }
}
protocol cameracaptureDelegate : class {
    func didSelectProfileImage(imageProfile:UIImage)
}

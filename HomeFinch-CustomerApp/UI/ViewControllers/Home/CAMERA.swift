//
//  CAMERA.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 04/12/20.
//

import UIKit
import AVFoundation
import AVKit

class CAMERA: UIViewController , AVCapturePhotoCaptureDelegate , AVCaptureFileOutputRecordingDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    

    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!

    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var captureImageView: UIImageView!
    
    
    @IBOutlet weak var btnTakePhoto: UIButton!
    @IBOutlet weak var btnLibrary: UIButton!
    @IBOutlet weak var btnCross: UIButton!
    @IBOutlet weak var btnflash: UIButton!
    @IBOutlet weak var btnFlip: UIButton!


    @IBOutlet weak var TopView: UIView!
    @IBOutlet weak var BottomView: UIView!

    var flashmode : AVCaptureDevice.FlashMode!
    let videoFileOutput = AVCaptureMovieFileOutput()
    
    let movieOutput = AVCaptureMovieFileOutput()

    var previewLayer: AVCaptureVideoPreviewLayer!

    var activeInput: AVCaptureDeviceInput!

    var outputURL: URL!
    var imagePicker = UIImagePickerController()


    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.flashmode = .off
        self.btnflash.isSelected = false
        // Do any additional setup after loading the view.
        
//        imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        imagePicker.sourceType = UIImagePickerController.SourceType.camera
//        imagePicker.allowsEditing = true
//        self.present(imagePicker, animated: true, completion: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(HoldDown(_:)))
        btnTakePhoto.addGestureRecognizer(longPress)
    }
    

    //target functions
    
    @objc func HoldDown(_ gesture: UILongPressGestureRecognizer)
    {
        if gesture.state == .began {
            // Start recording the video
            self.captureSession?.addOutput(videoFileOutput)
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as URL
            let filePath = documentsURL.appendingPathComponent("tempMovie")
            videoFileOutput.startRecording(to: filePath, recordingDelegate: self)
        }
        else if gesture.state == .ended
        {
            print("release")
            videoFileOutput.stopRecording()
        }

    }

    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        
        if error != nil
        {
            print("success")
        }
        else
        {
            print(error.debugDescription)
        }
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        captureSession = AVCaptureSession()
//        captureSession.sessionPreset = .medium
//
//        guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
//            else {
//                print("Unable to access back camera!")
//                return
//        }
//
//        do {
//            let input = try AVCaptureDeviceInput(device: backCamera)
//            stillImageOutput = AVCapturePhotoOutput()
//
//            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
//                captureSession.addInput(input)
//                captureSession.addOutput(stillImageOutput)
//                setupLivePreview()
//            }
//        }
//        catch let error  {
//            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
//        }
//
//
//
//
//    }
    
    func setupLivePreview() {
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        videoPreviewLayer.videoGravity = .resize
        videoPreviewLayer.connection?.videoOrientation = .portrait
        previewView.layer.addSublayer(videoPreviewLayer)
        
        DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
            self.captureSession.startRunning()
            
            DispatchQueue.main.async {
                self.videoPreviewLayer.frame = self.previewView.bounds
                print(self.videoPreviewLayer.frame, self.previewView.frame)
            }
        }

    }

    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.captureSession.stopRunning()
//    }

    //MARK:- Button methods
    
    @IBAction func btnFlipClick(_ sender: Any) {
        
    }
    
    @IBAction func btnLibraryClick(_ sender: Any) {
        
    }
    
    @IBAction func btnFlashClick(_ sender: Any) {
        
        let btn = sender as! UIButton
        btn.isSelected = !btn.isSelected
        if btn.isSelected
        {
            self.flashmode = .on
        }
        else
        {
            self.flashmode = .off
        }
    }
    
    @IBAction func btnCrossClick(_ sender: Any) {
        
    }


    @IBAction func didTakePhoto(_ sender: Any) {
        
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        stillImageOutput.capturePhoto(with: settings, delegate: self)
    }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation()
            else { return }
        
        let image = UIImage(data: imageData)
        captureImageView.image = image
    }


}

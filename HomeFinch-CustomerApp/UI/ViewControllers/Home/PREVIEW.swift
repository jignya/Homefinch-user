//
//  PREVIEW.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 04/12/20.
//

import UIKit
import AVKit
import AVFoundation

class PREVIEW: UIViewController {
    
    static func create(isVideo:Bool,image:UIImage?, videourl: URL? , comeFrom:String) -> PREVIEW {
        let preview = PREVIEW.instantiate(fromImShStoryboard: .Home)
        preview.isVideo = isVideo
        preview.selectedImage = image
        preview.videoUrl = videourl
        preview.strComefrom = comeFrom
        return preview
    }
    
    @IBOutlet weak var TopView: UIView!
    @IBOutlet weak var BottomView: UIView!
    @IBOutlet weak var previewView: UIView!

    @IBOutlet weak var captureImageView: UIImageView!

    @IBOutlet weak var btnCross: UIButton!
    @IBOutlet weak var btnAddmore: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var collThumbnail: UICollectionView!


    var isVideo : Bool!
    var selectedImage: UIImage!
    var videoUrl: URL!
    var strComefrom: String!

    var player: AVPlayer?
    var playerController : AVPlayerViewController?
    
    // MARK: PRIVATE

    private let previewHandler = PreviewImagesCollectionHandler()

    override func viewDidLoad() {
        super.viewDidLoad()
        playerController = AVPlayerViewController()

        btnAddmore.imageView?.contentMode = .scaleAspectFit
        self.ImShSetLayout()
    }
    
    override func ImShSetLayout()
    {
        previewHandler.strComeFrom = "preview"
        previewHandler.images = UserSettings.shared.images
        self.collThumbnail.setUp(delegate: previewHandler, dataSource: previewHandler, cellNibWithReuseId: "MainCategoriesImageCell")
        
        if previewHandler.images.count > 0
        {
            var dict = [String:Any]()
            if previewHandler.images.count == 1
            {
                dict =  previewHandler.images[0]
                previewHandler.selectedItem = 0
                self.collThumbnail.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: false)
            }
            else
            {
                dict =  previewHandler.images[previewHandler.images.count - 1]
                previewHandler.selectedItem = previewHandler.images.count - 1
                self.collThumbnail.scrollToItem(at: IndexPath(item: previewHandler.images.count - 1, section: 0), at: .centeredHorizontally, animated: false)
            }
            
            self.collThumbnail.reloadData()

            if dict["videoname"] as? String != ""
            {
                self.isVideo = true
                let video_Url = CommonFunction.shared.GetVideoUrl(Filename: (dict["videoname"] as? String)!)
                self.setbackGroundImage(url: video_Url, selectImage: nil)
                
            }
            else
            {
                self.isVideo = false
                
                let image_Url = CommonFunction.shared.GetImagePath(Filename: (dict["imagename"] as? String)!)
                
//                let strBased64 = dict["image"] as! String
//                let data:Data = NSData(base64Encoded: strBased64, options: NSData.Base64DecodingOptions(rawValue: 0))! as Data

                self.setbackGroundImage(url: nil, selectImage: UIImage(contentsOfFile: image_Url))
            }
            

        }
        
        /// Handling actions
        previewHandler.didSelect = { (dict) in
            print(dict)
            self.player?.pause()
            self.player = nil
            self.playerController?.view.removeFromSuperview()
            
            if dict["videoname"] as? String != ""
            {
                self.isVideo = true
                let video_Url = CommonFunction.shared.GetVideoUrl(Filename: (dict["videoname"] as? String)!)
                self.setbackGroundImage(url: video_Url, selectImage: nil)
                
            }
            else
            {
                self.isVideo = false
                let image_Url = CommonFunction.shared.GetImagePath(Filename: (dict["imagename"] as? String)!)
                self.setbackGroundImage(url: nil, selectImage: UIImage(contentsOfFile: image_Url))
            }
            
//            if let videoUrl = dict["url"] as? URL
//            {
//                self.isVideo = true
//                self.setbackGroundImage(url: videoUrl, selectImage: nil)
//            }
//            else
//            {
//                self.isVideo = false
//
//                let strBased64 = dict["image"] as! String
//                let data:Data = NSData(base64Encoded: strBased64, options: NSData.Base64DecodingOptions(rawValue: 0))! as Data
//
//                self.setbackGroundImage(url: nil, selectImage: UIImage(data: data))
//            }

        }
        
        /// Handling delete
        previewHandler.deleteTapped = { (indexPath) in
//            self.deleteCartItem(at: indexPath)
        }

    }
    
    
    
    func setbackGroundImage(url:URL? , selectImage : UIImage?)  {
        
        if !isVideo
        {
            captureImageView.contentMode = UIView.ContentMode.scaleAspectFit
            captureImageView.image = selectImage
            captureImageView.isHidden = false
            previewView.isHidden = true
            self.player?.pause()
            self.player = nil
            playerController?.view.removeFromSuperview()

        }
        else
        {
            captureImageView.isHidden = true
            previewView.isHidden = false

            player = AVPlayer(url: url!)
            guard player != nil && playerController != nil else {
                return
            }
            playerController!.showsPlaybackControls = false
            
            playerController!.player = player!
//            self.addChild(playerController!)
            previewView.addSubview(playerController!.view)
            playerController!.view.frame = view.frame
            NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player!.currentItem)
            
            self.view.bringSubviewToFront(self.previewView)
            // Allow background audio to continue to play
            do {
                if #available(iOS 10.0, *) {
                    try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: .default, options: [])
                } else {
                }
            } catch let error as NSError {
                print(error)
            }
            
            do {
                try AVAudioSession.sharedInstance().setActive(true)
            } catch let error as NSError {
                print(error)
            }
            
            player?.play()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    
    @objc fileprivate func playerItemDidReachEnd(_ notification: Notification) {
        if self.player != nil {
            self.player!.seek(to: CMTime.zero)
            self.player!.play()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.player != nil {
            self.player!.pause()
            self.player = nil
        }
    }
    
    
    //MARK: Button methods
    
    @IBAction func btnAddmoreClick(_ sender: Any) {
        
        if previewHandler.images.count >= 5
        {
            AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "", aStrMessage: "Only 5 media files can be selected", aOKBtnTitle: "OK") { (index, title) in
            }
            
            return
        }
        
        self.navigationController?.popViewController(animated: false)

    }

    @IBAction func btnSubmitClick(_ sender: Any) {
        
        if strComefrom == "detail"
        {
            let controllers = self.navigationController?.viewControllers ?? []
            for controller in controllers
            {
                if controller is SERVICE_DETAIL
                {
                    let vc = controller as! SERVICE_DETAIL
                    vc.refreshCollection()
                    self.navigationController?.popToViewController(vc, animated: true)
                    break
                }
            }
        }
        else
        {
            let detail = SERVICE_DETAIL.create()
            self.navigationController?.pushViewController(detail, animated: false)
        }
    }
    
    @IBAction func btnCrossClick(_ sender: Any) {
        
        UserSettings.shared.images.removeAll()
        self.navigationController?.popViewController(animated: false)
    }

}

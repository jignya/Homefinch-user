//
//  MainCategoriesCollectionHandler.swift
//  HomeFinch-CustomerApp
//
//  Created by Jignya Panchal on 04/12/20.
//

import UIKit

class PreviewImagesCollectionHandler: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var images = [[String:Any]]()
    var didSelect: (([String:Any]) -> Void)? = nil
    var didSelectForImagePreview: ((IndexPath) -> Void)? = nil

    var deleteTapped: ((IndexPath) -> Void)? = nil
    
    //    var didSelect: ((IndexPath) -> Void)? = nil
    //    var favouriteTapped: ((CartItem , Int) -> Void)? = nil

    var strComeFrom : String = ""
    var selectedItem : Int!
    var isRemoveVisible : Bool = true


    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCategoriesImageCell", for: indexPath) as! MainCategoriesCell
        
        let dict = images[indexPath.row]
        
        cell.thumb.contentMode = .scaleAspectFill
        cell.imgPlay.isHidden = true
        
        if strComeFrom == "preview"
        {
            cell.btnRemove.isHidden = true
            cell.viewBg.cornerRadius = 4

            if selectedItem == indexPath.item
            {
                cell.viewBg.layer.borderWidth = 1
                cell.viewBg.layer.borderColor = UserSettings.shared.themeColor().cgColor
            }
            else
            {
                cell.viewBg.layer.borderWidth = 0
            }

            if dict["videoname"] as? String != ""
            {
                let video_Url = CommonFunction.shared.GetVideoUrl(Filename: (dict["videoname"] as? String)!)
                let data = CommonFunction.shared.getThumbnailImage(forUrl: video_Url)!.jpegData(compressionQuality: 0.5)
                cell.thumb.image = UIImage(data: data!)
                cell.imgPlay.isHidden = false
            }
            else
            {
                let image_Url = CommonFunction.shared.GetImagePath(Filename: (dict["imagename"] as? String)!)
                cell.thumb.image = UIImage(contentsOfFile: image_Url)

            }
        }
        else
        {
            cell.viewBg.cornerRadius = 15
            cell.btnRemove.isHidden = isRemoveVisible

            if let path =  dict["path"] as? String
            {
                if path.contains("jpg") || path.contains("png") || path.contains("svg")
                {
                    cell.imgPlay.isHidden = true
                    cell.thumb.setImage(url: path.getURL, placeholder: UIImage.image(type: .Placeholder_Gray))
                }
                else
                {
                    cell.thumb.image = UIImage.image(type: .Placeholder_Gray)
                    cell.imgPlay.isHidden = false

                    if let video_Url = path.getURL
                    {
                        self.getThumbnailImageFromVideoUrl(url: video_Url) { (thumbImage) in
                            cell.thumb.image = thumbImage
                        }
                    }
                }

            }

            else if dict["videoname"] as? String != ""
            {
                let video_Url = CommonFunction.shared.GetVideoUrl(Filename: (dict["videoname"] as? String)!)
                let data = CommonFunction.shared.getThumbnailImage(forUrl: video_Url)!.jpegData(compressionQuality: 0.5)
                cell.thumb.image = UIImage(data: data!)
                cell.imgPlay.isHidden = false
            }
            else
            {
                let image_Url = CommonFunction.shared.GetImagePath(Filename: (dict["imagename"] as? String)!)
                cell.thumb.image = UIImage(contentsOfFile: image_Url)

            }

        }
        
        
        
        cell.btnRemove.tag = indexPath.item
        cell.btnRemove.addTarget(self, action: #selector(RemoveBtnClick(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if strComeFrom == "preview"
        {
            didSelect?(images.at(index: indexPath.row))
            selectedItem = indexPath.row
            collectionView.reloadData()
        }
        else
        {
            selectedItem = indexPath.row
            didSelectForImagePreview?(indexPath)
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if strComeFrom == "detail"
        {
            let width = (collectionView.frame.width / 1.5) - 5
            return CGSize.init(width: width, height: collectionView.frame.size.height)
        }
        else if strComeFrom == "list"
        {
            return CGSize.init(width: 100, height: 100)
        }
        else if strComeFrom == "jobPreview"
        {
            return CGSize.init(width: 120, height: 120)
        }
        else //preview
        {
            return CGSize.init(width: 80, height: 80)
        }
        
    }
    
    @objc func RemoveBtnClick(_ Sender:UIButton)
    {
        let btn = Sender
        let indexpath = IndexPath(item: btn.tag, section: 0)
        self.deleteTapped?(indexpath)
    }
    
    func getThumbnailImageFromVideoUrl(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
        DispatchQueue.global().async { //1
            let asset = AVAsset(url: url) //2
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset) //3
            avAssetImageGenerator.appliesPreferredTrackTransform = true //4
            let thumnailTime = CMTimeMake(value: 2, timescale: 1) //5
            do {
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil) //6
                let thumbImage = UIImage(cgImage: cgThumbImage) //7
                DispatchQueue.main.async { //8
                    completion(thumbImage) //9
                }
            } catch {
                print(error.localizedDescription) //10
                DispatchQueue.main.async {
                    completion(nil) //11
                }
            }
        }
    }
    
    func createThumbnailOfVideoFromRemoteUrl(url: String) -> UIImage? {
        let asset = AVAsset(url: URL(string: url)!)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        //Can set this to improve performance if target size is known before hand
        //assetImgGenerate.maximumSize = CGSize(width,height)
        let time = CMTimeMakeWithSeconds(1.0, preferredTimescale: 600)
        do {
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: img)
            return thumbnail
        } catch {
          print(error.localizedDescription)
          return nil
        }
    }

}

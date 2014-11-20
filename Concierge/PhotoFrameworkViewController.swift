//
//  PhotoFrameworkViewController.swift
//  Concierge
//
//  Created by Vincent Lee on 11/18/14.
//  Copyright (c) 2014 VincentLee. All rights reserved.
//

import Photos

class PhotoFrameworkViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    var imageManager = PHCachingImageManager()
    var assetFetchResult: PHFetchResult!
    var flowLayout: UICollectionViewFlowLayout!
    var cellSize: CGSize!
    var imageDelegate: ImageDelegate?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.registerNib(UINib(nibName: knibNames.GalleryCell.rawValue, bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: kCellIdentifers.Gallery.rawValue)
        self.assetFetchResult = PHAsset.fetchAssetsWithOptions(nil)
        self.flowLayout = self.collectionView.collectionViewLayout as UICollectionViewFlowLayout
        self.cellSize = self.flowLayout.itemSize
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.assetFetchResult.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier(kCellIdentifers.Gallery.rawValue, forIndexPath: indexPath) as GalleryCollectionViewCell
        var asset = self.assetFetchResult[indexPath.row] as PHAsset
        self.imageManager.requestImageForAsset(asset, targetSize: self.cellSize, contentMode: PHImageContentMode.AspectFit, options: nil) { (image, infoDict) -> Void in
            cell.imageView.image = image
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let assetPicked = self.assetFetchResult[indexPath.row] as PHAsset
        self.imageManager.requestImageDataForAsset(assetPicked, options: nil) { (data, dataUTI, orientation, infoDict) -> Void in
            var selectedImage = UIImage(data: data)
            self.imageDelegate?.transferImage(selectedImage!)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}

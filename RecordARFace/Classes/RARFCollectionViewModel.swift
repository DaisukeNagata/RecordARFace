//
//  RARFCollectionViewModel.swift
//  RecordARFace
//
//  Created by 永田大祐 on 2019/01/03.
//  Copyright © 2019 永田大祐. All rights reserved.
//

import UIKit

public enum Images {
    case whiteImage,blackImage,blueImage,redImage
    var imageSet: String {
        switch self {
        case .whiteImage: return "whiteImage"
        case .blackImage: return "blackImage"
        case .blueImage: return "blueImage"
        case .redImage: return "redImage"
        }
    }
}

public  class RARFCollectionViewModel: NSObject {
    public let imagesRows: [Images] = [.whiteImage, .blackImage,.blueImage,.redImage]
}

// MARK: UICollectionViewDataSource
extension RARFCollectionViewModel: UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesRows.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! RARFCollectionCell
        cell.config(image: UIImage(named:imagesRows[indexPath.row].imageSet)!)
        return cell
    }
}

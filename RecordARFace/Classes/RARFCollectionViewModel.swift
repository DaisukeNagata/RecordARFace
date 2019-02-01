//
//  RARFCollectionViewModel.swift
//  RecordARFace
//
//  Created by 永田大祐 on 2019/01/03.
//  Copyright © 2019 永田大祐. All rights reserved.
//

import UIKit

enum Images {
    case whiteImage,blackImage,blueImage,redImage
    var imageSet: UIColor {
        switch self {
        case .whiteImage: return .white
        case .blackImage: return .black
        case .blueImage: return .blue
        case .redImage: return .red
        }
    }
}

class RARFCollectionViewModel: NSObject {
    let imagesRows: [Images] = [.whiteImage,.blackImage,.blueImage,.redImage]
}

// MARK: UICollectionViewDataSource
extension RARFCollectionViewModel: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesRows.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RARFCollectionCell", for: indexPath) as! RARFCollectionCell
        cell.config(color: imagesRows[indexPath.row].imageSet)
        return cell
    }
}

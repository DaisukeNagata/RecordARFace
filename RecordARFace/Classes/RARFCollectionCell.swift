//
//  RARFCollectionCell.swift
//  RecordARFace
//
//  Created by 永田大祐 on 2019/01/03.
//  Copyright © 2019 永田大祐. All rights reserved.
//

import UIKit
import SceneKit

public class RARFCollectionCell: UICollectionViewCell {

    @IBOutlet weak var collectionView: UIImageView!
    let identifier: UINib = UINib(nibName: "RARFCollectionCell", bundle: nil)
    func config(image: UIImage) { collectionView.image = image }
}

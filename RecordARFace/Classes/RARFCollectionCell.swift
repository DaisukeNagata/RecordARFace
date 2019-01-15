//
//  RARFCollectionCell.swift
//  RecordARFace
//
//  Created by 永田大祐 on 2019/01/03.
//  Copyright © 2019 永田大祐. All rights reserved.
//

import UIKit

final class RARFCollectionCell: UICollectionViewCell {

    let collectionView = UIImageView()
    let identifier: UINib = UINib(nibName: "RARFCollectionCell", bundle: nil)


    override init(frame: CGRect) {
        super.init(frame: frame)

        collectionView.frame.size = CGSize(width: UIScreen.main.bounds.width/2,
                                           height: UIScreen.main.bounds.height/2-UINavigationController.init().navigationBar.frame.height)
        self.addSubview(collectionView)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func config(color: UIColor) { collectionView.backgroundColor = color }
}

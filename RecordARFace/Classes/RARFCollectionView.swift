//
//  RARFCollectionView.swift
//  RecordARFace
//
//  Created by 永田大祐 on 2019/01/03.
//  Copyright © 2019 永田大祐. All rights reserved.
//

import UIKit

@available(iOS 11.0, *)
public class RARFCollectionView: UIView {

    let vm = RARFCollectionViewModel()
    open lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/2-5, height: UIScreen.main.bounds.height/2-UINavigationController.init().navigationBar.frame.height)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RARFCollectionCell().identifier, forCellWithReuseIdentifier: "CollectionCell")
        collectionView.register(RARFCollectionCell.self, forCellWithReuseIdentifier: "CollectionCell")
        collectionView.delegate = self
        collectionView.dataSource = vm
        return collectionView
    }()
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.addSubview(collectionView)
        addSubview(scrollView)
        return scrollView
    }()
    private lazy var aView: RARFView = {
        let aView = RARFView()
        return aView
    }()

    public init() {
        super.init(frame: .zero)

        self.frame = UIScreen.main.bounds
        collectionView.frame = self.bounds
        scrollView.frame = self.bounds
        aView.arscnView.frame = self.bounds
        aView.arscnView.isHidden = true

        addSubview(collectionView)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public func viewHidden() {

        aView.arscnView.isHidden = true
        collectionView.isHidden = false
    }
}

// MARK: UICollectionViewDelegate
@available(iOS 11.0, *)
extension RARFCollectionView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        collectionView.isHidden = true
        aView.arscnView.removeFromSuperview()
        aView = RARFView()
        aView.resetTracking(st: vm.imagesRows[indexPath.row].imageSet)
        addSubview(aView.arscnView)
    }
}

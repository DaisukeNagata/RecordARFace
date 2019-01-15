//
//  RARFCollectionView.swift
//  RecordARFace
//
//  Created by 永田大祐 on 2019/01/03.
//  Copyright © 2019 永田大祐. All rights reserved.
//

import UIKit

@available(iOS 11.0, *)
public final class RARFCollectionView: UIView {

    let vm = RARFCollectionViewModel()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/2,
                                 height: UIScreen.main.bounds.height/2-UINavigationController.init().navigationBar.frame.height)
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

    private var index = 0


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
        aView.arscnView.removeFromSuperview()
        collectionView.isHidden = false
    }

    public func viewEyesTracking() {
        collectionView.isHidden = true
        aView.arscnView.removeFromSuperview()
        aView = RARFView()
        addSubview(aView.arscnView)
        aView.eyeTracking(color: vm.imagesRows[index].imageSet)
    }
}

// MARK: UICollectionViewDelegate
@available(iOS 11.0, *)
extension RARFCollectionView: UICollectionViewDelegate {

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        collectionView.isHidden = true
        aView.arscnView.removeFromSuperview()
        aView = RARFView()
        aView.texturedFace(color: vm.imagesRows[indexPath.row].imageSet)
        index = indexPath.row
        addSubview(aView.arscnView)
    }
}

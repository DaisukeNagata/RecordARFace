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

    public let vm = RARFCollectionViewModel()
    open lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RARFCollectionCell().identifier, forCellWithReuseIdentifier: "CollectionCell")
        collectionView.delegate = self
        collectionView.dataSource = vm
        return collectionView
    }()
    public lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.addSubview(collectionView)
        addSubview(scrollView)
        return scrollView
    }()
    public lazy var aView: RARFView = {
        let aView = RARFView()
        return aView
    }()
    open var margin: CGFloat = UINavigationController.init().navigationBar.frame.height + UIApplication.shared.statusBarFrame.height

    public init() {
        super.init(frame: .zero)
        
        self.frame = UIScreen.main.bounds
        collectionView.frame = self.frame
        scrollView.frame = self.frame
        aView.arscnView.frame = self.frame
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: UICollectionViewDelegate
@available(iOS 11.0, *)
extension RARFCollectionView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        aView = RARFView()

        switch vm.imagesRows[indexPath.row] {
        case .whiteImage:
            aView.resetTracking(st: vm.imagesRows[indexPath.row].imageSet)
        case .blackImage:
            aView.resetTracking(st: vm.imagesRows[indexPath.row].imageSet)
        case .blueImage:
            aView.resetTracking(st: vm.imagesRows[indexPath.row].imageSet)
        case .redImage:
            aView.resetTracking(st: vm.imagesRows[indexPath.row].imageSet)
        }

        addSubview(aView.arscnView)
        addSubview(collectionView)
        collectionView.isHidden = true
    }
}

// MARK: UICollectionViewDelegateFlowLayout
@available(iOS 11.0, *)
extension RARFCollectionView: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2-5, height: collectionView.frame.height/2-UINavigationController.init().navigationBar.frame.height)
    }
}

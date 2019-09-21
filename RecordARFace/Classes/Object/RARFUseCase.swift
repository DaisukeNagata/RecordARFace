//
//  RARFUseCase.swift
//  RecordARFace
//
//  Created by 永田大祐 on 2019/05/12.
//

import UIKit
import WebKit
import ARKit

@available(iOS 11.0, *)

public class RARFUseCase: NSObject {

    lazy var aObject: RARFObject = {
        let aObject = RARFObject()
        return aObject
    }()
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/2-5,
                                 height: UIScreen.main.bounds.height/2-UINavigationController.init().navigationBar.frame.height)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RARFCollectionCell().identifier, forCellWithReuseIdentifier: "RARFCollectionCell")
        collectionView.register(RARFCollectionCell.self, forCellWithReuseIdentifier: "RARFCollectionCell")
        collectionView.frame = UIScreen.main.bounds
        return collectionView
    }()
    lazy var tView: RARFTView = {
        let tView = RARFTView()
        return tView
    }()
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = UIScreen.main.bounds
        scrollView.addSubview(collectionView)
        return scrollView
    }()
    var colorSet: UIColor?
    var alphaSet: CGFloat?

    public override init() {
        super.init()
    }

    public func collectionIsHeddenFalse() { collectionView.isHidden = false }

    public func collectionIsHeddenTrue() { collectionView.isHidden = true }

    public func aObjectTableFlgFalse() { aObject.tableFlgSetFalse() }

    public func aObjectTableFlgTrue() { aObject.tableFlgSetTrue() }

    public func contentOffSetY(y: CGFloat) { aObject.contentOffSetY = y}

    public func tableMerge() -> UITableView {  return aObject.tableView }

    public func tableScrollTrue(color: UIColor) {
        aObject.eyeTrackingScroll(color: color)
        tView.table.isHidden = true
        collectionView.isHidden = true
        aObject.arscnView.isHidden = false
    }

    public func webScrollTrue(color: UIColor) {
        aObject.eyeTrackingWebView(color: color)
        collectionView.isHidden = true
        aObject.arscnView.isHidden = false
    }

    public func onlyCalculator() {
        viewEyesTracking()
        eyeTrackStart(flg: false)
        aObject.arscnView.isHidden = false
    }

    public func onlyEyeData() {
        viewEyesTracking()
        eyeTrackStart(flg: true)
        aObject.arscnView.isHidden = false
    }

    public func viewHidden() {
        tView.table.frame.origin.y -= tView.frame.height
        collectionView.isHidden = false
        aObject.arscnView.isHidden = true
        aObject.tableView.isHidden = true
        aObject.numberKey?.isHidden = true
        aObject.luangageKey?.isHidden = true
        aObject.spellKey?.isHidden = true
    }

    public func viewEyesTracking() {
        collectionView.isHidden = true
        guard tView.table.frame.origin.y == 0 else {
            UIView.animate(withDuration: 0.5) { self.tView.table.frame.origin.y = 0 }
            return
        }
        UIView.animate(withDuration: 0.5) { self.tView.table.frame.origin.y -= self.tView.table.frame.height }
    }
    
    func eyeTrackStart(flg: Bool, color: UIColor? = .black) {
        tView.table.isHidden = true
        collectionView.isHidden = true
        aObject.arscnView.isHidden = false
        aObject.tableView.alpha = alphaSet ?? 0
        aObject.tableView.separatorStyle = .none
        aObject.eyeTracking(color: color, flg: flg)
    }

    deinit {
        aObject.timer?.invalidate()
    }
}

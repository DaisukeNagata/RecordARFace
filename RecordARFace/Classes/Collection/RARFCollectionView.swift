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

    lazy var aObject: RARFObject = {
        let aObject = RARFObject()
        return aObject
    }()

    let vm = RARFCollectionViewModel()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/2-5,
                                 height: UIScreen.main.bounds.height/2-UINavigationController.init().navigationBar.frame.height)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RARFCollectionCell().identifier, forCellWithReuseIdentifier: "RARFCollectionCell")
        collectionView.register(RARFCollectionCell.self, forCellWithReuseIdentifier: "RARFCollectionCell")
        collectionView.frame = self.bounds
        collectionView.delegate = self
        collectionView.dataSource = vm
        return collectionView
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = self.bounds
        scrollView.addSubview(collectionView)
        addSubview(scrollView)
        return scrollView
    }()

    private let ob = RARFTableData()

    private lazy var tView: RARFTView = {
        let tView = RARFTView()
        tView.table.dataSource = ob
        tView.table.delegate = self
        return tView
    }()

    private var index = 0
    private var alphaSet: CGFloat!


    public init(alphaSets: CGFloat) {
        super.init(frame: .zero)

        self.frame = UIScreen.main.bounds

        alphaSet = alphaSets
        aObject.arscnView.isHidden = true
    
        addSubview(tView.table)
        addSubview(collectionView)
        addSubview(aObject.arscnView)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public func tableScrollTrue(color: UIColor) {
        aObject.tableFlg = true
        aObject.eyeTrackingTableScroll(color: color)
        aObject.arscnView.isHidden = false
    }
    
    public func tableMerge() -> UITableView {
        return aObject.tableView
    }

    public func tableScrollFalse() {
        aObject.tableFlg = false
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
        if aObject.timer?.isValid == true {
            aObject.timer!.invalidate()
        }
        tView.table.frame.origin.y -= self.frame.height
        collectionView.isHidden = false
        aObject.arscnView.isHidden = true
    }

    public func viewEyesTracking() {
        collectionView.isHidden = true
        guard tView.table.frame.origin.y == 0 else {
            UIView.animate(withDuration: 0.5) {
                self.tView.table.frame.origin.y = 0
            }
            return
        }
        UIView.animate(withDuration: 0.5) {
            self.tView.table.frame.origin.y -= self.frame.height
        }
    }
    
    private func eyeTrackStart(flg: Bool) {
        if aObject.timer?.isValid == true {
            aObject.timer!.invalidate()
        }
        collectionView.isHidden = true
        aObject.tableView.alpha = alphaSet
        aObject.tableView.separatorStyle = .none
        aObject.eyeTracking(color: vm.imagesRows[index].imageSet, flg: flg)
    }
}

// MARK: UICollectionViewDelegate
@available(iOS 11.0, *)
extension RARFCollectionView: UICollectionViewDelegate {

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        collectionView.isHidden = true
        aObject.texturedFace(color: vm.imagesRows[indexPath.row].imageSet)
        index = indexPath.row
        aObject.arscnView.isHidden = false
        aObject.tableView.isHidden = true
    }
}

// TODO MARK: UITableViewDelegate
extension RARFCollectionView: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.row == KeyboardCount.number.rawValue {
            eyeTrackStart(flg: false)
            aObject.arscnView.isHidden = false
        } else if indexPath.row == KeyboardCount.luangage.rawValue {
            eyeTrackStart(flg: true)
            aObject.arscnView.isHidden = false
        }
    }
}

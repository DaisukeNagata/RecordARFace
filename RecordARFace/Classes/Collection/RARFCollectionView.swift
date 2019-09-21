//
//  RARFCollectionView.swift
//  RecordARFace
//
//  Created by 永田大祐 on 2019/01/03.
//  Copyright © 2019 永田大祐. All rights reserved.
//

import UIKit
import ARKit

@available(iOS 11.0, *)
public final class RARFCollectionView: UIView {

    public lazy var rUseCase: RARFUseCase = {
        let rUseCase = RARFUseCase()
        return rUseCase
    }()
    private var index = 0
    private let ob = RARFTableData()
    private let vm = RARFCollectionViewModel()


    public init(alphaSets: CGFloat) {
        super.init(frame: .zero)

        self.frame = UIScreen.main.bounds

        rUseCase.alphaSet = alphaSets
        rUseCase.aObject.arscnView.isHidden = true

        rUseCase.collectionView.delegate = self
        rUseCase.collectionView.dataSource = vm

        rUseCase.tView.table.delegate = self
        rUseCase.tView.table.dataSource = ob

        addSubview(rUseCase.scrollView)
        addSubview(rUseCase.tView.table)
        addSubview(rUseCase.collectionView)
        addSubview(rUseCase.aObject.arscnView)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: UICollectionViewDelegate
@available(iOS 11.0, *)
extension RARFCollectionView: UICollectionViewDelegate {

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.isHidden = true

        if rUseCase.aObject.arscnView.frame.width == 0.1 {
            rUseCase.aObject.arscnView.frame.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }
        rUseCase.aObject.texturedFace(color: vm.imagesRows[indexPath.row].imageSet)
        index = indexPath.row
        rUseCase.aObject.arscnView.isHidden = false
        rUseCase.aObject.tableView.isHidden = true
    }
}

// TODO MARK: UITableViewDelegate
extension RARFCollectionView: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch KeyboardCount(rawValue: indexPath.row) {
        case .number?:
           rUseCase.eyeTrackStart(flg: false, color: rUseCase.colorSet)
        case .luangage?:
            rUseCase.eyeTrackStart(flg: true, color: rUseCase.colorSet)
        default: break
        }
    }
}

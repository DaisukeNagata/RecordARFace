//
//  RARFStatusBarUI.swift
//  RecordARFace
//
//  Created by 永田大祐 on 2019/01/06.
//  Copyright © 2019 永田大祐. All rights reserved.
//

import UIKit

public final class RARFStatusBarUI: UIView {

    public var statusBar: UIView = {
        var statusBarHeight: CGFloat  = 0
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        let statusBar = UIView(frame:CGRect(x: 0.0, y: -statusBarHeight, width: UIScreen.main.bounds.width, height: statusBarHeight))
        statusBar.backgroundColor = .clear
        return statusBar
    }()
}

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
        let statusBar = UIView(frame:CGRect(x: 0.0, y: -UIApplication.shared.statusBarFrame.height, width: UIScreen.main.bounds.width, height: UIApplication.shared.statusBarFrame.height))
        statusBar.backgroundColor = .clear
        return statusBar
    }()
}

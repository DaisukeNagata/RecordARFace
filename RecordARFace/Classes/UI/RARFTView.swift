//
//  RARFTView.swift
//  RecordARFace
//
//  Created by 永田大祐 on 2019/01/25.
//  Copyright © 2019 永田大祐. All rights reserved.
//

import UIKit

final class RARFTView: UIView {

    lazy var table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "RARFCell")
        table.rowHeight = 80
        return table
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.frame = UIScreen.main.bounds
        table.frame = self.frame
        table.frame.origin.y = -self.frame.height
        self.addSubview(table)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

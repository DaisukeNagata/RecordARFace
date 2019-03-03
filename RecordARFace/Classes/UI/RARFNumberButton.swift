//
//  RARFNumberButton.swift
//  RecordARFace
//
//  Created by 永田大祐 on 2019/02/03.
//  Copyright © 2019 永田大祐. All rights reserved.
//

import UIKit

@IBDesignable class RARFNumberButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0.0
    @IBInspectable var borderColor: UIColor = UIColor.clear
    @IBInspectable var borderWidth: CGFloat = 0.0


    override func draw(_ rect: CGRect) {

        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = (cornerRadius > 0)

        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth

        super.draw(rect)
    }
}

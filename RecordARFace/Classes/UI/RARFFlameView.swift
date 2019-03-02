//
//  RARFFlameView.swift
//  Pods-RecordARFace_Example
//
//  Created by 永田大祐 on 2019/01/14.
//

import UIKit
final class RARFFlameView {

    var eViews: UIView
    private let rootLayer = CALayer()
    private let flameEmitterLayer = CAEmitterLayer()
    private let flameEmitterCell = CAEmitterCell()
    private var color = UIColor()


    init(eView: UIView,color: UIColor) {
        self.eViews = eView
        self.color = color
        commonInit()
    }

    // TODO: Expansion of design
    private func commonInit() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = eViews.bounds
        eViews.layer.addSublayer(gradientLayer)
        gradientLayer.colors = [color.cgColor, color.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.cornerRadius = eViews.frame.height/2
    }
}

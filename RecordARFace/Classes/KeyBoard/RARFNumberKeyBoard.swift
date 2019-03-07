//
//  RARFNumberKeyBoard.swift
//  RecordARFace
//
//  Created by 永田大祐 on 2019/02/11.
//  Copyright © 2019 永田大祐. All rights reserved.
//

import UIKit

final class RARFNumberKeyboard: UIView {

    @IBOutlet weak var centerKey: RARFNumberButton!
    @IBOutlet weak var leftKey: RARFNumberButton!
    @IBOutlet weak var rightKey: RARFNumberButton!
    @IBOutlet weak var upKey: RARFNumberButton!
    @IBOutlet weak var underKey: RARFNumberButton!

    private var keyValueObservations = [NSKeyValueObservation]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = UIScreen.main.bounds
        loadNib()
        removeKVO()
        self.alpha = 0
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func loadNib() {
        let view = Bundle.main.loadNibNamed("NumberKeyboard", owner: self, options: nil)?.first as! UIView
        view.frame.origin.y = UIApplication.shared.statusBarFrame.height
        view.frame.size.width = self.frame.width
        view.frame.size.height = self.frame.width
        self.addSubview(view)
    }

    func oneColumn() {
        centerKey.setTitle("1", for: .normal)
        leftKey.setTitle("☆", for: .normal)
        rightKey.setTitle("➡︎", for: .normal)
        upKey.setTitle("♪", for: .normal)
        
        underKey.alpha = 0

        UIView.animate(withDuration: 0.4) { self.alpha = 1.0 }
    }

    func twoColumn() {
        centerKey.setTitle("2", for: .normal)
        leftKey.setTitle("¥", for: .normal)
        rightKey.setTitle("€", for: .normal)
        upKey.setTitle("$", for: .normal)

        underKey.alpha = 0

        UIView.animate(withDuration: 0.4) { self.alpha = 1.0 }
    }

    func threeColumn() {
        centerKey.setTitle("3", for: .normal)
        leftKey.setTitle("%", for: .normal)
        rightKey.setTitle("#", for: .normal)
        upKey.setTitle("。", for: .normal)

        underKey.alpha = 0

        UIView.animate(withDuration: 0.4) { self.alpha = 1.0 }
    }

    func fourColumn() {
        centerKey.setTitle("4", for: .normal)
        leftKey.setTitle("<", for: .normal)
        rightKey.setTitle(">", for: .normal)
        upKey.setTitle("=", for: .normal)

        underKey.alpha = 0

        UIView.animate(withDuration: 0.4) { self.alpha = 1.0 }
    }

    func fiveColumn() {
        centerKey.setTitle("5", for: .normal)
        leftKey.setTitle("+", for: .normal)
        rightKey.setTitle("÷", for: .normal)
        upKey.setTitle("×", for: .normal)

        underKey.alpha = 0

        UIView.animate(withDuration: 0.4) { self.alpha = 1.0 }
    }

    func sixColumn() {
        centerKey.setTitle("6", for: .normal)
        leftKey.setTitle("+", for: .normal)
        rightKey.setTitle("÷", for: .normal)
        upKey.setTitle("×", for: .normal)

        underKey.alpha = 0

        UIView.animate(withDuration: 0.4) { self.alpha = 1.0 }
    }

    func sevenColumn() {
        centerKey.setTitle("7", for: .normal)
        leftKey.setTitle("「", for: .normal)
        rightKey.setTitle(":", for: .normal)
        upKey.setTitle("」", for: .normal)

        underKey.alpha = 0
    
        UIView.animate(withDuration: 0.4) { self.alpha = 1.0 }
    }

    func eightColumn() {
        centerKey.setTitle("8", for: .normal)
        leftKey.setTitle("〒", for: .normal)
        rightKey.setTitle("々", for: .normal)
        upKey.setTitle("〆", for: .normal)

        underKey.alpha = 0

        UIView.animate(withDuration: 0.4) { self.alpha = 1.0 }
    }

    func nineColumn() {
        centerKey.setTitle("9", for: .normal)
        leftKey.setTitle("^", for: .normal)
        rightKey.setTitle("\\", for: .normal)
        upKey.setTitle("|", for: .normal)

        underKey.alpha = 0

        UIView.animate(withDuration: 0.4) { self.alpha = 1.0 }
    }

    func darkColumn() {
        centerKey.setTitle("(", for: .normal)
        leftKey.setTitle(")", for: .normal)
        rightKey.setTitle("]", for: .normal)
        upKey.setTitle("[", for: .normal)

        underKey.alpha = 0

        UIView.animate(withDuration: 0.4) { self.alpha = 1.0 }
    }

    func zeroColumn() {
        centerKey.setTitle("0", for: .normal)
        leftKey.setTitle("〜", for: .normal)
        upKey.setTitle("…", for: .normal)
        
        rightKey.alpha = 0
        underKey.alpha = 0

        UIView.animate(withDuration: 0.4) { self.alpha = 1.0 }
    }

    func pointeeColumn() {
        centerKey.setTitle("・", for: .normal)
        leftKey.setTitle(",", for: .normal)
        rightKey.setTitle("!", for: .normal)
        upKey.setTitle("?", for: .normal)

        underKey.alpha = 0

        UIView.animate(withDuration: 0.4) { self.alpha = 1.0 }
    }

    func addKVO(view: RARFSpellAndKeyBoard, _ closure: @escaping ()->Void)  {
        let keyValueObservation = self.observe(\.alpha, options: [.new, .old])
        { _, change in
            if change.newValue == nil  { return }
            closure()
        }
        keyValueObservations.append(keyValueObservation)
    }

    private func removeKVO() {
        for keyValueObservation in keyValueObservations { keyValueObservation.invalidate() }
        keyValueObservations.removeAll()
    }
}

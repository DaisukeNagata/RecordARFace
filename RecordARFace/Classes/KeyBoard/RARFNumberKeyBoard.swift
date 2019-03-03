//
//  RARFNumberKeyBoard.swift
//  RecordARFace
//
//  Created by 永田大祐 on 2019/02/11.
//  Copyright © 2019 永田大祐. All rights reserved.
//

import UIKit

final class RARFNumberKeyboard: UIView {

    var timer: Timer?

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

        centerKey.addTarget(self, action: #selector(one), for: .touchUpInside)
        leftKey.addTarget(self, action: #selector(oneLeft), for: .touchUpInside)
        rightKey.addTarget(self, action: #selector(oneRight), for: .touchUpInside)
        upKey.addTarget(self, action: #selector(oneUp), for: .touchUpInside)
        
        underKey.alpha = 0

        UIView.animate(withDuration: 0.4) { self.alpha = 1.0 }
    }

    func twoColumn() {
        centerKey.setTitle("2", for: .normal)
        leftKey.setTitle("¥", for: .normal)
        rightKey.setTitle("€", for: .normal)
        upKey.setTitle("$", for: .normal)

        centerKey.addTarget(self, action: #selector(two), for: .touchUpInside)
        leftKey.addTarget(self, action: #selector(twoleft), for: .touchUpInside)
        rightKey.addTarget(self, action: #selector(twoRight), for: .touchUpInside)
        upKey.addTarget(self, action: #selector(twoUp), for: .touchUpInside)

        underKey.alpha = 0

        UIView.animate(withDuration: 0.4) { self.alpha = 1.0 }
    }

    func threeColumn() {
        centerKey.setTitle("3", for: .normal)
        leftKey.setTitle("%", for: .normal)
        rightKey.setTitle("#", for: .normal)
        upKey.setTitle("。", for: .normal)

        centerKey.addTarget(self, action: #selector(three), for: .touchUpInside)
        leftKey.addTarget(self, action: #selector(threeLeft), for: .touchUpInside)
        rightKey.addTarget(self, action: #selector(threeRight), for: .touchUpInside)
        upKey.addTarget(self, action: #selector(threeUp), for: .touchUpInside)

        underKey.alpha = 0

        UIView.animate(withDuration: 0.4) { self.alpha = 1.0 }
    }

    func fourColumn() {
        centerKey.setTitle("4", for: .normal)
        leftKey.setTitle("<", for: .normal)
        rightKey.setTitle(">", for: .normal)
        upKey.setTitle("=", for: .normal)

        centerKey.addTarget(self, action: #selector(five), for: .touchUpInside)
        leftKey.addTarget(self, action: #selector(fourLeft), for: .touchUpInside)
        rightKey.addTarget(self, action: #selector(fourRight), for: .touchUpInside)
        upKey.addTarget(self, action: #selector(fourUp), for: .touchUpInside)

        underKey.alpha = 0

        UIView.animate(withDuration: 0.4) { self.alpha = 1.0 }
    }

    func fiveColumn() {
        centerKey.setTitle("5", for: .normal)
        leftKey.setTitle("+", for: .normal)
        rightKey.setTitle("÷", for: .normal)
        upKey.setTitle("×", for: .normal)

        centerKey.addTarget(self, action: #selector(five), for: .touchUpInside)
        leftKey.addTarget(self, action: #selector(fiveLeft), for: .touchUpInside)
        rightKey.addTarget(self, action: #selector(fiveRight), for: .touchUpInside)
        upKey.addTarget(self, action: #selector(fiveUp), for: .touchUpInside)

        underKey.alpha = 0

        UIView.animate(withDuration: 0.4) { self.alpha = 1.0 }
    }

    func sixColumn() {
        centerKey.setTitle("6", for: .normal)
        leftKey.setTitle("+", for: .normal)
        rightKey.setTitle("÷", for: .normal)
        upKey.setTitle("×", for: .normal)

        centerKey.addTarget(self, action: #selector(six), for: .touchUpInside)
        leftKey.addTarget(self, action: #selector(sixLeft), for: .touchUpInside)
        rightKey.addTarget(self, action: #selector(sixRight), for: .touchUpInside)
        upKey.addTarget(self, action: #selector(sixUp), for: .touchUpInside)

        underKey.alpha = 0

        UIView.animate(withDuration: 0.4) { self.alpha = 1.0 }
    }

    func sevenColumn() {
        centerKey.setTitle("7", for: .normal)
        leftKey.setTitle("「", for: .normal)
        rightKey.setTitle(":", for: .normal)
        upKey.setTitle("」", for: .normal)

        centerKey.addTarget(self, action: #selector(seven), for: .touchUpInside)
        leftKey.addTarget(self, action: #selector(sevenLeft), for: .touchUpInside)
        rightKey.addTarget(self, action: #selector(sevenRight), for: .touchUpInside)
        upKey.addTarget(self, action: #selector(sevenUp), for: .touchUpInside)

        underKey.alpha = 0
    
        UIView.animate(withDuration: 0.4) { self.alpha = 1.0 }
    }

    func eightColumn() {
        centerKey.setTitle("8", for: .normal)
        leftKey.setTitle("〒", for: .normal)
        rightKey.setTitle("々", for: .normal)
        upKey.setTitle("〆", for: .normal)

        centerKey.addTarget(self, action: #selector(eight), for: .touchUpInside)
        leftKey.addTarget(self, action: #selector(eightLeft), for: .touchUpInside)
        rightKey.addTarget(self, action: #selector(eightRight), for: .touchUpInside)
        upKey.addTarget(self, action: #selector(eightUp), for: .touchUpInside)

        underKey.alpha = 0

        UIView.animate(withDuration: 0.4) { self.alpha = 1.0 }
    }

    func nineColumn() {
        centerKey.setTitle("9", for: .normal)
        leftKey.setTitle("^", for: .normal)
        rightKey.setTitle("\\", for: .normal)
        upKey.setTitle("|", for: .normal)

        centerKey.addTarget(self, action: #selector(nine), for: .touchUpInside)
        leftKey.addTarget(self, action: #selector(nineLeft), for: .touchUpInside)
        rightKey.addTarget(self, action: #selector(nineRight), for: .touchUpInside)
        upKey.addTarget(self, action: #selector(nineUp), for: .touchUpInside)

        underKey.alpha = 0

        UIView.animate(withDuration: 0.4) { self.alpha = 1.0 }
    }

    func darkColumn() {
        centerKey.setTitle("(", for: .normal)
        leftKey.setTitle(")", for: .normal)
        rightKey.setTitle("]", for: .normal)
        upKey.setTitle("[", for: .normal)

        centerKey.addTarget(self, action: #selector(dark), for: .touchUpInside)
        leftKey.addTarget(self, action: #selector(darkLeft), for: .touchUpInside)
        rightKey.addTarget(self, action: #selector(darkRight), for: .touchUpInside)
        upKey.addTarget(self, action: #selector(darkUp), for: .touchUpInside)

        underKey.alpha = 0

        UIView.animate(withDuration: 0.4) { self.alpha = 1.0 }
    }

    func zeroColumn() {
        centerKey.setTitle("0", for: .normal)
        leftKey.setTitle("〜", for: .normal)
        upKey.setTitle("…", for: .normal)
        
        centerKey.addTarget(self, action: #selector(zero), for: .touchUpInside)
        leftKey.addTarget(self, action: #selector(zeroLeft), for: .touchUpInside)
        upKey.addTarget(self, action: #selector(zeroUp), for: .touchUpInside)

        rightKey.alpha = 0
        underKey.alpha = 0

        UIView.animate(withDuration: 0.4) { self.alpha = 1.0 }
    }

    func pointeeColumn() {
        centerKey.setTitle("・", for: .normal)
        leftKey.setTitle(",", for: .normal)
        rightKey.setTitle("!", for: .normal)
        upKey.setTitle("?", for: .normal)

        centerKey.addTarget(self, action: #selector(pointee), for: .touchUpInside)
        leftKey.addTarget(self, action: #selector(pointeeLeft), for: .touchUpInside)
        rightKey.addTarget(self, action: #selector(pointeeRight
            ), for: .touchUpInside)
        upKey.addTarget(self, action: #selector(pointeeUp), for: .touchUpInside)

        underKey.alpha = 0

        UIView.animate(withDuration: 0.4) { self.alpha = 1.0 }
    }


    func texConversion() {
        if Global.texFlg == false {
            Global.texFlg = true
        } else {
            Global.texFlg = false
        }
    }

    @objc func one() {self.alpha = 0; print("1"); }
    @objc func oneLeft() {self.alpha = 0; print("☆") }
    @objc func oneRight() {self.alpha = 0; print("➡︎")}
    @objc func oneUp() {self.alpha = 0 ; print("♪")}

    @objc func two() { self.alpha = 0; print("2") }
    @objc func twoleft() { self.alpha = 0; print("¥") }
    @objc func twoRight() { self.alpha = 0; print("€") }
    @objc func twoUp() { self.alpha = 0; print("$") }

    @objc func three() { self.alpha = 0; print("3") }
    @objc func threeLeft() { self.alpha = 0; print("%") }
    @objc func threeRight() { self.alpha = 0; print("#") }
    @objc func threeUp() { self.alpha = 0; print("。") }

    @objc func four() { self.alpha = 0; print("4") }
    @objc func fourLeft() { self.alpha = 0; print("○") }
    @objc func fourRight() { self.alpha = 0; print("・") }
    @objc func fourUp() { self.alpha = 0; print("*") }

    @objc func five() { self.alpha = 0; print("5") }
    @objc func fiveLeft() { self.alpha = 0; print("+") }
    @objc func fiveRight() { self.alpha = 0; print("÷") }
    @objc func fiveUp() { self.alpha = 0; print("×") }

    @objc func six() { self.alpha = 0; print("6") }
    @objc func sixLeft() { self.alpha = 0; print("<") }
    @objc func sixRight() { self.alpha = 0; print(">") }
    @objc func sixUp() { self.alpha = 0; print("=") }

    @objc func seven() { self.alpha = 0; print("7") }
    @objc func sevenLeft() { self.alpha = 0; print("「") }
    @objc func sevenRight() { self.alpha = 0; print(":") }
    @objc func sevenUp() { self.alpha = 0; print("」") }

    @objc func eight() { self.alpha = 0; print("8") }
    @objc func eightLeft() { self.alpha = 0; print("〒") }
    @objc func eightRight() { self.alpha = 0; print("々") }
    @objc func eightUp() { self.alpha = 0; print("〆") }

    @objc func nine() { self.alpha = 0; print("9") }
    @objc func nineLeft() { self.alpha = 0; print("^") }
    @objc func nineRight() { self.alpha = 0; print("\\") }
    @objc func nineUp() { self.alpha = 0; print("|") }
    
    @objc func dark() { self.alpha = 0; print("(") }
    @objc func darkLeft() { self.alpha = 0; print(")") }
    @objc func darkRight() { self.alpha = 0; print("]") }
    @objc func darkUp() { self.alpha = 0; print("[") }

    @objc func zero() { self.alpha = 0; print("0") }
    @objc func zeroLeft() { self.alpha = 0; print("〜") }
    @objc func zeroUp() { self.alpha = 0; print("…") }

    @objc func pointee() { self.alpha = 0; print("・") }
    @objc func pointeeLeft() { self.alpha = 0; print(",") }
    @objc func pointeeRight() { self.alpha = 0; print("!") }
    @objc func pointeeUp() { self.alpha = 0; print("?") }

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

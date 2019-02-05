//
//  RARFNumberKeyboardView.swift
//  SamapleKeyBoard
//
//  Created by 永田大祐 on 2019/02/03.
//  Copyright © 2019 永田大祐. All rights reserved.
//

import UIKit

enum Calculator: Int { case plus, minus, division, multiplication }

public class RARFNumberKeyboardView: UIView {

    @IBOutlet weak var one: RARFNumberButton!
    @IBOutlet weak var two: RARFNumberButton!
    @IBOutlet weak var three: RARFNumberButton!
    @IBOutlet weak var four: RARFNumberButton!
    @IBOutlet weak var five: RARFNumberButton!
    @IBOutlet weak var six: RARFNumberButton!
    @IBOutlet weak var seven: RARFNumberButton!
    @IBOutlet weak var eight: RARFNumberButton!
    @IBOutlet weak var nine: RARFNumberButton!
    @IBOutlet weak var zero: RARFNumberButton!
    @IBOutlet weak var minus: RARFNumberButton!
    @IBOutlet weak var plus: RARFNumberButton!
    @IBOutlet weak var multiplication: RARFNumberButton!
    @IBOutlet weak var divite: RARFNumberButton!
    @IBOutlet weak var enter: RARFNumberButton!
    @IBOutlet weak var claer: RARFNumberButton!
    @IBOutlet weak var allClaer: RARFNumberButton!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var views: UIView!
    private var timerFlg = false
    private var plusNumber = ""
    private var total: String?
    private var calculatorNum: Int?


    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = UIScreen.main.bounds
        loadNib()
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }

    public func loadNib() {
        let bundle = Bundle(for: RARFNumberKeyboardView.self)
        let view = bundle.loadNibNamed("RARFNumberKeyboardView", owner: self, options: nil)?.first as! UIView
        view.frame = UIScreen.main.bounds
        view.frame.origin.y = one.frame.height
        self.addSubview(view)
    }

    func originTextField(rect: CGRect) {
        if timerFlg == false {

            var rectFrame = rect
            rectFrame.origin.y -= one.frame.height

            if one.frame.contains(rectFrame) {
                plusNumber += 1.description
                textLabel.text = plusNumber
            }
            if two.frame.contains(rectFrame) {
                plusNumber += 2.description
                textLabel.text = plusNumber
            }
            if three.frame.contains(rectFrame) {
                plusNumber += 3.description
                textLabel.text = plusNumber
            }
            if four.frame.contains(rectFrame) {
                plusNumber += 4.description
                textLabel.text = plusNumber
            }
            if five.frame.contains(rectFrame) {
                plusNumber += 5.description
                textLabel.text = plusNumber
            }
            if six.frame.contains(rectFrame) {
                plusNumber += 6.description
                textLabel.text = plusNumber
            }
            if seven.frame.contains(rectFrame) {
                plusNumber += 7.description
                textLabel.text = plusNumber
            }
            if eight.frame.contains(rectFrame) {
                plusNumber += 8.description
                textLabel.text = plusNumber
            }
            if nine.frame.contains(rectFrame) {
                plusNumber += 9.description
                textLabel.text = plusNumber
            }
            if zero.frame.contains(rectFrame) {
                plusNumber += 0.description
                textLabel.text = plusNumber
            }
            if minus.frame.contains(rectFrame) {
                plusNumber = ""
                total = textLabel.text!
                calculatorNum = Calculator.minus.rawValue
            }
            if plus.frame.contains(rectFrame) {
                plusNumber = ""
                total = textLabel.text!
                calculatorNum = Calculator.plus.rawValue
            }
            if multiplication.frame.contains(rectFrame) {
                plusNumber = ""
                total = textLabel.text!
                calculatorNum = Calculator.multiplication.rawValue
            }
            if divite.frame.contains(rectFrame) {
                plusNumber = ""
                total = textLabel.text!
                calculatorNum = Calculator.division.rawValue
            }
            if claer.frame.contains(rectFrame) {
                plusNumber = String(textLabel.text!.dropLast(1))
                textLabel.text = String(textLabel.text!.dropLast(1))
            }
            if allClaer.frame.contains(rectFrame) {
                plusNumber = ""
                textLabel.text! = ""
                total = ""
            }
            if enter.frame.contains(rectFrame) {
                if total != nil {
                    let indexNumber = calculator(index: calculatorNum!, txtNumber:  Float(total!)!, txtNumber2: Float(textLabel.text!)!)
                    textLabel.text! = indexNumber.description
                    plusNumber = ""
                    total = nil
                }
            }
            timerFlg = true
        }
    }

    func calculator(index: Int, txtNumber: Float, txtNumber2: Float) -> Float {
        switch index {
        case Calculator.plus.rawValue:
            return txtNumber + txtNumber2
        case Calculator.minus.rawValue:
            return txtNumber - txtNumber2
        case Calculator.multiplication.rawValue:
            return txtNumber * txtNumber2
        case Calculator.division.rawValue:
            return txtNumber / txtNumber2
        default:
            return Float()
        }
    }

    @objc func timerUpdate() { timerFlg = false }
}

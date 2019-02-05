//
//  RARFNumberKeyboard.swift
//  SamapleKeyBoard
//
//  Created by 永田大祐 on 2019/02/03.
//  Copyright © 2019 永田大祐. All rights reserved.
//

import UIKit

enum Calculator: Int { case plus, minus, division, multiplication }

public class RARFNumberKeyboard: UIView {

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
    @IBOutlet weak var textView: UILabel!
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
        let bundle = Bundle(for: RARFNumberKeyboard.self)
        let view = bundle.loadNibNamed("RARFNumberKeyboard", owner: self, options: nil)?.first as! UIView
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
                textView.text = plusNumber }
            if two.frame.contains(rectFrame) {
                plusNumber += 2.description
                textView.text = plusNumber }
            if three.frame.contains(rectFrame) {
                plusNumber += 3.description
                textView.text = plusNumber }
            if four.frame.contains(rectFrame) {
                plusNumber += 4.description
                textView.text = plusNumber }
            if five.frame.contains(rectFrame) {
                plusNumber += 5.description
                textView.text = plusNumber }
            if six.frame.contains(rectFrame) {
                plusNumber += 6.description
                textView.text = plusNumber }
            if seven.frame.contains(rectFrame) {
                plusNumber += 7.description
                textView.text = plusNumber }
            if eight.frame.contains(rectFrame) {
                plusNumber += 8.description
                textView.text = plusNumber }
            if nine.frame.contains(rectFrame) {
                plusNumber += 9.description
                textView.text = plusNumber }
            if zero.frame.contains(rectFrame) {
                plusNumber += 0.description
                textView.text = plusNumber }
            if minus.frame.contains(rectFrame) {
                plusNumber = String(textView.text!.dropLast(1))
                textView.text = String(textView.text!.dropLast(1)) }
            
            if plus.frame.contains(rectFrame) {
                plusNumber = ""
                total = textView.text!
                calculatorNum = Calculator.plus.rawValue
            }
            if multiplication.frame.contains(rectFrame) {
                plusNumber = ""
                total = textView.text!
                calculatorNum = Calculator.multiplication.rawValue
            }
            if divite.frame.contains(rectFrame) {
                plusNumber = ""
                total = textView.text!
                calculatorNum = Calculator.division.rawValue
            }
           
            if enter.frame.contains(rectFrame) {
                if total != nil {
                    let indexNumber = calculator(index: calculatorNum!, txtNumber: Int(textView.text!)!, txtNumber2: Int(total!)!)
                    textView.text! = indexNumber.description
                    
                    plusNumber = ""
                    total = nil
                }
            }
            
            timerFlg = true
        }
    }

    func calculator(index: Int, txtNumber: Int, txtNumber2: Int) -> Int {
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
            return Int()
        }
    }

    @objc func timerUpdate() { timerFlg = false }
}

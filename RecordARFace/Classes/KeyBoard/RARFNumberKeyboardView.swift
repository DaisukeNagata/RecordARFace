//
//  RARFNumberKeyboardView.swift
//  RecordARFace
//
//  Created by 永田大祐 on 2019/02/03.
//  Copyright © 2019 永田大祐. All rights reserved.
//

import UIKit

enum Calculator: Int { case plus, minus, division, multiplication }

class RARFNumberKeyboardView: UIView {

    @IBOutlet weak var one: RARFNumberButton?
    @IBOutlet weak var two: RARFNumberButton?
    @IBOutlet weak var three: RARFNumberButton?
    @IBOutlet weak var four: RARFNumberButton?
    @IBOutlet weak var five: RARFNumberButton?
    @IBOutlet weak var six: RARFNumberButton?
    @IBOutlet weak var seven: RARFNumberButton?
    @IBOutlet weak var eight: RARFNumberButton?
    @IBOutlet weak var nine: RARFNumberButton?
    @IBOutlet weak var zero: RARFNumberButton?
    @IBOutlet weak var minus: RARFNumberButton?
    @IBOutlet weak var plus: RARFNumberButton?
    @IBOutlet weak var multiplication: RARFNumberButton?
    @IBOutlet weak var divite: RARFNumberButton?
    @IBOutlet weak var enter: RARFNumberButton?
    @IBOutlet weak var claer: RARFNumberButton?
    @IBOutlet weak var allClaer: RARFNumberButton?
    @IBOutlet weak var textLabel: UILabel?

    private var plusNumber = ""
    private var total: String?
    private var calculatorNum: Int?
    private var totalNumber: Float?


    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }

    func loadNib() {
        let bundle = Bundle(for: RARFNumberKeyboardView.self)
        let view = bundle.loadNibNamed("RARFNumberKeyboardView", owner: self, options: nil)?.first as! UIView
        view.frame = UIScreen.main.bounds
        self.addSubview(view)
    }

    func originTextField(rect: CGRect) {

        if one?.frame.contains(rect) ?? false { number(index: 1) }
        if two?.frame.contains(rect) ?? false { number(index: 2) }
        if three?.frame.contains(rect) ?? false { number(index: 3) }
        if four?.frame.contains(rect) ?? false { number(index: 4) }
        if five?.frame.contains(rect) ?? false { number(index: 5) }
        if six?.frame.contains(rect) ?? false { number(index: 6) }
        if seven?.frame.contains(rect) ?? false { number(index: 7) }
        if eight?.frame.contains(rect) ?? false { number(index: 8) }
        if nine?.frame.contains(rect) ?? false { number(index: 9) }
        if zero?.frame.contains(rect) ?? false { number(index: 0) }

        if plus?.frame.contains(rect) ?? false { calculatorValue(index: Calculator.plus.rawValue) }
        if minus?.frame.contains(rect) ?? false { calculatorValue(index: Calculator.minus.rawValue) }
        if divite?.frame.contains(rect) ?? false { calculatorValue(index: Calculator.division.rawValue) }
        if multiplication?.frame.contains(rect) ?? false { calculatorValue(index: Calculator.multiplication.rawValue) }

        if claer?.frame.contains(rect) ?? false {
            let tex = textLabel?.text?.dropLast(1) ?? ""
            plusNumber = String(tex)
            textLabel?.text = String(tex)
        }

        if allClaer?.frame.contains(rect) ?? false {
            total = nil
            plusNumber = ""
            textLabel?.text = ""
        }

        if enter?.frame.contains(rect)  ?? false {
            if total != nil,  calculatorNum != nil, textLabel?.text != nil {
                let indexNumber = calculator(index: calculatorNum!,
                                             txtNumber:  Float(total!)!,
                                             txtNumber2: Float(textLabel!.text!)!)
                total = nil
                plusNumber = ""
                textLabel?.text = indexNumber.description
            }
        }
    }

    private func number(index: Int) {
        plusNumber += index.description
        textLabel?.text = plusNumber
    }

    private func calculatorValue(index: Int) {
        if total != nil, textLabel != nil {
            totalNumber = calculator(index: index,
                                     txtNumber:  Float(total!)!,
                                     txtNumber2: Float(textLabel!.text!)!)
            total = totalNumber?.description
            textLabel?.text = totalNumber?.description
        } else {
            total = textLabel?.text
        }
          plusNumber = ""
          calculatorNum = index
    }

    private func calculator(index: Int, txtNumber: Float, txtNumber2: Float) -> Float {
        switch index {
        case Calculator.plus.rawValue: return txtNumber + txtNumber2
        case Calculator.minus.rawValue: return txtNumber - txtNumber2
        case Calculator.division.rawValue: return txtNumber / txtNumber2
        case Calculator.multiplication.rawValue: return txtNumber * txtNumber2
        default:
            return Float()
        }
    }
}

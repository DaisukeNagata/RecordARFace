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
    @IBOutlet weak var aniLabel: UILabel?
    
    private var plusNumber = ""
    private var total: String?
    private var calculatorNum: Int?

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
        if one?.frame.contains(rect) ?? false {
            self.aniLabel?.frame = self.one?.frame ?? CGRect()
            ani(bt: self.one ?? UIButton(), index: 1)
        }
        if two?.frame.contains(rect) ?? false {
            self.aniLabel?.frame = self.two?.frame ?? CGRect()
            ani(bt: self.two ?? UIButton(), index: 2)
        }
        if three?.frame.contains(rect) ?? false {
            self.aniLabel?.frame = self.three?.frame ?? CGRect()
            ani(bt: self.three ?? UIButton(), index: 3)
        }
        if four?.frame.contains(rect) ?? false {
            self.aniLabel?.frame = self.four?.frame ?? CGRect()
            ani(bt: self.four ?? UIButton(), index: 4)
        }
        if five?.frame.contains(rect) ?? false {
            self.aniLabel?.frame = self.five?.frame ?? CGRect()
            ani(bt: self.five ?? UIButton(), index: 5)
        }
        if six?.frame.contains(rect) ?? false {
            self.aniLabel?.frame = self.six?.frame ?? CGRect()
            ani(bt: self.six ?? UIButton(), index: 6)
        }
        if seven?.frame.contains(rect) ?? false {
            self.aniLabel?.frame = self.seven?.frame ?? CGRect()
            ani(bt: self.seven ?? UIButton(), index: 7)
        }
        if eight?.frame.contains(rect) ?? false {
            self.aniLabel?.frame = self.eight?.frame ?? CGRect()
            ani(bt: self.eight ?? UIButton(), index: 8)
        }
        if nine?.frame.contains(rect) ?? false {
            self.aniLabel?.frame = self.nine?.frame ?? CGRect()
            ani(bt: self.nine ?? UIButton(), index: 9)
        }
        if zero?.frame.contains(rect) ?? false {
            self.aniLabel?.frame = self.zero?.frame ?? CGRect()
            ani(bt: self.zero ?? UIButton(), index: 0)
        }
        if plus?.frame.contains(rect) ?? false {
            self.aniLabel?.frame = self.plus?.frame ?? CGRect()
            aniCalculatorValue(bt: self.plus ?? UIButton(), index: Calculator.plus.rawValue)
        }
        if minus?.frame.contains(rect) ?? false {
            self.aniLabel?.frame = self.minus?.frame ?? CGRect()
            aniCalculatorValue(bt: self.minus ?? UIButton(), index: Calculator.minus.rawValue)
        }
        if divite?.frame.contains(rect) ?? false {
            self.aniLabel?.frame = self.divite?.frame ?? CGRect()
            aniCalculatorValue(bt: self.divite ?? UIButton(), index: Calculator.division.rawValue)
        }
        if multiplication?.frame.contains(rect) ?? false {
            self.aniLabel?.frame = self.multiplication?.frame ?? CGRect()
            aniCalculatorValue(bt: self.multiplication ?? UIButton(), index: Calculator.multiplication.rawValue)
        }
        if claer?.frame.contains(rect) ?? false {
            let tex = textLabel?.text?.dropLast(1) ?? ""
            plusNumber = String(tex)
            textLabel?.text = String(tex)
        }
        if allClaer?.frame.contains(rect) ?? false {
            self.aniLabel?.frame = self.allClaer?.frame ?? CGRect()
            UIView.animate(withDuration: 2.0, animations: {
                self.aniLabel?.frame.origin.x = self.allClaer?.frame.origin.x ?? CGFloat()
                self.aniLabel?.frame.origin.y = self.allClaer?.frame.origin.y ?? CGFloat()
                self.aniLabel?.frame.size.width = self.allClaer?.frame.width ?? CGFloat()
                self.aniLabel?.frame.size.height = self.allClaer?.frame.height ?? CGFloat()
                self.aniLabel?.alpha = 0.7
            }) { _ in
                if self.aniLabel?.alpha == 0 {
                    self.total = nil
                    self.plusNumber = ""
                    self.textLabel?.text = ""
                }
                self.aniLabel?.alpha = 0
            }
        }
        if enter?.frame.contains(rect)  ?? false {
            self.aniLabel?.frame = self.enter?.frame ?? CGRect()
            UIView.animate(withDuration: 2.0, animations: {
                self.aniLabel?.frame.origin.x = self.enter?.frame.origin.x ?? CGFloat()
                self.aniLabel?.frame.origin.y = self.enter?.frame.origin.y ?? CGFloat()
                self.aniLabel?.frame.size.width = self.enter?.frame.width ?? CGFloat()
                self.aniLabel?.frame.size.height = self.enter?.frame.height ?? CGFloat()
                self.aniLabel?.alpha = 0.7
            }) { _ in
                if self.total != nil {
                    self.aniLabel?.alpha = 0.7
                    let indexNumber = self.calculator(index: self.calculatorNum!,
                                                      txtNumber:  Float(self.total!)!,
                                                      txtNumber2: Float(self.textLabel!.text!)!)
                    self.total = nil
                    self.plusNumber = ""
                    self.textLabel?.text = indexNumber.description
                }
                self.aniLabel?.alpha = 0
            }
        }
    }

    private func ani(bt: UIButton, index: Int) {
        UIView.animate(withDuration: 2.0, animations: {
            self.aniLabel?.frame.origin.x = bt.frame.origin.x
            self.aniLabel?.frame.origin.y = bt.frame.origin.y
            self.aniLabel?.frame.size.width = bt.frame.width
            self.aniLabel?.frame.size.height = bt.frame.height
            self.aniLabel?.alpha = 0.7
        }) { _ in
            if self.aniLabel?.alpha == 0 {
                self.aniLabel?.alpha = 0.7
                self.number(index: index)
            }
            self.aniLabel?.alpha = 0
        }
    }

    private func number(index: Int) {
        plusNumber += index.description
        textLabel?.text = plusNumber
    }

    private func aniCalculatorValue(bt: UIButton, index: Int) {
        UIView.animate(withDuration: 2.0, animations: {
            self.aniLabel?.frame.origin.x = bt.frame.origin.x
            self.aniLabel?.frame.origin.y = bt.frame.origin.y
            self.aniLabel?.frame.size.width = bt.frame.width
            self.aniLabel?.frame.size.height = bt.frame.height
            self.aniLabel?.alpha = 0.7
        }) { _ in
            if self.aniLabel?.alpha == 0 {
                self.aniLabel?.alpha = 0.7
                self.calculatorValue(index: index)
            }
            self.aniLabel?.alpha = 0
        }
    }

    private func calculatorValue(index: Int) {
        if total != nil {
            let totalNumber = calculator(index: index,
                                     txtNumber:  Float(total!)!,
                                     txtNumber2: Float(textLabel!.text!)!)
            total = totalNumber.description
            textLabel?.text = totalNumber.description
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

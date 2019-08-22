//
//  RARFLuangageKeyBoard.swift
//  RecordARFace
//
//  Created by 永田大祐 on 2019/02/06.
//  Copyright © 2019 永田大祐. All rights reserved.
//

import UIKit

public var RARFUrlPath = String()

final class RARFLuangageKeyBoard: UIView {

    var flg       = false
    var rectFrame : CGRect!
    var spell     : RARFSpellAndKeyBoard?
    var number    : RARFNumberChangeKeyBoardView?

    @IBOutlet weak var arrow       : RARFNumberButton?
    @IBOutlet weak var reload      : RARFNumberButton?
    @IBOutlet weak var change      : RARFNumberButton?
    @IBOutlet weak var symbol      : RARFNumberButton?
    @IBOutlet weak var aColumn     : RARFNumberButton?
    @IBOutlet weak var dColumn     : RARFNumberButton?
    @IBOutlet weak var backColumn  : RARFNumberButton?
    @IBOutlet weak var reloadColumn: RARFNumberButton?
    @IBOutlet weak var gColumn     : RARFNumberButton?
    @IBOutlet weak var jColumn     : RARFNumberButton?
    @IBOutlet weak var mColumn     : RARFNumberButton?
    @IBOutlet weak var space       : RARFNumberButton?
    @IBOutlet weak var numColumn   : RARFNumberButton?
    @IBOutlet weak var pColumn     : RARFNumberButton?
    @IBOutlet weak var tColumn     : RARFNumberButton?
    @IBOutlet weak var wColumn     : RARFNumberButton?
    @IBOutlet weak var openColumn  : RARFNumberButton?
    @IBOutlet weak var lower       : RARFNumberButton?
    @IBOutlet weak var darkSpot    : RARFNumberButton?
    @IBOutlet weak var what        : RARFNumberButton?
    @IBOutlet weak var openWeb     : RARFNumberButton?
    @IBOutlet weak var testLabel   : UILabel?


    init(spellKey: RARFSpellAndKeyBoard? = nil, numberKey: RARFNumberChangeKeyBoardView? = nil) {
        super.init(frame: .zero)
        self.frame = UIScreen.main.bounds
        loadNib()
        spell  = spellKey
        number = numberKey
        number?.views = self
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }

    func loadNib() {
        let bundle = Bundle(for: RARFLuangageKeyBoard.self)
        let view = bundle.loadNibNamed("RARFLuangageKeyBoard", owner: self, options: nil)?.first as! UIView
        view.frame = UIScreen.main.bounds
        self.addSubview(view)
    }

    @objc func originTextField(rect: CGRect,timer: Timer) {
        rectFrame = rect

        if arrow?.frame.contains(rectFrame) ?? false {
            testLabel?.text = String(testLabel?.text?.dropLast(1) ?? "" )
            spell?.texLabel = testLabel?.text ?? ""
            number?.texLabel = testLabel?.text ?? ""
        }

        if reload?.frame.contains(rectFrame) ?? false {
            if symbol?.title(for: .normal) == "1" {
                testLabel?.text = String(testLabel?.text?.dropLast(1) ?? "")
                number?.texLabel = testLabel?.text ?? ""
                number?.selfAlpha(view: self, timer: timer)
            } else {
                testLabel?.text = String(testLabel?.text?.dropLast(1) ?? "" )
                spell?.texLabel = testLabel?.text ?? ""
                spell?.selfAlpha(view: self, timer: timer)
            }
        }

        if backColumn?.frame.contains(rectFrame) ?? false {
            testLabel?.text = ""
            spell?.texLabel = ""
            number?.texLabel = ""
        }
        
        if space?.frame.contains(rectFrame) ?? false {
            spell?.texLabel += " "
            number?.texLabel += " "
        }
        
        if lower?.frame.contains(rectFrame) ?? false {
            if testLabel?.text == testLabel?.text?.applyingTransform(.fullwidthToHalfwidth, reverse: true) {
                testLabel?.text  = testLabel?.text?.applyingTransform(.fullwidthToHalfwidth, reverse: false)
            } else {
                testLabel?.text  = testLabel?.text?.applyingTransform(.fullwidthToHalfwidth, reverse: true)
            }
        }

        if openWeb?.frame.contains(rectFrame) ?? false {
            guard testLabel?.text != "" else { return }
            let tex = testLabel?.text ?? ""
            if let url = URL(string: RARFUrlPath + tex) {
 
                guard !UIApplication.shared.canOpenURL(url) else {
                    UIApplication.shared.open(url)
                    testLabel?.text = ""
                    return
                }
            }
        }

        if symbol?.title(for: .normal) == "1" {
            number(timer: timer)
        } else {
            spell(timer: timer)
        }
    }

    func numMethod() {
        if  symbol?.title(for: .normal) != "1" {
            symbol?.setTitle("1", for: .normal)
            aColumn?.setTitle("2", for: .normal)
            dColumn?.setTitle("3", for: .normal)
            gColumn?.setTitle("4", for: .normal)
            jColumn?.setTitle("5", for: .normal)
            mColumn?.setTitle("6", for: .normal)
            pColumn?.setTitle("7", for: .normal)
            tColumn?.setTitle("8", for: .normal)
            wColumn?.setTitle("9", for: .normal)
            lower?.setTitle("()[]", for: .normal)
            darkSpot?.setTitle("0", for: .normal)
            what?.setTitle(".,-/", for: .normal)
            number?.texLabel = spell?.texLabel ?? ""
        } else {
            symbol?.setTitle("＠＃/&", for: .normal)
            aColumn?.setTitle("ABC", for: .normal)
            dColumn?.setTitle("DEF", for: .normal)
            gColumn?.setTitle("GHI", for: .normal)
            jColumn?.setTitle("JKL", for: .normal)
            mColumn?.setTitle("MNO", for: .normal)
            pColumn?.setTitle("PQRS", for: .normal)
            tColumn?.setTitle("TUV", for: .normal)
            wColumn?.setTitle("WXYZ", for: .normal)
            lower?.setTitle("a/A", for: .normal)
            darkSpot?.setTitle("'()", for: .normal)
            what?.setTitle(".,?!", for: .normal)
            spell?.texLabel = number?.texLabel ?? ""
        }
    }

    func spell(timer: Timer) {
        if numColumn?.frame.contains(rectFrame) ?? false { numMethod()}
        if what?.frame.contains(rectFrame) ?? false { whatSpell(timer: timer)}
        if symbol?.frame.contains(rectFrame) ?? false { symbolSpell(timer: timer)}
        if aColumn?.frame.contains(rectFrame) ?? false { aColumnSpell(timer: timer)}
        if dColumn?.frame.contains(rectFrame) ?? false { dColumnSpell(timer: timer)}
        if gColumn?.frame.contains(rectFrame) ?? false { gColumnSpell(timer: timer)}
        if jColumn?.frame.contains(rectFrame) ?? false { jColumnSpell(timer: timer)}
        if mColumn?.frame.contains(rectFrame) ?? false { mColumnSpell(timer: timer)}
        if pColumn?.frame.contains(rectFrame) ?? false { pColumnSpell(timer: timer)}
        if tColumn?.frame.contains(rectFrame) ?? false { tColumnSpell(timer: timer)}
        if wColumn?.frame.contains(rectFrame) ?? false { wColumnSpell(timer: timer)}
        if darkSpot?.frame.contains(rectFrame) ?? false { darkSpotSpell(timer: timer)}
    }
    
    func number(timer: Timer) {
        if numColumn?.frame.contains(rectFrame) ?? false { numMethod()}
        if symbol?.frame.contains(rectFrame) ?? false { numOneColumnSpell(timer: timer)}
        if aColumn?.frame.contains(rectFrame) ?? false { numTwoColumnSpell(timer: timer)}
        if dColumn?.frame.contains(rectFrame) ?? false { numThreeColumnSpell(timer: timer)}
        if gColumn?.frame.contains(rectFrame) ?? false { numFourColumnSpell(timer: timer)}
        if jColumn?.frame.contains(rectFrame) ?? false { numFiveColumnSpell(timer: timer)}
        if mColumn?.frame.contains(rectFrame) ?? false { numSixColumnSpell(timer: timer)}
        if pColumn?.frame.contains(rectFrame) ?? false { numSevenColumnSpell(timer: timer)}
        if tColumn?.frame.contains(rectFrame) ?? false { numEightColumnSpell(timer: timer)}
        if wColumn?.frame.contains(rectFrame) ?? false { numNineColumnSpell(timer: timer)}
        if darkSpot?.frame.contains(rectFrame) ?? false { numZeroColumnSpell(timer: timer)}
        if lower?.frame.contains(rectFrame) ?? false { numlowerColumnSpell(timer: timer)}
    }

    func whatSpell(timer: Timer) {  spell?.what(view: self, timer: timer) }
    func symbolSpell(timer: Timer) { spell?.symbol(view: self, timer: timer) }
    func aColumnSpell(timer: Timer) { spell?.aColumn(view: self, timer: timer) }
    func dColumnSpell(timer: Timer) { spell?.dColumn(view: self, timer: timer) }
    func gColumnSpell(timer: Timer) { spell?.gColumn(view: self, timer: timer) }
    func jColumnSpell(timer: Timer) { spell?.jColumn(view: self, timer: timer) }
    func mColumnSpell(timer: Timer) { spell?.mColumn(view: self, timer: timer) }
    func pColumnSpell(timer: Timer) { spell?.pColumn(view: self, timer: timer) }
    func tColumnSpell(timer: Timer) { spell?.tColumn(view: self, timer: timer) }
    func wColumnSpell(timer: Timer) { spell?.wColumn(view: self, timer: timer) }
    func darkSpotSpell(timer: Timer) { spell?.darkSpot(view: self, timer: timer) }
    func numOneColumnSpell(timer: Timer) { number?.oneColumn(view: self, timer: timer) }
    func numTwoColumnSpell(timer: Timer) { number?.twoColumn(view: self, timer: timer) }
    func numThreeColumnSpell(timer: Timer) { number?.threeColumn(view: self, timer: timer) }
    func numFourColumnSpell(timer: Timer) { number?.fourColumn(view: self, timer: timer) }
    func numFiveColumnSpell(timer: Timer) { number?.fiveColumn(view: self, timer: timer) }
    func numSixColumnSpell(timer: Timer) { number?.sixColumn(view: self, timer: timer) }
    func numSevenColumnSpell(timer: Timer) { number?.sevenColumn(view: self, timer: timer) }
    func numEightColumnSpell(timer: Timer) { number?.eightColumn(view: self, timer: timer) }
    func numNineColumnSpell(timer: Timer) { number?.nineColumn(view: self, timer: timer) }
    func numZeroColumnSpell(timer: Timer) { number?.zeroColumn(view: self, timer: timer) }
    func numlowerColumnSpell(timer: Timer) { number?.lowerColumn(view: self, timer: timer) }
}

//
//  RARFLuangageKeyBoard.swift
//  RecordARFace
//
//  Created by 永田大祐 on 2019/02/06.
//  Copyright © 2019 永田大祐. All rights reserved.
//

import UIKit

final class RARFLuangageKeyBoard: UIView {

    var flg = false
    var rectFrame: CGRect!
    var spell: RARFSpellAndKeyBoard!

    @IBOutlet weak var arrow: RARFNumberButton!
    @IBOutlet weak var reload: RARFNumberButton!
    @IBOutlet weak var change: RARFNumberButton!
    @IBOutlet weak var symbol: RARFNumberButton!
    @IBOutlet weak var aColumn: RARFNumberButton!
    @IBOutlet weak var dColumn: RARFNumberButton!
    @IBOutlet weak var backColumn: RARFNumberButton!
    @IBOutlet weak var reloadColumn: RARFNumberButton!
    @IBOutlet weak var gColumn: RARFNumberButton!
    @IBOutlet weak var jColumn: RARFNumberButton!
    @IBOutlet weak var mColumn: RARFNumberButton!
    @IBOutlet weak var space: RARFNumberButton!
    @IBOutlet weak var numColumn: RARFNumberButton!
    @IBOutlet weak var pColumn: RARFNumberButton!
    @IBOutlet weak var tColumn: RARFNumberButton!
    @IBOutlet weak var wColumn: RARFNumberButton!
    @IBOutlet weak var openColumn: RARFNumberButton!
    @IBOutlet weak var lower: RARFNumberButton!
    @IBOutlet weak var darkSpot: RARFNumberButton!
    @IBOutlet weak var what: RARFNumberButton!
    
    @IBOutlet weak var testLabel: UILabel!
    

     init(spellKey: RARFSpellAndKeyBoard) {
        spell = spellKey
        super.init(frame: .zero)
        self.frame = UIScreen.main.bounds
        loadNib()
        spell.views = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }

    func spaceBt() { print(" ") }

    func backColumnBt() { print(" ") }

    func loadNib() {
        let bundle = Bundle(for: RARFLuangageKeyBoard.self)
        let view = bundle.loadNibNamed("RARFLuangageKeyBoard", owner: self, options: nil)?.first as! UIView
        view.frame = UIScreen.main.bounds
        self.addSubview(view)
    }

    @objc func originTextField(rect: CGRect,timer: Timer) {
        rectFrame = rect
        rectFrame.origin.y -= UINavigationController.init().navigationBar.frame.height + UIApplication.shared.statusBarFrame.height

            if arrow.frame.contains(rectFrame) { symbolSpell(timer: timer)}
            if aColumn.frame.contains(rectFrame) { aColumnSpell(timer: timer)}
            if dColumn.frame.contains(rectFrame) { dColumnSpell(timer: timer)}
            if gColumn.frame.contains(rectFrame) { gColumnSpell(timer: timer)}
            if jColumn.frame.contains(rectFrame) { jColumnSpell(timer: timer)}
            if mColumn.frame.contains(rectFrame) { mColumnSpell(timer: timer)}
            if pColumn.frame.contains(rectFrame) { pColumnSpell(timer: timer)}
            if tColumn.frame.contains(rectFrame) { tColumnSpell(timer: timer)}
            if wColumn.frame.contains(rectFrame) { wColumnSpell(timer: timer)}
            if darkSpot.frame.contains(rectFrame) { darkSpotSpell(timer: timer)}
            if what.frame.contains(rectFrame) { whatSpell(timer: timer)}
            if lower.frame.contains(rectFrame) { lowerMentod()}
            if space.frame.contains(rectFrame) { spaceMentod()}
    }

    func symbolSpell(timer: Timer) { spell.symbol(view: self, timer: timer) }

    func aColumnSpell(timer: Timer) { spell.aColumn(view: self, timer: timer) }

    func dColumnSpell(timer: Timer) { spell.dColumn(view: self, timer: timer) }
    
    func gColumnSpell(timer: Timer) { spell.gColumn(view: self, timer: timer) }

    func jColumnSpell(timer: Timer) { spell.jColumn(view: self, timer: timer) }

    func mColumnSpell(timer: Timer) { spell.mColumn(view: self, timer: timer) }
    
    func pColumnSpell(timer: Timer) { spell.pColumn(view: self, timer: timer) }
    
    func tColumnSpell(timer: Timer) { spell.tColumn(view: self, timer: timer) }
    
    func wColumnSpell(timer: Timer) { spell.wColumn(view: self, timer: timer) }

    func darkSpotSpell(timer: Timer) { spell.darkSpot(view: self, timer: timer) }

    func whatSpell(timer: Timer) {  spell.what(view: self, timer: timer) }

    func spaceMentod() { self.spaceBt() }

    func lowerMentod() { self.backColumnBt() }

}

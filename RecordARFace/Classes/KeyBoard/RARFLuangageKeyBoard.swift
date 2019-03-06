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
    var spellTimer: Timer?
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

    @objc func originTextField(rect: CGRect) {
        rectFrame = rect
        rectFrame.origin.y -= UINavigationController.init().navigationBar.frame.height + UIApplication.shared.statusBarFrame.height

        if flg == false {
            if arrow.frame.contains(rectFrame) { symbolSpell()}
            if aColumn.frame.contains(rectFrame) { aColumnSpell()}
            if dColumn.frame.contains(rectFrame) { dColumnSpell()}
            if gColumn.frame.contains(rectFrame) { gColumnSpell() }
            if jColumn.frame.contains(rectFrame) { jColumnSpell() }
            if mColumn.frame.contains(rectFrame) { mColumnSpell() }
            if pColumn.frame.contains(rectFrame) { pColumnSpell() }
            if tColumn.frame.contains(rectFrame) { tColumnSpell() }
            if wColumn.frame.contains(rectFrame) { wColumnSpell() }
            if darkSpot.frame.contains(rectFrame) { darkSpotSpell() }
            if what.frame.contains(rectFrame) { whatSpell() }
            if lower.frame.contains(rectFrame) { lowerMentod() }
            if space.frame.contains(rectFrame) { spaceMentod() }
        }
    }

    @objc func spellKeyUpdate() {
        spell.originTextField(rect: rectFrame, timer: spellTimer!)
    }

    func symbolSpell(){
        spell.symbol(view: self)
        self.alpha = 0
        flg = true
    }

    // TODO: Logic
    func aColumnSpell() {
        spell.aColumn(view: self)
        self.alpha = 0
        flg = true
    }

    func dColumnSpell(){
        spell.dColumn(view: self)
        self.alpha = 0
        flg = true
    }
    
    func gColumnSpell() {
        spell.gColumn(view: self)
        self.alpha = 0
        flg = true
    }
    func jColumnSpell() {
        spell.jColumn(view: self)
        self.alpha = 0
        flg = true
    }

    func mColumnSpell() {
        spell.mColumn(view: self)
        self.alpha = 0
        flg = true
    }
    
    func pColumnSpell() {
        spell.pColumn(view: self)
        self.alpha = 0
        flg = true
    }
    
    func tColumnSpell() {
        spell.tColumn(view: self)
        self.alpha = 0
        flg = true
    }
    
    func wColumnSpell() {
        spell.wColumn(view: self)
        self.alpha = 0
        flg = true
    }

    func darkSpotSpell() {
        spell.darkSpot(view: self)
        self.alpha = 0
        flg = true
    }

    func whatSpell() {
        spell.what(view: self)
        self.alpha = 0
        flg = true
    }

    func spaceMentod() { self.spaceBt() }

    func lowerMentod() { self.backColumnBt() }

    func kvo() { self.alpha = 1 }
}

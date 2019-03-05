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
        spell.addKVO(view: spell, kvo)
        spell.symbol(rect: rectFrame)
        self.isHidden = true
    }

    // TODO: Logic
    func aColumnSpell() {
//        spell.addKVO(view: spell, kvo)
        spell.aColumn(view: self)
        self.alpha = 0
        flg = true
    }

    func dColumnSpell(){
        spell.addKVO(view: spell, kvo)
        spell.dColumn(rect: rectFrame)
        self.alpha = 0
    }
    
    func gColumnSpell() {
        spell.addKVO(view: spell, kvo)
        spell.gColumn(view: self)
    }

    func jColumnSpell() {
        spell.addKVO(view: spell, kvo)
        spell.jColumn(view: self)
    }

    func mColumnSpell() {
        spell.addKVO(view: spell, kvo)
        spell.mColumn(view: self)
    }
    
    func pColumnSpell() {
        spell.addKVO(view: spell, kvo)
        spell.pColumn(view: self)
    }
    
    func tColumnSpell() {
        spell.addKVO(view: spell, kvo)
        spell.tColumn(view: self)
    }
    
    func wColumnSpell() {
        spell.addKVO(view: spell, kvo)
        spell.wColumn(view: self)
    }

    func darkSpotSpell() {
        spell.addKVO(view: spell, kvo)
        spell.darkSpot(view: self)
    }

    func whatSpell() {
        spell.addKVO(view: spell, kvo)
        spell.what(view: self)
    }

    func spaceMentod() { self.spaceBt() }

    func lowerMentod() { self.backColumnBt() }

    func kvo() { self.alpha = 1 }
}

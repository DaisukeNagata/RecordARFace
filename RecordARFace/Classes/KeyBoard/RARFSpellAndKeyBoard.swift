//
//  RARFSpellAndKeyBoard.swift
//  SampleKeyBoard
//
//  Created by 永田大祐 on 2019/02/07.
//  Copyright © 2019 永田大祐. All rights reserved.
//

import UIKit

final class RARFSpellAndKeyBoard: UIView {

    @IBOutlet weak var upKey: RARFNumberButton?
    @IBOutlet weak var centerKey: RARFNumberButton?
    @IBOutlet weak var underKey: RARFNumberButton?
    @IBOutlet weak var rightKey: RARFNumberButton?
    @IBOutlet weak var leftKey: RARFNumberButton?
    @IBOutlet weak var backKey: RARFNumberButton?
    

    private var originFrame: CGRect?
    
    var texLabel = String()
    var rARFObject:  RARFObject?
    

    init(ob: RARFObject) {
        super.init(frame: .zero)

        loadNib()
        rARFObject = ob
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        loadNib()
    }

    func loadNib() {
        self.frame = UIScreen.main.bounds
        self.alpha = 0
        let bundle = Bundle(for: RARFSpellAndKeyBoard.self)
        let view = bundle.loadNibNamed("RARFSpellAndKeyBoard", owner: self, options: nil)?.first as! UIView
        view.frame.size.width = self.frame.width
        view.frame.size.height = self.frame.width
        self.addSubview(view)
    }

    func originTextField(rect: CGRect,timer: Timer, view: RARFLuangageKeyBoard) {
        originFrame = rect
        if centerKey?.title(for: .normal) == "＠" { symbol(view: view, timer: timer)}
        if centerKey?.title(for: .normal) == "A" { aColumn(view: view, timer: timer)}
        if centerKey?.title(for: .normal) == "D" { dColumn(view: view, timer: timer)}
        if centerKey?.title(for: .normal) == "G" { gColumn(view: view, timer: timer)}
        if centerKey?.title(for: .normal) == "J" { jColumn(view: view, timer: timer)}
        if centerKey?.title(for: .normal) == "M" { mColumn(view: view, timer: timer)}
        if centerKey?.title(for: .normal) == "P" { pColumn(view: view, timer: timer)}
        if centerKey?.title(for: .normal) == "T" { tColumn(view: view, timer: timer)}
        if centerKey?.title(for: .normal) == "W" { wColumn(view: view, timer: timer)}
        if centerKey?.title(for: .normal) == "\'" { darkSpot(view: view, timer: timer)}
        if centerKey?.title(for: .normal) == "." { what(view: view, timer: timer)}
    }

    func symbol(view: RARFLuangageKeyBoard, timer: Timer) {
        guard self.alpha == 1, let rect = originFrame else { setTitle(c: "＠", l: "#", r: "&", up: "/", under: "-", back: "back", view: view, timer: timer); return }
        if centerKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "＠") }
        if leftKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "#") }
        if rightKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "&") }
        if upKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "/") }
        if underKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "-") }
        if backKey?.frame.contains(rect) ?? false { backView(view: view, timer: timer) }
    }

    func aColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        guard self.alpha == 1, let rect = originFrame else { setTitle(c: "A", l: "B", r: "C", up: "", under: "", back: "back", view: view, timer: timer); upKey?.alpha = 0; underKey?.alpha = 0; return }
        if centerKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "A") }
        if leftKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "B") }
        if rightKey?.frame.contains(rect) ?? false {  alphaMethod(view: view, timer: timer, st: "C") }
        if backKey?.frame.contains(rect) ?? false { backView(view: view, timer: timer) }
    }

    func dColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        guard self.alpha == 1, let rect = originFrame else { setTitle(c: "D", l: "E", r: "F", up: "", under: "", back: "back", view: view, timer: timer); upKey?.alpha = 0; underKey?.alpha = 0; return }
        if centerKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "D") }
        if leftKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "E") }
        if rightKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "F") }
        if backKey?.frame.contains(rect) ?? false { backView(view: view, timer: timer) }
    }

    func gColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        guard self.alpha == 1, let rect = originFrame else  { setTitle(c: "G", l: "H", r: "I", up: "", under: "", back: "back", view: view, timer: timer); upKey?.alpha = 0; underKey?.alpha = 0; return }
        if centerKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "G") }
        if leftKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "H") }
        if rightKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "I") }
        if backKey?.frame.contains(rect) ?? false { backView(view: view, timer: timer) }
    }

    func jColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        guard self.alpha == 1, let rect = originFrame else { setTitle(c: "J", l: "K", r: "L", up: "", under: "", back: "back", view: view, timer: timer); upKey?.alpha = 0; underKey?.alpha = 0; return }
        if centerKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "J") }
        if leftKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "K") }
        if rightKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "L") }
        if backKey?.frame.contains(rect) ?? false { backView(view: view, timer: timer) }
    }

    func mColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        guard self.alpha == 1, let rect = originFrame else { setTitle(c: "M", l: "N", r: "O", up: "", under: "", back: "back", view: view, timer: timer); upKey?.alpha = 0; underKey?.alpha = 0; return }
        if centerKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "M") }
        if leftKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "N") }
        if rightKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "O") }
        if backKey?.frame.contains(rect) ?? false { backView(view: view, timer: timer) }
    }

    func pColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        guard self.alpha == 1, let rect = originFrame else { setTitle(c: "P", l: "Q", r: "S", up: "R", under: "", back: "back", view: view, timer: timer); underKey?.alpha = 0; return }
        if centerKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "P") }
        if leftKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "Q") }
        if upKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "R")}
        if rightKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "S") }
        if backKey?.frame.contains(rect) ?? false { backView(view: view, timer: timer) }
    }

    func tColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        guard self.alpha == 1, let rect = originFrame else{ setTitle(c: "T", l: "U", r: "V", up: "", under: "", back: "back", view: view, timer: timer); upKey?.alpha = 0; underKey?.alpha = 0; return }
        if centerKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "T") }
        if leftKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "U") }
        if rightKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "V") }
        if backKey?.frame.contains(rect) ?? false { backView(view: view, timer: timer) }
    }

    func wColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        guard self.alpha == 1, let rect = originFrame else { setTitle(c: "W", l: "X", r: "Y", up: "Z", under: "", back: "back", view: view, timer: timer); underKey?.alpha = 0; return }
        if centerKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "W") }
        if leftKey?.frame.contains(rect) ?? false {alphaMethod(view: view, timer: timer, st: "X") }
        if rightKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "Y") }
        if upKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "Z") }
        if backKey?.frame.contains(rect) ?? false { backView(view: view, timer: timer) }
    }

    func darkSpot(view: RARFLuangageKeyBoard, timer: Timer) {
        guard self.alpha == 1, let rect = originFrame else { setTitle(c: "\'", l: "\"", r: ")", up: "(", under: "", back: "back", view: view, timer: timer); underKey?.alpha = 0; return }
        if centerKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "\'") }
        if leftKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "\"") }
        if rightKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: ")") }
        if upKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "(") }
        if backKey?.frame.contains(rect) ?? false { backView(view: view, timer: timer) }
    }

    func what(view: RARFLuangageKeyBoard, timer: Timer) {
        guard self.alpha == 1, let rect = originFrame else { setTitle(c: ".", l: ",", r: "!", up: "?", under: "", back: "back", view: view, timer: timer); underKey?.alpha = 0; return }
        if centerKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: ".") }
        if leftKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: ",") }
        if rightKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "!") }
        if upKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "?") }
        if backKey?.frame.contains(rect) ?? false { backView(view: view, timer: timer) }
        
    }
    
    func setTitle(c: String, l: String, r: String, up: String, under: String, back: String, view: RARFLuangageKeyBoard, timer: Timer) {
        selfAlpha(view: view, timer: timer)
        centerKey?.alpha = 1; centerKey?.setTitle(c, for: .normal)
        leftKey?.alpha = 1; leftKey?.setTitle(l, for: .normal)
        rightKey?.alpha = 1; rightKey?.setTitle(r, for: .normal)
        upKey?.alpha = 1; upKey?.setTitle(up, for: .normal)
        underKey?.alpha = 1; underKey?.setTitle(under, for: .normal)
        backKey?.alpha = 1; backKey?.setTitle(back, for: .normal)
    }
    
    func selfAlpha(view: RARFLuangageKeyBoard,  timer: Timer) {
        timer.invalidate()
        rARFObject?.updateSpellKey()
        view.alpha = 0
        self.alpha = 1
    }

    func alphaMethod(view: RARFLuangageKeyBoard,timer: Timer, st: String) {
        timer.invalidate()
        rARFObject?.upDateluangageKey()
        self.alpha = 0
        view.alpha = 1
        texLabel += st
        view.testLabel?.text = texLabel
    }

    func backView(view: RARFLuangageKeyBoard,timer: Timer) {
        timer.invalidate()
        rARFObject?.upDateluangageKey()
        self.alpha = 0
        view.alpha = 1
    }
}

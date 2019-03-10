//
//  RARFSpellAndKeyBoard.swift
//  SampleKeyBoard
//
//  Created by 永田大祐 on 2019/02/07.
//  Copyright © 2019 永田大祐. All rights reserved.
//

import UIKit

final class RARFSpellAndKeyBoard: UIView {

    @IBOutlet weak var upKey: RARFNumberButton!
    @IBOutlet weak var centerKey: RARFNumberButton!
    @IBOutlet weak var underKey: RARFNumberButton!
    @IBOutlet weak var rightKey: RARFNumberButton!
    @IBOutlet weak var leftKey: RARFNumberButton!

    private var originFrame: CGRect?
    
    var texLabel = String()
    var rARFObject:  RARFObject?
    var views: RARFLuangageKeyBoard?
    

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

    func originTextField(rect: CGRect,timer: Timer) {
        originFrame = rect
        originFrame!.origin.y -= UINavigationController.init().navigationBar.frame.height + UIApplication.shared.statusBarFrame.height
        if centerKey.title(for: .normal) == "＠" { symbol(view: views!, timer: timer)}
        if centerKey.title(for: .normal) == "A" { aColumn(view: views!, timer: timer)}
        if centerKey.title(for: .normal) == "D" { dColumn(view: views!, timer: timer)}
        if centerKey.title(for: .normal) == "G" { gColumn(view: views!, timer: timer)}
        if centerKey.title(for: .normal) == "J" { jColumn(view: views!, timer: timer)}
        if centerKey.title(for: .normal) == "M" { mColumn(view: views!, timer: timer)}
        if centerKey.title(for: .normal) == "P" { pColumn(view: views!, timer: timer)}
        if centerKey.title(for: .normal) == "T" { tColumn(view: views!, timer: timer)}
        if centerKey.title(for: .normal) == "W" { wColumn(view: views!, timer: timer)}
        if centerKey.title(for: .normal) == "\'" { darkSpot(view: views!, timer: timer)}
        if centerKey.title(for: .normal) == "." { what(view: views!, timer: timer)}
    }

    func symbol(view: RARFLuangageKeyBoard, timer: Timer) {
        views = view
        guard self.alpha == 1 else { setTitle(c: "＠", l: "#", r: "&", up: "/", under: "-", view: views!, timer: timer); return }
        if centerKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: "＠") }
        if leftKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: "#") }
        if rightKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: "&") }
        if upKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: "/") }
        if underKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: "-") }
    }

    func aColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        views = view
        guard self.alpha == 1 else { setTitle(c: "A", l: "B", r: "C", up: "", under: "", view: views!, timer: timer); return }
        if centerKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: "A") }
        if leftKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: "B") }
        if rightKey.frame.contains(originFrame!) {  alphaMethod(view: view, timer: timer, st: "C") }
    }

    func dColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        views = view
        guard self.alpha == 1 else { setTitle(c: "D", l: "E", r: "F", up: "", under: "", view: views!, timer: timer); return }
        if centerKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: "D") }
        if leftKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: "E") }
        if rightKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: "F") }
    }

    func gColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        views = view
        guard self.alpha == 1 else { setTitle(c: "G", l: "H", r: "I", up: "", under: "", view: views!, timer: timer); return }
        if centerKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: "G") }
        if leftKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: "H") }
        if rightKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: "I") }
    }

    func jColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        views = view
        guard self.alpha == 1 else { setTitle(c: "J", l: "K", r: "L", up: "", under: "", view: views!, timer: timer); return }
        if centerKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: "J") }
        if leftKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: "K") }
        if rightKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: "L") }
    }

    func mColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        views = view
        guard self.alpha == 1 else { setTitle(c: "M", l: "N", r: "O", up: "", under: "", view: views!, timer: timer); return }
        if centerKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: "M") }
        if leftKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: "N") }
        if rightKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: "O") }
    }

    func pColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        views = view
        guard self.alpha == 1 else { setTitle(c: "P", l: "Q", r: "S", up: "R", under: "", view: views!, timer: timer); return }
        if centerKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: "P") }
        if leftKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: "Q") }
        if upKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: "R")}
        if rightKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: "S") }
    }

    func tColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        views = view
        guard self.alpha == 1 else { setTitle(c: "T", l: "U", r: "V", up: "", under: "", view: views!, timer: timer); return }
        if centerKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: "T") }
        if leftKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: "U") }
        if rightKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: "V") }
    }

    func wColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        views = view
        guard self.alpha == 1 else { setTitle(c: "W", l: "X", r: "Z", up: "Y", under: "", view: views!, timer: timer); return }
        if centerKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: "W") }
        if leftKey.frame.contains(originFrame!) {alphaMethod(view: view, timer: timer, st: "X") }
        if upKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: "Y") }
        if rightKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: "Z") }
    }

    func darkSpot(view: RARFLuangageKeyBoard, timer: Timer) {
        views = view
        guard self.alpha == 1 else { setTitle(c: "\'", l: "\"", r: ")", up: "(", under: "", view: views!, timer: timer); return }
        if centerKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: "\'") }
        if leftKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: "\"") }
        if rightKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: ")") }
        if upKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: "(") }
    }

    func what(view: RARFLuangageKeyBoard, timer: Timer) {
        views = view
        guard self.alpha == 1 else { setTitle(c: ".", l: ",", r: "!", up: "?", under: "", view: views!, timer: timer); return }
        if centerKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: ".") }
        if leftKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: ",") }
        if rightKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: "!") }
        if upKey.frame.contains(originFrame!) { alphaMethod(view: view, timer: timer, st: "?") }
    }
    
    func setTitle(c: String, l: String, r: String, up: String, under: String, view: RARFLuangageKeyBoard, timer: Timer) {
        selfAlpha(view: view, timer: timer)
        centerKey.setTitle(c, for: .normal)
        leftKey.setTitle(l, for: .normal)
        rightKey.setTitle(r, for: .normal)
        upKey.setTitle(up, for: .normal)
        underKey.setTitle(under, for: .normal)
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
        view.testLabel.text = texLabel
    }
}

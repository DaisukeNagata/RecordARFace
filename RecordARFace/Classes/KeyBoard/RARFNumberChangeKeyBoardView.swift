//
//  RARFNumberChangeKeyBoardView.swift
//  RecordARFace
//
//  Created by 永田大祐 on 2019/02/11.
//  Copyright © 2019 永田大祐. All rights reserved.
//

import UIKit

final class RARFNumberChangeKeyBoardView: UIView {

    @IBOutlet weak var centerKey: RARFNumberButton?
    @IBOutlet weak var leftKey: RARFNumberButton?
    @IBOutlet weak var rightKey: RARFNumberButton?
    @IBOutlet weak var upKey: RARFNumberButton?
    @IBOutlet weak var underKey: RARFNumberButton?
    @IBOutlet weak var backKey: RARFNumberButton?
    
    private var originFrame: CGRect?

    var texLabel = String()
    var rARFObject:  RARFObject?
    var views: RARFLuangageKeyBoard?

    init(ob: RARFObject) {
        super.init(frame: .zero)
        self.frame = UIScreen.main.bounds
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
        let bundle = Bundle(for: RARFNumberChangeKeyBoardView.self)
        let view = bundle.loadNibNamed("RARFNumberChangeKeyBoardView", owner: self, options: nil)?.first as! UIView
        view.frame.size.width = self.frame.width
        view.frame.size.height = self.frame.width
        self.addSubview(view)
    }
    
    func originTextField(rect: CGRect,timer: Timer) {
        originFrame = rect

        if centerKey?.title(for: .normal) == "1" { oneColumn(view: views!, timer: timer)}
        if centerKey?.title(for: .normal) == "2" { twoColumn(view: views!, timer: timer)}
        if centerKey?.title(for: .normal) == "3" { threeColumn(view: views!, timer: timer)}
        if centerKey?.title(for: .normal) == "4" { fourColumn(view: views!, timer: timer)}
        if centerKey?.title(for: .normal) == "5" { fiveColumn(view: views!, timer: timer)}
        if centerKey?.title(for: .normal) == "6" { sixColumn(view: views!, timer: timer)}
        if centerKey?.title(for: .normal) == "7" { sevenColumn(view: views!, timer: timer)}
        if centerKey?.title(for: .normal) == "8" { eightColumn(view: views!, timer: timer)}
        if centerKey?.title(for: .normal) == "9" { nineColumn(view: views!, timer: timer)}
        if centerKey?.title(for: .normal) == "('" { lowerColumn(view: views!, timer: timer)}
        if centerKey?.title(for: .normal) == "0" { zeroColumn(view: views!, timer: timer)}
        if centerKey?.title(for: .normal) == "・" { pointColumn(view: views!, timer: timer)}
    }

    func oneColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        guard self.alpha == 1, let rect = originFrame else { setTitle(c: "1", l: "☆", r: "➡︎", up: "♪", under: " ", back: "back",  view: view, timer: timer); underKey?.alpha = 0; return }
        if centerKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "1") }
        if leftKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "☆") }
        if rightKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "➡︎") }
        if upKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "♪") }
        if backKey?.frame.contains(rect) ?? false { backView(view: view, timer: timer) }
    }

    func twoColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        guard self.alpha == 1, let rect = originFrame else {  setTitle(c: "2", l: "¥", r: "€", up: "$", under: " ", back: "back", view: view, timer: timer); underKey?.alpha = 0; return }
        if centerKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "2") }
        if leftKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "¥") }
        if rightKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "€") }
        if upKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "$") }
        if backKey?.frame.contains(rect) ?? false { backView(view: view, timer: timer) }
    }

    func threeColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        guard self.alpha == 1, let rect = originFrame else { setTitle(c: "3", l: "%", r: "#", up: "。", under: " ", back: "back", view: view, timer: timer); upKey?.alpha = 0; underKey?.alpha = 0; return }
        if centerKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "3") }
        if leftKey?.frame.contains(rect) ?? false {alphaMethod(view: view, timer: timer, st: "%") }
        if rightKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "#") }
        if upKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "。") }
        if backKey?.frame.contains(rect) ?? false { backView(view: view, timer: timer) }
    }

    func fourColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        guard self.alpha == 1, let rect = originFrame else { setTitle(c: "4", l: "<", r: ">", up: "=", under: " ", back: "back", view: view, timer: timer); underKey?.alpha = 0; return }
        if centerKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "4") }
        if leftKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "<") }
        if rightKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: ">") }
        if upKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "=") }
        if backKey?.frame.contains(rect) ?? false { backView(view: view, timer: timer) }
    }

    func fiveColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        guard self.alpha == 1, let rect = originFrame else { setTitle(c: "5", l: "+", r: "÷", up: "×", under: " ", back: "back", view: view, timer: timer); underKey?.alpha = 0; return }
        if centerKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "5") }
        if leftKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "+")  }
        if rightKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "÷") }
        if upKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "×") }
        if backKey?.frame.contains(rect) ?? false { backView(view: view, timer: timer) }
    }

    func sixColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        guard self.alpha == 1, let rect = originFrame else { setTitle(c: "6", l: "<", r: ">", up: "=", under: " ", back: "back", view: view, timer: timer); underKey?.alpha = 0; return }
        if centerKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "6") }
        if leftKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "<") }
        if rightKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: ">") }
        if upKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "=") }
        if backKey?.frame.contains(rect) ?? false { backView(view: view, timer: timer) }
    }

    func sevenColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        guard self.alpha == 1, let rect = originFrame else { setTitle(c: "7", l: "「", r: ":", up: "」", under: " ", back: "back", view: view, timer: timer); underKey?.alpha = 0; return }
        if centerKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "7") }
        if leftKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "「") }
        if rightKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: ":") }
        if upKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "」") }
        if backKey?.frame.contains(rect) ?? false { backView(view: view, timer: timer) }
    }

    func eightColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        guard self.alpha == 1, let rect = originFrame else { setTitle(c: "8", l: "〒", r: "々", up: "〆", under: " ", back: "back", view: view, timer: timer); underKey?.alpha = 0; return }
        if centerKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "8") }
        if leftKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "〒") }
        if rightKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "々")  }
        if upKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "〆") }
        if backKey?.frame.contains(rect) ?? false { backView(view: view, timer: timer) }
    }

    func nineColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        guard self.alpha == 1, let rect = originFrame else { setTitle(c: "9", l: "^", r: "\\", up: "|", under: " ", back: "back",  view: view, timer: timer); underKey?.alpha = 0; return }
        if centerKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "9") }
        if leftKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "^") }
        if rightKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "\\") }
        if upKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "|") }
        if backKey?.frame.contains(rect) ?? false { backView(view: view, timer: timer) }
    }

    func lowerColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        guard self.alpha == 1, let rect = originFrame else { setTitle(c: "(", l: ")", r: "]", up: "[", under: " ", back: "back", view: view, timer: timer); underKey?.alpha = 0; return }
        if centerKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: ")") }
        if leftKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: ")") }
        if rightKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "]") }
        if upKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "[") }
        if backKey?.frame.contains(rect) ?? false { backView(view: view, timer: timer) }
    }

    func zeroColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        guard self.alpha == 1, let rect = originFrame else { setTitle(c: "0", l: "〜", r: " ", up: "…", under: " ", back: "back", view: view, timer: timer); upKey?.alpha = 0; underKey?.alpha = 0; return }
        if centerKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "0") }
        if leftKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "〜") }
        if upKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "…") }
        if backKey?.frame.contains(rect) ?? false { backView(view: view, timer: timer) }
    }

    func pointColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        guard self.alpha == 1, let rect = originFrame else { setTitle(c: "・", l: ",", r: "!", up: "?", under: " ", back: "back", view: view, timer: timer); underKey?.alpha = 0; return }
        if centerKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "・") }
        if leftKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: ",") }
        if rightKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "!") }
        if upKey?.frame.contains(rect) ?? false { alphaMethod(view: view, timer: timer, st: "?") }
        if backKey?.frame.contains(rect) ?? false { backView(view: view, timer: timer) }
    }

    func setTitle(c: String, l: String, r: String, up: String, under: String, back: String, view: RARFLuangageKeyBoard, timer: Timer) {
        selfAlpha(view: view, timer: timer)
        centerKey?.setTitle(c, for: .normal)
        leftKey?.setTitle(l, for: .normal)
        rightKey?.setTitle(r, for: .normal)
        upKey?.setTitle(up, for: .normal)
        underKey?.setTitle(under, for: .normal)
        backKey?.alpha = 1; backKey?.setTitle(back, for: .normal)
    }

    func selfAlpha(view: RARFLuangageKeyBoard,  timer: Timer) {
        timer.invalidate()
        rARFObject?.updateNumber()
        view.alpha = 0
        self.alpha = 1
    }

    func alphaMethod(view: RARFLuangageKeyBoard,timer: Timer, st: String) {
        timer.invalidate()
        rARFObject?.upDateluangageKey()
        self.centerKey?.setTitle("", for: .normal)
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

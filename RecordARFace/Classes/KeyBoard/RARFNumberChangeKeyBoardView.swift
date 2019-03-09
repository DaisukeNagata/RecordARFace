//
//  RARFNumberChangeKeyBoardView.swift
//  RecordARFace
//
//  Created by 永田大祐 on 2019/02/11.
//  Copyright © 2019 永田大祐. All rights reserved.
//

import UIKit

final class RARFNumberChangeKeyBoardView: UIView {

    @IBOutlet weak var centerKey: RARFNumberButton!
    @IBOutlet weak var leftKey: RARFNumberButton!
    @IBOutlet weak var rightKey: RARFNumberButton!
    @IBOutlet weak var upKey: RARFNumberButton!
    @IBOutlet weak var underKey: RARFNumberButton!

    var views: RARFLuangageKeyBoard?
    private var originFrame: CGRect?
    private var rARFObject:  RARFObject?


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
        originFrame!.origin.y -= UINavigationController.init().navigationBar.frame.height + UIApplication.shared.statusBarFrame.height
        if centerKey.title(for: .normal) == "1" { oneColumn(view: views!, timer: timer)}
        if centerKey.title(for: .normal) == "2" { twoColumn(view: views!, timer: timer)}
        if centerKey.title(for: .normal) == "3" { threeColumn(view: views!, timer: timer)}
        if centerKey.title(for: .normal) == "4" { fourColumn(view: views!, timer: timer)}
        if centerKey.title(for: .normal) == "5" { fiveColumn(view: views!, timer: timer)}
        if centerKey.title(for: .normal) == "6" { sixColumn(view: views!, timer: timer)}
        if centerKey.title(for: .normal) == "7" { sevenColumn(view: views!, timer: timer)}
        if centerKey.title(for: .normal) == "8" { eightColumn(view: views!, timer: timer)}
        if centerKey.title(for: .normal) == "9" { nineColumn(view: views!, timer: timer)}
        if centerKey.title(for: .normal) == "('" { darkSpotColumn(view: views!, timer: timer)}
        if centerKey.title(for: .normal) == "0" { zeroColumn(view: views!, timer: timer)}
        if centerKey.title(for: .normal) == "・" { pointColumn(view: views!, timer: timer)}
    }

    func oneColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        views = view
        if self.alpha == 0 {
            setTitle(c: "1", l: "☆", r: "➡︎", up: "", under: "♪")
            selfAlpha(view: view, timer: timer)
        } else if self.alpha == 1 {
            if self.centerKey.frame.contains(originFrame!) {
                rARFObject?.upDateluangageKey()
                alphaMethod(view: view, timer: timer, st: "1")
            } else
                if self.leftKey.frame.contains(originFrame!) {
                    rARFObject?.upDateluangageKey()
                    alphaMethod(view: view, timer: timer, st: "☆")
                } else
                    if self.rightKey.frame.contains(originFrame!) {
                        rARFObject?.upDateluangageKey()
                        alphaMethod(view: view, timer: timer, st: "➡︎")
                    } else
                        if self.upKey.frame.contains(originFrame!) {
                            rARFObject?.upDateluangageKey()
                            alphaMethod(view: view, timer: timer, st: "♪")
            }
        }
    }

    func twoColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        views = view
        if self.alpha == 0 {
            setTitle(c: "2", l: "¥", r: "€", up: "$", under: " ")
            selfAlpha(view: view, timer: timer)
        } else if self.alpha == 1 {
            if self.centerKey.frame.contains(originFrame!) {
                rARFObject?.upDateluangageKey()
                alphaMethod(view: view, timer: timer, st: "2")
            } else
                if self.leftKey.frame.contains(originFrame!) {
                    rARFObject?.upDateluangageKey()
                    alphaMethod(view: view, timer: timer, st: "¥")
                } else
                    if self.rightKey.frame.contains(originFrame!) {
                        rARFObject?.upDateluangageKey()
                        alphaMethod(view: view, timer: timer, st: "€")
                    } else
                        if self.upKey.frame.contains(originFrame!) {
                            rARFObject?.upDateluangageKey()
                            alphaMethod(view: view, timer: timer, st: "$")
            }
        }
    }

    func threeColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        views = view
        if self.alpha == 0 {
            setTitle(c: "3", l: "%", r: "#", up: "。", under: " ")
            selfAlpha(view: view, timer: timer)
        } else if self.alpha == 1 {
            if self.centerKey.frame.contains(originFrame!) {
                rARFObject?.upDateluangageKey()
                alphaMethod(view: view, timer: timer, st: "3")
            } else
                if self.leftKey.frame.contains(originFrame!) {
                    rARFObject?.upDateluangageKey()
                    alphaMethod(view: view, timer: timer, st: "%")
                } else
                    if self.rightKey.frame.contains(originFrame!) {
                        rARFObject?.upDateluangageKey()
                        alphaMethod(view: view, timer: timer, st: "#")
                    } else
                        if self.upKey.frame.contains(originFrame!) {
                            rARFObject?.upDateluangageKey()
                            alphaMethod(view: view, timer: timer, st: "。")
            }
        }
    }

    func fourColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        views = view
        if self.alpha == 0 {
            setTitle(c: "4", l: "<", r: ">", up: "=", under: " ")
            selfAlpha(view: view, timer: timer)
        } else if self.alpha == 1 {
            if self.centerKey.frame.contains(originFrame!) {
                rARFObject?.upDateluangageKey()
                alphaMethod(view: view, timer: timer, st: "4")
            } else
                if self.leftKey.frame.contains(originFrame!) {
                    rARFObject?.upDateluangageKey()
                    alphaMethod(view: view, timer: timer, st: "<")
                } else
                    if self.rightKey.frame.contains(originFrame!) {
                        rARFObject?.upDateluangageKey()
                        alphaMethod(view: view, timer: timer, st: ">")
                    } else
                        if self.upKey.frame.contains(originFrame!) {
                            rARFObject?.upDateluangageKey()
                            alphaMethod(view: view, timer: timer, st: "=")
            }
        }
    }

    func fiveColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        views = view
        if self.alpha == 0 {
            setTitle(c: "5", l: "+", r: "÷", up: "×", under: " ")
            selfAlpha(view: view, timer: timer)
        } else if self.alpha == 1 {
            if self.centerKey.frame.contains(originFrame!) {
                rARFObject?.upDateluangageKey()
                alphaMethod(view: view, timer: timer, st: "5")
            } else
                if self.leftKey.frame.contains(originFrame!) {
                    rARFObject?.upDateluangageKey()
                    alphaMethod(view: view, timer: timer, st: "+")
                } else
                    if self.rightKey.frame.contains(originFrame!) {
                        rARFObject?.upDateluangageKey()
                        alphaMethod(view: view, timer: timer, st: "÷")
                    } else
                        if self.upKey.frame.contains(originFrame!) {
                            rARFObject?.upDateluangageKey()
                            alphaMethod(view: view, timer: timer, st: "×")
            }
        }
    }

    func sixColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        views = view
        if self.alpha == 0 {
            setTitle(c: "6", l: "<", r: ">", up: "=", under: " ")
            selfAlpha(view: view, timer: timer)
        } else if self.alpha == 1 {
            if self.centerKey.frame.contains(originFrame!) {
                rARFObject?.upDateluangageKey()
                alphaMethod(view: view, timer: timer, st: "6")
            } else
                if self.leftKey.frame.contains(originFrame!) {
                    rARFObject?.upDateluangageKey()
                    alphaMethod(view: view, timer: timer, st: "<")
                } else
                    if self.rightKey.frame.contains(originFrame!) {
                        rARFObject?.upDateluangageKey()
                        alphaMethod(view: view, timer: timer, st: ">")
                    } else
                        if self.upKey.frame.contains(originFrame!) {
                            rARFObject?.upDateluangageKey()
                            alphaMethod(view: view, timer: timer, st: "=")
            }
        }
    }

    func sevenColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        views = view
        if self.alpha == 0 {
            setTitle(c: "7", l: "「", r: ":", up: "」", under: " ")
            selfAlpha(view: view, timer: timer)
        } else if self.alpha == 1 {
            if self.centerKey.frame.contains(originFrame!) {
                rARFObject?.upDateluangageKey()
                alphaMethod(view: view, timer: timer, st: "7")
            } else
                if self.leftKey.frame.contains(originFrame!) {
                    rARFObject?.upDateluangageKey()
                    alphaMethod(view: view, timer: timer, st: "「")
                } else
                    if self.rightKey.frame.contains(originFrame!) {
                        rARFObject?.upDateluangageKey()
                        alphaMethod(view: view, timer: timer, st: ":")
                    } else
                        if self.upKey.frame.contains(originFrame!) {
                            rARFObject?.upDateluangageKey()
                            alphaMethod(view: view, timer: timer, st: "」")
            }
        }
    }

    func eightColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        views = view
        if self.alpha == 0 {
            setTitle(c: "8", l: "〒", r: "々", up: "〆", under: " ")
            selfAlpha(view: view, timer: timer)
        } else if self.alpha == 1 {
            if self.centerKey.frame.contains(originFrame!) {
                rARFObject?.upDateluangageKey()
                alphaMethod(view: view, timer: timer, st: "8")
            } else
                if self.leftKey.frame.contains(originFrame!) {
                    rARFObject?.upDateluangageKey()
                    alphaMethod(view: view, timer: timer, st: "〒")
                } else
                    if self.rightKey.frame.contains(originFrame!) {
                        rARFObject?.upDateluangageKey()
                        alphaMethod(view: view, timer: timer, st: "々")
                    } else
                        if self.upKey.frame.contains(originFrame!) {
                            rARFObject?.upDateluangageKey()
                            alphaMethod(view: view, timer: timer, st: "〆")
            }
        }
    }

    func nineColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        views = view
        if self.alpha == 0 {
            setTitle(c: "9", l: "^", r: "\\", up: "|", under: " ")
            selfAlpha(view: view, timer: timer)
        } else if self.alpha == 1 {
            if self.centerKey.frame.contains(originFrame!) {
                rARFObject?.upDateluangageKey()
                alphaMethod(view: view, timer: timer, st: "9")
            } else
                if self.leftKey.frame.contains(originFrame!) {
                    rARFObject?.upDateluangageKey()
                    alphaMethod(view: view, timer: timer, st: "^")
                } else
                    if self.rightKey.frame.contains(originFrame!) {
                        rARFObject?.upDateluangageKey()
                        alphaMethod(view: view, timer: timer, st: "\\")
                    } else
                        if self.upKey.frame.contains(originFrame!) {
                            rARFObject?.upDateluangageKey()
                            alphaMethod(view: view, timer: timer, st: "|")
            }
        }
    }

    func darkSpotColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        views = view
        if self.alpha == 0 {
            setTitle(c: "(", l: ")", r: "]", up: "[", under: " ")
            selfAlpha(view: view, timer: timer)
        } else if self.alpha == 1 {
            if self.centerKey.frame.contains(originFrame!) {
                rARFObject?.upDateluangageKey()
                alphaMethod(view: view, timer: timer, st: ")")
            } else
                if self.leftKey.frame.contains(originFrame!) {
                    rARFObject?.upDateluangageKey()
                    alphaMethod(view: view, timer: timer, st: ")")
                } else
                    if self.rightKey.frame.contains(originFrame!) {
                        rARFObject?.upDateluangageKey()
                        alphaMethod(view: view, timer: timer, st: "]")
                    } else
                        if self.upKey.frame.contains(originFrame!) {
                            rARFObject?.upDateluangageKey()
                            alphaMethod(view: view, timer: timer, st: "[")
            }
        }
    }

    func zeroColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        views = view
        if self.alpha == 0 {
            setTitle(c: "0", l: "〜", r: " ", up: "…", under: " ")
            selfAlpha(view: view, timer: timer)
        } else if self.alpha == 1 {
            if self.centerKey.frame.contains(originFrame!) {
                rARFObject?.upDateluangageKey()
                alphaMethod(view: view, timer: timer, st: "0")
            } else
                if self.leftKey.frame.contains(originFrame!) {
                    rARFObject?.upDateluangageKey()
                    alphaMethod(view: view, timer: timer, st: "〜")
            } else
                if self.upKey.frame.contains(originFrame!) {
                    rARFObject?.upDateluangageKey()
                    alphaMethod(view: view, timer: timer, st: "…")
            }
        }
    }

    func pointColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        views = view
        if self.alpha == 0 {
            setTitle(c: "・", l: ",", r: "!", up: "?", under: " ")
            selfAlpha(view: view, timer: timer)
        } else if self.alpha == 1 {
            if self.centerKey.frame.contains(originFrame!) {
                rARFObject?.upDateluangageKey()
                alphaMethod(view: view, timer: timer, st: "・")
            } else
                if self.leftKey.frame.contains(originFrame!) {
                    rARFObject?.upDateluangageKey()
                    alphaMethod(view: view, timer: timer, st: ",")
                } else
                    if self.rightKey.frame.contains(originFrame!) {
                        rARFObject?.upDateluangageKey()
                        alphaMethod(view: view, timer: timer, st: "!")
                    } else
                        if self.upKey.frame.contains(originFrame!) {
                            rARFObject?.upDateluangageKey()
                            alphaMethod(view: view, timer: timer, st: "?")
            }
        }
    }

    func setTitle(c: String, l: String, r: String, up: String, under: String) {
        centerKey.setTitle(c, for: .normal)
        leftKey.setTitle(l, for: .normal)
        rightKey.setTitle(r, for: .normal)
        upKey.setTitle(up, for: .normal)
        underKey.setTitle(under, for: .normal)
    }

    func selfAlpha(view: RARFLuangageKeyBoard,  timer: Timer) {
        timer.invalidate()
        rARFObject?.updateNumber()
        view.alpha = 0
        self.alpha = 1
    }

    func alphaMethod(view: RARFLuangageKeyBoard,timer: Timer, st: String) {
        timer.invalidate()
        self.centerKey.setTitle("", for: .normal)
        self.alpha = 0
        view.alpha = 1
        view.testLabel.text = st
    }
}

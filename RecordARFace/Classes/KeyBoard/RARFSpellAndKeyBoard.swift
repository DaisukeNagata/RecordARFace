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
        if self.alpha == 0 {
            setTitle(c: "＠", l: "#", r: "&", up: "/", under: "-")
            selfAlpha(view: view, timer: timer)
        } else if self.alpha == 1 {
            if self.centerKey.frame.contains(originFrame!) {
                rARFObject?.upDateluangageKey()
                alphaMethod(view: view, timer: timer, st: "＠")
            } else
                if self.leftKey.frame.contains(originFrame!) {
                    rARFObject?.upDateluangageKey()
                    alphaMethod(view: view, timer: timer, st: "#")
                } else
                    if self.rightKey.frame.contains(originFrame!) {
                        rARFObject?.upDateluangageKey()
                        alphaMethod(view: view, timer: timer, st: "&")
                    } else
                        if self.upKey.frame.contains(originFrame!) {
                            rARFObject?.upDateluangageKey()
                            alphaMethod(view: view, timer: timer, st: "/")
                        } else
                            if self.underKey.frame.contains(originFrame!) {
                                rARFObject?.upDateluangageKey()
                                alphaMethod(view: view, timer: timer, st: "-")
            }
        }
    }

    func aColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        views = view
        if self.alpha == 0 {
            setTitle(c: "A", l: "B", r: "", up: "C", under: "")
            selfAlpha(view: view, timer: timer)
        } else if self.alpha == 1 {
            if self.centerKey.frame.contains(originFrame!) {
                rARFObject?.upDateluangageKey()
                alphaMethod(view: view, timer: timer, st: "A")
            } else
                if self.leftKey.frame.contains(originFrame!) {
                    rARFObject?.upDateluangageKey()
                    alphaMethod(view: view, timer: timer, st: "B")
                } else
                    if self.upKey.frame.contains(originFrame!) {
                        rARFObject?.upDateluangageKey()
                        alphaMethod(view: view, timer: timer, st: "C")
            }
        }
    }

    func dColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        views = view
        if self.alpha == 0 {
            setTitle(c: "D", l: "E", r: "", up: "F", under: "")
            selfAlpha(view: view, timer: timer)
        } else if self.alpha == 1 {
            if self.centerKey.frame.contains(originFrame!) {
                rARFObject?.upDateluangageKey()
                alphaMethod(view: view, timer: timer, st: "D")
            } else
                if self.leftKey.frame.contains(originFrame!) {
                    rARFObject?.upDateluangageKey()
                    alphaMethod(view: view, timer: timer, st: "E")
                } else
                    if self.upKey.frame.contains(originFrame!) {
                        rARFObject?.upDateluangageKey()
                        alphaMethod(view: view, timer: timer, st: "F")
            }
        }
    }

    func gColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        views = view
        if self.alpha == 0 {
            setTitle(c: "G", l: "H", r: "", up: "I", under: "")
            selfAlpha(view: view, timer: timer)
        } else if self.alpha == 1 {
            if self.centerKey.frame.contains(originFrame!) {
                rARFObject?.upDateluangageKey()
                alphaMethod(view: view, timer: timer, st: "G")
            } else
                if self.leftKey.frame.contains(originFrame!) {
                    rARFObject?.upDateluangageKey()
                    alphaMethod(view: view, timer: timer, st: "H")
                } else
                    if self.upKey.frame.contains(originFrame!) {
                        rARFObject?.upDateluangageKey()
                        alphaMethod(view: view, timer: timer, st: "I")
            }
        }
    }

    func jColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        views = view
        if self.alpha == 0 {
            setTitle(c: "J", l: "K", r: "", up: "L", under: "")
            selfAlpha(view: view, timer: timer)
        } else if self.alpha == 1 {
            if self.centerKey.frame.contains(originFrame!) {
                rARFObject?.upDateluangageKey()
                alphaMethod(view: view, timer: timer, st: "J")
            } else
                if self.leftKey.frame.contains(originFrame!) {
                    rARFObject?.upDateluangageKey()
                    alphaMethod(view: view, timer: timer, st: "K")
                } else
                    if self.upKey.frame.contains(originFrame!) {
                        rARFObject?.upDateluangageKey()
                        alphaMethod(view: view, timer: timer, st: "L")
            }
        }
    }

    func mColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        views = view
        if self.alpha == 0 {
            setTitle(c: "M", l: "N", r: "", up: "O", under: "")
            selfAlpha(view: view, timer: timer)
        } else if self.alpha == 1 {
            if self.centerKey.frame.contains(originFrame!) {
                rARFObject?.upDateluangageKey()
                alphaMethod(view: view, timer: timer, st: "M")
            } else
                if self.leftKey.frame.contains(originFrame!) {
                    rARFObject?.upDateluangageKey()
                    alphaMethod(view: view, timer: timer, st: "N")
                } else
                    if self.upKey.frame.contains(originFrame!) {
                        rARFObject?.upDateluangageKey()
                        alphaMethod(view: view, timer: timer, st: "O")
            }
        }
    }

    func pColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        views = view
        if self.alpha == 0 {
            setTitle(c: "P", l: "Q", r: "S", up: "R", under: "")
            selfAlpha(view: view, timer: timer)
        } else if self.alpha == 1 {
            if self.centerKey.frame.contains(originFrame!) {
                rARFObject?.upDateluangageKey()
                alphaMethod(view: view, timer: timer, st: "P")
            } else
                if self.leftKey.frame.contains(originFrame!) {
                    rARFObject?.upDateluangageKey()
                    alphaMethod(view: view, timer: timer, st: "Q")
                } else
                    if self.upKey.frame.contains(originFrame!) {
                        rARFObject?.upDateluangageKey()
                        alphaMethod(view: view, timer: timer, st: "R")

                    } else
                        if self.rightKey.frame.contains(originFrame!) {
                            rARFObject?.upDateluangageKey()
                            alphaMethod(view: view, timer: timer, st: "S")
            }
        }
    }

    func tColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        views = view
        if self.alpha == 0 {
            setTitle(c: "T", l: "U", r: "", up: "V", under: "")
            selfAlpha(view: view, timer: timer)
        } else if self.alpha == 1 {
            if self.centerKey.frame.contains(originFrame!) {
                rARFObject?.upDateluangageKey()
                alphaMethod(view: view, timer: timer, st: "T")
            } else
                if self.leftKey.frame.contains(originFrame!) {
                    rARFObject?.upDateluangageKey()
                    alphaMethod(view: view, timer: timer, st: "U")
                } else
                    if self.upKey.frame.contains(originFrame!) {
                        rARFObject?.upDateluangageKey()
                        alphaMethod(view: view, timer: timer, st: "V")
            }
        }
    }

    func wColumn(view: RARFLuangageKeyBoard, timer: Timer) {
        views = view
        if self.alpha == 0 {
            setTitle(c: "W", l: "X", r: "Z", up: "Y", under: "")
            selfAlpha(view: view, timer: timer)
        } else if self.alpha == 1 {
            if self.centerKey.frame.contains(originFrame!) {
                rARFObject?.upDateluangageKey()
                alphaMethod(view: view, timer: timer, st: "W")
            } else
                if self.leftKey.frame.contains(originFrame!) {
                    rARFObject?.upDateluangageKey()
                    alphaMethod(view: view, timer: timer, st: "X")
                } else
                    if self.upKey.frame.contains(originFrame!) {
                        rARFObject?.upDateluangageKey()
                        alphaMethod(view: view, timer: timer, st: "Y")
                    } else
                        if self.rightKey.frame.contains(originFrame!) {
                            rARFObject?.upDateluangageKey()
                            alphaMethod(view: view, timer: timer, st: "Z")
                            
            }
        }
    }

    func darkSpot(view: RARFLuangageKeyBoard, timer: Timer) {
        views = view
        if self.alpha == 0 {
            setTitle(c: "\'", l: "\"", r: ")", up: "(", under: "")
            selfAlpha(view: view, timer: timer)
        } else if self.alpha == 1 {
            if self.centerKey.frame.contains(originFrame!) {
                rARFObject?.upDateluangageKey()
                alphaMethod(view: view, timer: timer, st: "\'")
            } else
                if self.leftKey.frame.contains(originFrame!) {
                    rARFObject?.upDateluangageKey()
                    alphaMethod(view: view, timer: timer, st: "\"")
                } else
                    if self.upKey.frame.contains(originFrame!) {
                        rARFObject?.upDateluangageKey()
                        alphaMethod(view: view, timer: timer, st: ")")
                    } else
                        if self.upKey.frame.contains(originFrame!) {
                            rARFObject?.upDateluangageKey()
                            alphaMethod(view: view, timer: timer, st: "(")
            }
        }
    }

    func what(view: RARFLuangageKeyBoard, timer: Timer) {
        views = view
        if self.alpha == 0 {
            setTitle(c: ".", l: ",", r: "!", up: "?", under: "")
            selfAlpha(view: view, timer: timer)
        } else if self.alpha == 1 {
            if self.centerKey.frame.contains(originFrame!) {
                rARFObject?.upDateluangageKey()
                alphaMethod(view: view, timer: timer, st: ".")
            } else
                if self.leftKey.frame.contains(originFrame!) {
                    rARFObject?.upDateluangageKey()
                    alphaMethod(view: view, timer: timer, st: ",")
                } else
                    if self.upKey.frame.contains(originFrame!) {
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
        rARFObject?.updateSpellKey()
        view.alpha = 0
        self.alpha = 1
    }

    func alphaMethod(view: RARFLuangageKeyBoard,timer: Timer, st: String) {
        timer.invalidate()
        self.centerKey.setTitle("", for: .normal)
        self.alpha = 0
        view.alpha = 1
        texLabel += st
        view.testLabel.text = texLabel
    }
}

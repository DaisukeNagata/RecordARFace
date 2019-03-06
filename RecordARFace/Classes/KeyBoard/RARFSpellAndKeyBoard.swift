//
//  RARFSpellAndKeyBoard.swift
//  SampleKeyBoard
//
//  Created by 永田大祐 on 2019/02/07.
//  Copyright © 2019 永田大祐. All rights reserved.
//

import UIKit

struct Global { static var texFlg = false }

final class RARFSpellAndKeyBoard: UIView {

    var originFrame: CGRect?
    var views: RARFLuangageKeyBoard?

    @IBOutlet weak var upKey: RARFNumberButton!
    @IBOutlet weak var centerKey: RARFNumberButton!
    @IBOutlet weak var underKey: RARFNumberButton!
    @IBOutlet weak var rightKey: RARFNumberButton!
    @IBOutlet weak var leftKey: RARFNumberButton!

    private var keyValueObservations = [NSKeyValueObservation]()
     private var keyValueObservations2 = [NSKeyValueObservation]()

   override init(frame: CGRect) {
        super.init(frame: .zero)
        self.frame = UIScreen.main.bounds
        loadNib()
        self.alpha = 0
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }

    func loadNib() {
        let bundle = Bundle(for: RARFSpellAndKeyBoard.self)
        let view = bundle.loadNibNamed("RARFSpellAndKeyBoard", owner: self, options: nil)?.first as! UIView
        view.frame.size.width = self.frame.width
        view.frame.size.height = self.frame.width
        self.addSubview(view)
    }
    
    func originTextField(rect: CGRect,timer: Timer) {
        originFrame = rect
        originFrame!.origin.y -= UINavigationController.init().navigationBar.frame.height + UIApplication.shared.statusBarFrame.height
        if centerKey.title(for: .normal) == "＠" { symbol(view: views!)}
        if centerKey.title(for: .normal) == "A" { aColumn(view: views!)}
        if centerKey.title(for: .normal) == "D" { dColumn(view: views!)}
        if centerKey.title(for: .normal) == "G" { gColumn(view: views!)}
        if centerKey.title(for: .normal) == "J" { jColumn(view: views!)}
        if centerKey.title(for: .normal) == "M" { mColumn(view: views!)}
        if centerKey.title(for: .normal) == "P" { pColumn(view: views!)}
        if centerKey.title(for: .normal) == "T" { tColumn(view: views!)}
        if centerKey.title(for: .normal) == "W" { wColumn(view: views!)}
        if centerKey.title(for: .normal) == "\'" { darkSpot(view: views!)}
        if centerKey.title(for: .normal) == "." { what(view: views!)}
    }

    func symbol(view: RARFLuangageKeyBoard) {
        views = view
        if originFrame != nil  {
            if self.alpha == 0 {
                self.centerKey.setTitle("＠", for: .normal)
                self.leftKey.setTitle("#", for: .normal)
                self.rightKey.setTitle("&", for: .normal)
                self.upKey.setTitle("/", for: .normal)
                self.underKey.setTitle("-", for: .normal)
                self.alpha = 1
                view.alpha = 1
                view.flg = true
            } else if self.alpha == 1 {
                if self.centerKey.frame.contains(originFrame!) {
                    self.centerKey.setTitle("", for: .normal)
                    self.alpha = 0
                    view.alpha = 1
                    view.testLabel.text = "＠"
                    view.flg = false
                } else
                    if self.leftKey.frame.contains(originFrame!) {
                        alphaMetthod()
                        view.testLabel.text = "#"
                    } else
                        if self.upKey.frame.contains(originFrame!) {
                            alphaMetthod()
                            view.testLabel.text = "&"
                        } else
                            if self.upKey.frame.contains(originFrame!) {
                                alphaMetthod()
                                view.testLabel.text = "/"
                            } else
                                if self.upKey.frame.contains(originFrame!) {
                                    alphaMetthod()
                                    view.testLabel.text = "/"
                }
            }
        }
    }
    func aColumn(view: RARFLuangageKeyBoard) {
        views = view
        if originFrame != nil  {
            if self.alpha == 0 {
                self.centerKey.setTitle("A", for: .normal)
                self.leftKey.setTitle("B", for: .normal)
                self.upKey.setTitle("C", for: .normal)
                self.rightKey.alpha = 0
                self.underKey.alpha = 0
                self.alpha = 1
                view.alpha = 1
                view.flg = true
            } else if self.alpha == 1 {
                if self.centerKey.frame.contains(originFrame!) {
                    alphaMetthod()
                    view.testLabel.text = "A"
                } else
                    if self.leftKey.frame.contains(originFrame!) {
                        alphaMetthod()
                        view.testLabel.text = "B"
                    } else
                        if self.upKey.frame.contains(originFrame!) {
                            alphaMetthod()
                            view.testLabel.text = "C"
                }
            }
        }
    }

    func dColumn(view: RARFLuangageKeyBoard) {
        views = view
        if originFrame != nil  {
            if self.alpha == 0 {
                self.centerKey.setTitle("D", for: .normal)
                self.leftKey.setTitle("E", for: .normal)
                self.upKey.setTitle("F", for: .normal)
                self.rightKey.alpha = 0
                self.underKey.alpha = 0
                self.alpha = 1
                view.alpha = 1
                view.flg = true
            } else if self.alpha == 1 {
                if self.centerKey.frame.contains(originFrame!) {
                    alphaMetthod()
                    view.testLabel.text = "D"
                } else
                    if self.leftKey.frame.contains(originFrame!) {
                        alphaMetthod()
                        view.testLabel.text = "E"
                    } else
                        if self.upKey.frame.contains(originFrame!) {
                            alphaMetthod()
                            view.testLabel.text = "F"
                }
            }
        }
    }
    
    func gColumn(view: RARFLuangageKeyBoard) {
        views = view
        if originFrame != nil  {
            if self.alpha == 0 {
                self.centerKey.setTitle("G", for: .normal)
                self.leftKey.setTitle("H", for: .normal)
                self.upKey.setTitle("I", for: .normal)
                self.rightKey.alpha = 0
                self.underKey.alpha = 0
                self.alpha = 1
                view.alpha = 1
                view.flg = true
            } else if self.alpha == 1 {
                if self.centerKey.frame.contains(originFrame!) {
                    alphaMetthod()
                    view.testLabel.text = "G"
                } else
                    if self.leftKey.frame.contains(originFrame!) {
                        alphaMetthod()
                        view.testLabel.text = "H"
                    } else
                        if self.upKey.frame.contains(originFrame!) {
                            alphaMetthod()
                            view.testLabel.text = "I"
                }
            }
        }
    }
    
    func jColumn(view: RARFLuangageKeyBoard) {
        views = view
        if originFrame != nil  {
            if self.alpha == 0 {
                self.centerKey.setTitle("J", for: .normal)
                self.leftKey.setTitle("K", for: .normal)
                self.upKey.setTitle("L", for: .normal)
                self.rightKey.alpha = 0
                self.underKey.alpha = 0
                self.alpha = 1
                view.alpha = 1
                view.flg = true
            } else if self.alpha == 1 {
                if self.centerKey.frame.contains(originFrame!) {
                    alphaMetthod()
                    view.testLabel.text = "J"
                } else
                    if self.leftKey.frame.contains(originFrame!) {
                        alphaMetthod()
                        view.testLabel.text = "K"
                    } else
                        if self.upKey.frame.contains(originFrame!) {
                            alphaMetthod()
                            view.testLabel.text = "L"
                }
            }
        }
    }
    
    func mColumn(view: RARFLuangageKeyBoard) {
        views = view
        if originFrame != nil  {
            if self.alpha == 0 {
                self.centerKey.setTitle("M", for: .normal)
                self.leftKey.setTitle("N", for: .normal)
                self.upKey.setTitle("O", for: .normal)
                self.rightKey.alpha = 0
                self.underKey.alpha = 0
                self.alpha = 1
                view.alpha = 1
                view.flg = true
            } else if self.alpha == 1 {
                if self.centerKey.frame.contains(originFrame!) {
                    alphaMetthod()
                    view.testLabel.text = "M"
                } else
                    if self.leftKey.frame.contains(originFrame!) {
                        alphaMetthod()
                        view.testLabel.text = "N"
                    } else
                        if self.upKey.frame.contains(originFrame!) {
                            alphaMetthod()
                            view.testLabel.text = "O"
                }
            }
        }
    }
    
    func pColumn(view: RARFLuangageKeyBoard) {
        views = view
        if originFrame != nil  {
            if self.alpha == 0 {
                centerKey.setTitle("P", for: .normal)
                leftKey.setTitle("Q", for: .normal)
                upKey.setTitle("R", for: .normal)
                rightKey.setTitle("S", for: .normal)
                self.underKey.alpha = 0
                self.alpha = 1
                view.alpha = 1
                view.flg = true
            } else if self.alpha == 1 {
                if self.centerKey.frame.contains(originFrame!) {
                    alphaMetthod()
                    view.testLabel.text = "P"
                } else
                    if self.leftKey.frame.contains(originFrame!) {
                        alphaMetthod()
                        view.testLabel.text = "Q"
                    } else
                        if self.upKey.frame.contains(originFrame!) {
                            alphaMetthod()
                            view.testLabel.text = "R"
                        } else
                            if self.rightKey.frame.contains(originFrame!) {
                                alphaMetthod()
                                view.testLabel.text = "S"
                }
            }
        }
    }
    func tColumn(view: RARFLuangageKeyBoard) {
        views = view
        if originFrame != nil  {
            if self.alpha == 0 {
                self.centerKey.setTitle("T", for: .normal)
                self.leftKey.setTitle("U", for: .normal)
                self.upKey.setTitle("V", for: .normal)
                self.rightKey.alpha = 0
                self.underKey.alpha = 0
                self.alpha = 1
                view.alpha = 1
                view.flg = true
            } else if self.alpha == 1 {
                if self.centerKey.frame.contains(originFrame!) {
                    alphaMetthod()
                    view.testLabel.text = "T"
                } else
                    if self.leftKey.frame.contains(originFrame!) {
                        alphaMetthod()
                        view.testLabel.text = "U"
                    } else
                        if self.upKey.frame.contains(originFrame!) {
                            alphaMetthod()
                            view.testLabel.text = "V"
                }
            }
        }
    }

    func wColumn(view: RARFLuangageKeyBoard) {
        views = view
        if originFrame != nil  {
            if self.alpha == 0 {
                self.centerKey.setTitle("W", for: .normal)
                self.leftKey.setTitle("X", for: .normal)
                self.upKey.setTitle("Y", for: .normal)
                rightKey.setTitle("Z", for: .normal)
                self.underKey.alpha = 0
                self.alpha = 1
                view.alpha = 1
                view.flg = true
            } else if self.alpha == 1 {
                if self.centerKey.frame.contains(originFrame!) {
                    alphaMetthod()
                    view.testLabel.text = "W"
                } else
                    if self.leftKey.frame.contains(originFrame!) {
                        alphaMetthod()
                        view.testLabel.text = "X"
                    } else
                        if self.upKey.frame.contains(originFrame!) {
                            alphaMetthod()
                            view.testLabel.text = "Y"
                        } else
                            if self.upKey.frame.contains(originFrame!) {
                                alphaMetthod()
                                view.testLabel.text = "Z"

                }
            }
        }
    }

    func darkSpot(view: RARFLuangageKeyBoard) {
        views = view
        if originFrame != nil  {
            if self.alpha == 0 {
                centerKey.setTitle("\'", for: .normal)
                leftKey.setTitle("\"", for: .normal)
                rightKey.setTitle(")", for: .normal)
                upKey.setTitle("(", for: .normal)
                self.underKey.alpha = 0
                self.alpha = 1
                view.alpha = 1
                view.flg = true
            } else if self.alpha == 1 {
                if self.centerKey.frame.contains(originFrame!) {
                    alphaMetthod()
                    view.testLabel.text = "\'"
                } else
                    if self.leftKey.frame.contains(originFrame!) {
                        alphaMetthod()
                        view.testLabel.text = "\""
                    } else
                        if self.upKey.frame.contains(originFrame!) {
                            alphaMetthod()
                            view.testLabel.text = ")"
                        } else
                            if self.upKey.frame.contains(originFrame!) {
                                alphaMetthod()
                                view.testLabel.text = "("
                }
            }
        }
    }

    func what(view: RARFLuangageKeyBoard) {
        views = view
        if originFrame != nil  {
            if self.alpha == 0 {
                centerKey.setTitle(".", for: .normal)
                leftKey.setTitle(",", for: .normal)
                rightKey.setTitle("!", for: .normal)
                upKey.setTitle("?", for: .normal)
                self.underKey.alpha = 0
                self.alpha = 1
                view.alpha = 1
                view.flg = true
            } else if self.alpha == 1 {
                if self.centerKey.frame.contains(originFrame!) {
                    alphaMetthod()
                    view.testLabel.text = "."
                } else
                    if self.leftKey.frame.contains(originFrame!) {
                        alphaMetthod()
                        view.testLabel.text = ","
                    } else
                        if self.upKey.frame.contains(originFrame!) {
                            alphaMetthod()
                            view.testLabel.text = "!"
                        } else
                            if self.upKey.frame.contains(originFrame!) {
                                alphaMetthod()
                                view.testLabel.text = "?"
                }
            }
        }
    }
    
    func alphaMetthod() {
        self.centerKey.setTitle("", for: .normal)
        views!.alpha = 1
        self.alpha = 0
        views!.flg = false
    }
}

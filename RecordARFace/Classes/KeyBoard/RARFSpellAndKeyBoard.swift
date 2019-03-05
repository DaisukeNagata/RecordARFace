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
        removeKVO()
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
        if centerKey.title(for: .normal) == "＠" { symbol(rect: originFrame!) }
        if centerKey.title(for: .normal) == "A" { aColumn(view: views!)}
        if centerKey.title(for: .normal) == "D" { dColumn(rect: originFrame!) }
    }

    func symbol(rect: CGRect) {
        if self.alpha == 1 {
            self.centerKey.setTitle("", for: .normal)
            if self.centerKey.frame.contains(rect) {
                print("＠")
            }
            if self.leftKey.frame.contains(rect) {
                print("#")
            }
            if self.rightKey.frame.contains(rect) {
                print("&")
            }
            if self.upKey.frame.contains(rect) {
                print("/")
            }
            if self.underKey.frame.contains(rect) {
                print("-")
                
            }
        } else if self.alpha == 0 {
            UIView.animate(withDuration: 0.4) {
                self.centerKey.setTitle("＠", for: .normal)
                self.leftKey.setTitle("#", for: .normal)
                self.rightKey.setTitle("&", for: .normal)
                self.upKey.setTitle("/", for: .normal)
                self.underKey.setTitle("-", for: .normal)
                self.alpha = 1
            }
        }
    }
    // TODO: Logic
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
                    self.centerKey.setTitle("", for: .normal)
                    print("A")
                    self.alpha = 0
                    view.alpha = 1
                    view.testLabel.text = "A"
                    view.flg = false
                } else
                if self.leftKey.frame.contains(originFrame!) {
                    self.centerKey.setTitle("", for: .normal)
                    print("B")
                    self.alpha = 0
                    view.alpha = 1
                    view.testLabel.text = "B"
                    view.flg = false
                } else
                if self.upKey.frame.contains(originFrame!) {
                    self.centerKey.setTitle("", for: .normal)
                    print("C")
                    view.alpha = 1
                    self.alpha = 0
                    view.testLabel.text = "C"
                    view.flg = false
                }
            }
        }
    }


    func dColumn(rect: CGRect) {
        if self.alpha == 1 {
            self.centerKey.setTitle("", for: .normal)
            if self.centerKey.frame.contains(rect) {
                print("D")
            }
            if self.leftKey.frame.contains(rect) {
                print("E")
            }
            if self.upKey.frame.contains(rect) {
                print("F")
            }
        } else if self.alpha == 0 {
            UIView.animate(withDuration: 0.4) {
                self.centerKey.setTitle("D", for: .normal)
                self.leftKey.setTitle("E", for: .normal)
                self.upKey.setTitle("F", for: .normal)
                self.rightKey.alpha = 0
                self.underKey.alpha = 0
                self.alpha = 1
            }
        }
    }
    
    func gColumn(view: UIView) {
        //        view.alpha = 0
        //        centerKey.setTitle("G", for: .normal)
        //        leftKey.setTitle("H", for: .normal)
        //        upKey.setTitle("|", for: .normal)
        //
        //        centerKey.addTarget(self, action: #selector(gTexcallBack), for: .touchUpInside)
        //        leftKey.addTarget(self, action: #selector(HTexcallBack), for: .touchUpInside)
        //        upKey.addTarget(self, action: #selector(extraTexcallBack), for: .touchUpInside)
        //
        //        UIView.animate(withDuration: 0.4) {
        //            self.rightKey.alpha = 0
        //            self.underKey.alpha = 0
        //            self.alpha = 1.0
        //        }
    }
    
    func jColumn(view: UIView) {
        //        view.alpha = 0
        //        centerKey.setTitle("J", for: .normal)
        //        leftKey.setTitle("K", for: .normal)
        //        upKey.setTitle("L", for: .normal)
        //
        //        centerKey.addTarget(self, action: #selector(jTexcallBack), for: .touchUpInside)
        //        leftKey.addTarget(self, action: #selector(kTexcallBack), for: .touchUpInside)
        //        upKey.addTarget(self, action: #selector(lxtraTexcallBack), for: .touchUpInside)
        //
        //        UIView.animate(withDuration: 0.4) {
        //            self.rightKey.alpha = 0
        //            self.underKey.alpha = 0
        //            self.alpha = 1.0
        //        }
    }
    
    func mColumn(view: UIView) {
        //        view.alpha = 0
        //        centerKey.setTitle("M", for: .normal)
        //        leftKey.setTitle("N", for: .normal)
        //        upKey.setTitle("O", for: .normal)
        //
        //        centerKey.addTarget(self, action: #selector(mTexcallBack), for: .touchUpInside)
        //        leftKey.addTarget(self, action: #selector(kTexcallBack), for: .touchUpInside)
        //        upKey.addTarget(self, action: #selector(oTexcallBack), for: .touchUpInside)
        //
        //        UIView.animate(withDuration: 0.4) {
        //            self.rightKey.alpha = 0
        //            self.underKey.alpha = 0
        //            self.alpha = 1.0
        //        }
    }
    
    func pColumn(view: UIView) {
        //        view.alpha = 0
        //        centerKey.setTitle("P", for: .normal)
        //        leftKey.setTitle("Q", for: .normal)
        //        upKey.setTitle("R", for: .normal)
        //        rightKey.setTitle("S", for: .normal)
        //
        //        centerKey.addTarget(self, action: #selector(pTexcallBack), for: .touchUpInside)
        //        leftKey.addTarget(self, action: #selector(qTexcallBack), for: .touchUpInside)
        //        upKey.addTarget(self, action: #selector(rTexcallBack), for: .touchUpInside)
        //        rightKey.addTarget(self, action: #selector(sTexcallBack), for: .touchUpInside)
        //
        //
        //        UIView.animate(withDuration: 0.4) {
        //            self.underKey.alpha = 0
        //            self.alpha = 1.0
        //        }
    }
    
    func tColumn(view: UIView) {
        //        view.alpha = 0
        //        centerKey.setTitle("T", for: .normal)
        //        leftKey.setTitle("U", for: .normal)
        //        upKey.setTitle("V", for: .normal)
        //
        //        centerKey.addTarget(self, action: #selector(tTexcallBack), for: .touchUpInside)
        //        leftKey.addTarget(self, action: #selector(uTexcallBack), for: .touchUpInside)
        //        upKey.addTarget(self, action: #selector(vTexcallBack), for: .touchUpInside)
        //
        //        UIView.animate(withDuration: 0.4) {
        //            self.rightKey.alpha = 0
        //            self.underKey.alpha = 0
        //            self.alpha = 1.0
        //        }
    }

    func wColumn(view: UIView) {
//        view.alpha = 0
//        centerKey.setTitle("W", for: .normal)
//        leftKey.setTitle("X", for: .normal)
//        upKey.setTitle("Y", for: .normal)
//        rightKey.setTitle("Z", for: .normal)
//
//        centerKey.addTarget(self, action: #selector(wTexcallBack), for: .touchUpInside)
//        leftKey.addTarget(self, action: #selector(xTexcallBack), for: .touchUpInside)
//        rightKey.addTarget(self, action: #selector(zTexcallBack), for: .touchUpInside)
//        upKey.addTarget(self, action: #selector(yTexcallBack), for: .touchUpInside)
//
//        UIView.animate(withDuration: 0.4) {
//            self.underKey.alpha = 0
//            self.alpha = 1.0
//        }
    }

    func darkSpot(view: UIView) {
//        view.alpha = 0
//        centerKey.setTitle("\'", for: .normal)
//        leftKey.setTitle("\"", for: .normal)
//        rightKey.setTitle(")", for: .normal)
//        upKey.setTitle("(", for: .normal)
//
//        centerKey.addTarget(self, action: #selector(quotation), for: .touchUpInside)
//        leftKey.addTarget(self, action: #selector(doubleQuotation), for: .touchUpInside)
//        rightKey.addTarget(self, action: #selector(rightBrackets), for: .touchUpInside)
//        upKey.addTarget(self, action: #selector(rightBrackets), for: .touchUpInside)
//
//        UIView.animate(withDuration: 0.4) {
//            self.underKey.alpha = 0
//            self.alpha = 1.0
//        }
    }

    func what(view: UIView) {
//        view.alpha = 0
//        centerKey.setTitle(".", for: .normal)
//        leftKey.setTitle(",", for: .normal)
//        rightKey.setTitle("!", for: .normal)
//        upKey.setTitle("?", for: .normal)
//
//        centerKey.addTarget(self, action: #selector(colon), for: .touchUpInside)
//        leftKey.addTarget(self, action: #selector(spot), for: .touchUpInside)
//        rightKey.addTarget(self, action: #selector(exclamation), for: .touchUpInside)
//        upKey.addTarget(self, action: #selector(doubt), for: .touchUpInside)
//
//        UIView.animate(withDuration: 0.4) {
//            self.underKey.alpha = 0
//            self.alpha = 1.0
//        }
    }

    func texConversion() {
        if Global.texFlg == false {
            Global.texFlg = true
        } else {
            Global.texFlg = false
        }
    }

    func addKVO(view: RARFSpellAndKeyBoard, _ closure: @escaping ()->Void)  {
        let keyValueObservation = self.observe(\.alpha, options: [.new, .old])
        { _, change in
            if change.newValue == nil  { return }
            closure()
        }
        keyValueObservations.append(keyValueObservation)
    }

    private func removeKVO() {
        for keyValueObservation in keyValueObservations { keyValueObservation.invalidate() }
        keyValueObservations.removeAll()
    }
}

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
    var flg = false
    @IBOutlet weak var upKey: RARFNumberButton!
    @IBOutlet weak var centerKey: RARFNumberButton!
    @IBOutlet weak var underKey: RARFNumberButton!
    @IBOutlet weak var rightKey: RARFNumberButton!
    @IBOutlet weak var leftKey: RARFNumberButton!

    private var keyValueObservations = [NSKeyValueObservation]()


    override init(frame: CGRect) {
        super.init(frame: frame)
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

    func symbol(view: UIView) {
        view.alpha = 0
        centerKey.setTitle("＠", for: .normal)
        leftKey.setTitle("#", for: .normal)
        rightKey.setTitle("&", for: .normal)
        upKey.setTitle("/", for: .normal)
        underKey.setTitle("-", for: .normal)

        centerKey.addTarget(self, action: #selector(at), for: .touchUpInside)
        leftKey.addTarget(self, action: #selector(sharp), for: .touchUpInside)
        upKey.addTarget(self, action: #selector(and), for: .touchUpInside)
        rightKey.addTarget(self, action: #selector(slash), for: .touchUpInside)
        underKey.addTarget(self, action: #selector(hyphen), for: .touchUpInside)

        UIView.animate(withDuration: 0.4) {
            self.alpha = 1.0
        }
    }

    func aColumn(view: UIView, rect: CGRect) {
       
        if flg == false {
            flg = true
            centerKey.setTitle("A", for: .normal)
            leftKey.setTitle("B", for: .normal)
            upKey.setTitle("C", for: .normal)
            view.alpha = 0
            UIView.animate(withDuration: 0.4) {
                self.rightKey.alpha = 0
                self.underKey.alpha = 0
                self.alpha = 1.0
            }
        }
        if self.centerKey.frame.contains(rect) {
            print("A")
        }
        if self.leftKey.frame.contains(rect) {
            print("B")
        }
        if self.upKey.frame.contains(rect) {
            print("C")
        }
    }

    func dColumn(view: UIView) {
        view.alpha = 0
        centerKey.setTitle("D", for: .normal)
        leftKey.setTitle("E", for: .normal)
        upKey.setTitle("F", for: .normal)

        centerKey.addTarget(self, action: #selector(dTexcallBack), for: .touchUpInside)
        leftKey.addTarget(self, action: #selector(eTexcallBack), for: .touchUpInside)
        upKey.addTarget(self, action: #selector(fTexcallBack), for: .touchUpInside)

        UIView.animate(withDuration: 0.4) {
            self.rightKey.alpha = 0
            self.underKey.alpha = 0
            self.alpha = 1.0
        }
    }

    func gColumn(view: UIView) {
        view.alpha = 0
        centerKey.setTitle("G", for: .normal)
        leftKey.setTitle("H", for: .normal)
        upKey.setTitle("|", for: .normal)

        centerKey.addTarget(self, action: #selector(gTexcallBack), for: .touchUpInside)
        leftKey.addTarget(self, action: #selector(HTexcallBack), for: .touchUpInside)
        upKey.addTarget(self, action: #selector(extraTexcallBack), for: .touchUpInside)

        UIView.animate(withDuration: 0.4) {
            self.rightKey.alpha = 0
            self.underKey.alpha = 0
            self.alpha = 1.0
        }
    }

    func jColumn(view: UIView) {
        view.alpha = 0
        centerKey.setTitle("J", for: .normal)
        leftKey.setTitle("K", for: .normal)
        upKey.setTitle("L", for: .normal)

        centerKey.addTarget(self, action: #selector(jTexcallBack), for: .touchUpInside)
        leftKey.addTarget(self, action: #selector(kTexcallBack), for: .touchUpInside)
        upKey.addTarget(self, action: #selector(lxtraTexcallBack), for: .touchUpInside)

        UIView.animate(withDuration: 0.4) {
            self.rightKey.alpha = 0
            self.underKey.alpha = 0
            self.alpha = 1.0
        }
    }

    func mColumn(view: UIView) {
        view.alpha = 0
        centerKey.setTitle("M", for: .normal)
        leftKey.setTitle("N", for: .normal)
        upKey.setTitle("O", for: .normal)

        centerKey.addTarget(self, action: #selector(mTexcallBack), for: .touchUpInside)
        leftKey.addTarget(self, action: #selector(kTexcallBack), for: .touchUpInside)
        upKey.addTarget(self, action: #selector(oTexcallBack), for: .touchUpInside)

        UIView.animate(withDuration: 0.4) {
            self.rightKey.alpha = 0
            self.underKey.alpha = 0
            self.alpha = 1.0
        }
    }

    func pColumn(view: UIView) {
        view.alpha = 0
        centerKey.setTitle("P", for: .normal)
        leftKey.setTitle("Q", for: .normal)
        upKey.setTitle("R", for: .normal)
        rightKey.setTitle("S", for: .normal)

        centerKey.addTarget(self, action: #selector(pTexcallBack), for: .touchUpInside)
        leftKey.addTarget(self, action: #selector(qTexcallBack), for: .touchUpInside)
        upKey.addTarget(self, action: #selector(rTexcallBack), for: .touchUpInside)
        rightKey.addTarget(self, action: #selector(sTexcallBack), for: .touchUpInside)


        UIView.animate(withDuration: 0.4) {
            self.underKey.alpha = 0
            self.alpha = 1.0
        }
    }

    func tColumn(view: UIView) {
        view.alpha = 0
        centerKey.setTitle("T", for: .normal)
        leftKey.setTitle("U", for: .normal)
        upKey.setTitle("V", for: .normal)

        centerKey.addTarget(self, action: #selector(tTexcallBack), for: .touchUpInside)
        leftKey.addTarget(self, action: #selector(uTexcallBack), for: .touchUpInside)
        upKey.addTarget(self, action: #selector(vTexcallBack), for: .touchUpInside)

        UIView.animate(withDuration: 0.4) {
            self.rightKey.alpha = 0
            self.underKey.alpha = 0
            self.alpha = 1.0
        }
    }

    func wColumn(view: UIView) {
        view.alpha = 0
        centerKey.setTitle("W", for: .normal)
        leftKey.setTitle("X", for: .normal)
        upKey.setTitle("Y", for: .normal)
        rightKey.setTitle("Z", for: .normal)

        centerKey.addTarget(self, action: #selector(wTexcallBack), for: .touchUpInside)
        leftKey.addTarget(self, action: #selector(xTexcallBack), for: .touchUpInside)
        rightKey.addTarget(self, action: #selector(zTexcallBack), for: .touchUpInside)
        upKey.addTarget(self, action: #selector(yTexcallBack), for: .touchUpInside)

        UIView.animate(withDuration: 0.4) {
            self.underKey.alpha = 0
            self.alpha = 1.0
        }
    }

    func darkSpot(view: UIView) {
        view.alpha = 0
        centerKey.setTitle("\'", for: .normal)
        leftKey.setTitle("\"", for: .normal)
        rightKey.setTitle(")", for: .normal)
        upKey.setTitle("(", for: .normal)

        centerKey.addTarget(self, action: #selector(quotation), for: .touchUpInside)
        leftKey.addTarget(self, action: #selector(doubleQuotation), for: .touchUpInside)
        rightKey.addTarget(self, action: #selector(rightBrackets), for: .touchUpInside)
        upKey.addTarget(self, action: #selector(rightBrackets), for: .touchUpInside)

        UIView.animate(withDuration: 0.4) {
            self.underKey.alpha = 0
            self.alpha = 1.0
        }
    }

    func what(view: UIView) {
        view.alpha = 0
        centerKey.setTitle(".", for: .normal)
        leftKey.setTitle(",", for: .normal)
        rightKey.setTitle("!", for: .normal)
        upKey.setTitle("?", for: .normal)

        centerKey.addTarget(self, action: #selector(colon), for: .touchUpInside)
        leftKey.addTarget(self, action: #selector(spot), for: .touchUpInside)
        rightKey.addTarget(self, action: #selector(exclamation), for: .touchUpInside)
        upKey.addTarget(self, action: #selector(doubt), for: .touchUpInside)

        UIView.animate(withDuration: 0.4) {
            self.underKey.alpha = 0
            self.alpha = 1.0
        }
    }

    func texConversion() {
        if Global.texFlg == false {
            Global.texFlg = true
        } else {
            Global.texFlg = false
        }
    }

    @objc func at() { print("@"); self.alpha = 0 }
    @objc func sharp() { print("#"); self.alpha = 0 }
    @objc func and() { print("&"); self.alpha = 0 }
    @objc func slash() { print("/"); self.alpha = 0 }
    @objc func hyphen() { print("-"); self.alpha = 0 }

    @objc func dTexcallBack() { self.alpha = 0; guard Global.texFlg == false  else { Global.texFlg = true; print("d"); return }; print("D") }
    @objc func eTexcallBack() { self.alpha = 0; guard Global.texFlg == false  else { Global.texFlg = true; print("e"); return }; print("E") }
    @objc func fTexcallBack() { self.alpha = 0; guard Global.texFlg == false  else { Global.texFlg = true; print("f"); return }; print("F") }

    @objc func gTexcallBack() { self.alpha = 0; guard Global.texFlg == false  else { Global.texFlg = true; print("g"); return }; print("G") }
    @objc func HTexcallBack() { self.alpha = 0; guard Global.texFlg == false  else { Global.texFlg = true; print("h"); return }; print("H") }
    @objc func extraTexcallBack() { print("|"); self.alpha = 0 }

    @objc func jTexcallBack() { self.alpha = 0; guard Global.texFlg == false  else { Global.texFlg = true; print("j"); return }; print("J") }
    @objc func kTexcallBack() { self.alpha = 0; guard Global.texFlg == false  else { Global.texFlg = true; print("k"); return }; print("K") }
    @objc func lxtraTexcallBack() { self.alpha = 0; guard Global.texFlg == false  else { Global.texFlg = true; print("l"); return }; print("L") }

    @objc func mTexcallBack() { self.alpha = 0; guard Global.texFlg == false  else { Global.texFlg = true; print("m"); return }; print("M") }
    @objc func nTexcallBack() { self.alpha = 0; guard Global.texFlg == false  else { Global.texFlg = true; print("n"); return }; print("N") }
    @objc func oTexcallBack() { self.alpha = 0; guard Global.texFlg == false  else { Global.texFlg = true; print("o"); return }; print("O") }

    @objc func pTexcallBack() { self.alpha = 0; guard Global.texFlg == false  else { Global.texFlg = true; print("p"); return }; print("P") }
    @objc func qTexcallBack() { self.alpha = 0; guard Global.texFlg == false  else { Global.texFlg = true; print("q"); return }; print("Q") }
    @objc func rTexcallBack() { self.alpha = 0; guard Global.texFlg == false  else { Global.texFlg = true; print("r"); return }; print("R") }
    @objc func sTexcallBack() { self.alpha = 0; guard Global.texFlg == false  else { Global.texFlg = true; print("s"); return }; print("S") }

    @objc func tTexcallBack() { self.alpha = 0; guard Global.texFlg == false  else { Global.texFlg = true; print("t"); return }; print("T") }
    @objc func uTexcallBack() { self.alpha = 0; guard Global.texFlg == false  else { Global.texFlg = true; print("u"); return }; print("U") }
    @objc func vTexcallBack() { self.alpha = 0; guard Global.texFlg == false  else { Global.texFlg = true; print("v"); return }; print("V") }

    @objc func wTexcallBack() { self.alpha = 0; guard Global.texFlg == false  else { Global.texFlg = true; print("w"); return }; print("W") }
    @objc func xTexcallBack() { self.alpha = 0; guard Global.texFlg == false  else { Global.texFlg = true; print("x"); return }; print("X") }
    @objc func yTexcallBack() { self.alpha = 0; guard Global.texFlg == false  else { Global.texFlg = true; print("y"); return }; print("Y") }
    @objc func zTexcallBack() { self.alpha = 0; guard Global.texFlg == false  else { Global.texFlg = true; print("z"); return }; print("Z") }

    @objc func quotation() { self.alpha = 0; guard Global.texFlg == false  else { Global.texFlg = true; print("\'"); return }; print("\'") }
    @objc func doubleQuotation() { self.alpha = 0; guard Global.texFlg == false  else { Global.texFlg = true; print("\""); return }; print("\"") }
    @objc func rightBrackets() { self.alpha = 0; guard Global.texFlg == false  else { Global.texFlg = true; print(")"); return }; print(")") }
    @objc func leftBrackets() { self.alpha = 0; guard Global.texFlg == false  else { Global.texFlg = true; print("("); return }; print("(") }
    @objc func colon() { self.alpha = 0; guard Global.texFlg == false  else { Global.texFlg = true; print("."); return }; print(".") }
    @objc func spot() { self.alpha = 0; guard Global.texFlg == false  else { Global.texFlg = true; print(","); return }; print(",") }
    @objc func exclamation() { self.alpha = 0; guard Global.texFlg == false  else { Global.texFlg = true; print("!"); return }; print("!") }
    @objc func doubt() { self.alpha = 0; guard Global.texFlg == false  else { Global.texFlg = true; print("?"); return }; print("?") }

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

//
//  ViewController.swift
//  RecordARFace
//
//  Created by daisukenagata on 01/06/2019.
//  Copyright (c) 2019 daisukenagata. All rights reserved.
//

import UIKit
import RecordARFace

class ViewController: UIViewController {

    private var statusBar = RARFStatusBarUI().statusBar
    private lazy var cView: RARFCollectionView = {
        let cView = RARFCollectionView()
        return cView
    }()
    private var RepeatedHits = false
    private var key = RARFNumberKeyboard()

    override func viewDidLoad() {
        super.viewDidLoad()

        let button =  UIButton(type: UIButton.ButtonType.custom) as UIButton
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        button.setTitle("EyesTrack", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(eyesTracking), for: UIControl.Event.touchUpInside)
        self.navigationItem.titleView = button

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Record", style: .plain, target: self, action: #selector(startRecording))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Collection", style: .plain, target: self, action: #selector(collectionSet))
        navigationController?.navigationBar.addSubview(statusBar)
        view.addSubview(cView)
        view.addSubview(key)
    }

    @objc func startRecording() {
        RARFScreenRecorder(vc: self).startRecording()
        statusBarUI(st: "Stop",color: .red, sec: #selector(stopRecording))
    }

    @objc func stopRecording() {
        RARFScreenRecorder(vc: self).stopRecording()
        statusBarUI(st: "Record",color: .clear,sec: #selector(startRecording))
        collectionSet()
    }

    @objc func collectionSet() { cView.viewHidden()
        RepeatedHits = false
        cView.aView.tableView.isHidden = true
    }

    @objc func eyesTracking() {
        if RepeatedHits == false {
            RepeatedHits = true
            cView.viewEyesTracking()
            cView.aView.indexNumber = 10
            cView.aView.tableView.alpha = 0.7
            cView.aView.tableView.rowHeight = 100
            cView.aView.tableView.backgroundColor = .black
        }
    }

    func statusBarUI(st: String, color: UIColor, sec: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: st, style: .plain, target: self, action: sec)
        statusBar.backgroundColor = color
    }
}

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
    private var cView = RARFCollectionView()


    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Record", style: .plain, target: self, action: #selector(startRecording))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Collection", style: .plain, target: self, action: #selector(collectionSet))
    }

    @objc func startRecording() {
        RARFScreenRecorder(vc: self).startRecording()
        statusBarUI(st: "Stop",color: .red, sec: #selector(stopRecording))
    }

    @objc func stopRecording() {
        RARFScreenRecorder(vc: self).stopRecording()
        statusBarUI(st: "Record",color: .white,sec: #selector(startRecording))
    }

    @objc func collectionSet() {
        cView.collectionView.isHidden = false
        view.addSubview(cView)
    }

    func statusBarUI(st: String, color: UIColor, sec: Selector){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: st, style: .plain, target: self, action: sec)
        statusBar.backgroundColor = color
    }
}

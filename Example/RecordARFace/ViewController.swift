//
//  ViewController.swift
//  RecordARFace
//
//  Created by daisukenagata on 01/06/2019.
//  Copyright (c) 2019 daisukenagata. All rights reserved.
//

import UIKit
import RecordARFace
import WebKit

class ViewController: UIViewController {

    private var statusBar = RARFStatusBarUI().statusBar
    private var RepeatedHits = false
    private lazy var cView: RARFCollectionView = {
         let cView = RARFCollectionView(alphaSets: 0.7)
        return cView
    }()

    private var w = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // URLSetting
        // RARFUrlPath = "https://www.google.co.jp/search?q="

        // let button =  UIButton(type: UIButton.ButtonType.custom) as UIButton
        // button.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        // button.setTitle("EyesTrack", for: UIControl.State.normal)
        // button.addTarget(self, action: #selector(eyesTracking), for: UIControl.Event.touchUpInside)
        // self.navigationItem.titleView = button

        // navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Record", style: .plain, target: self, action: #selector(startRecording))
        // navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Collection", style: .plain, target: self, action: #selector(collectionSet))
        // navigationController?.navigationBar.addSubview(statusBar)
        view.addSubview(cView)
        // Web Scroll function
        RASRFWebUrlPath = "https://www.google.co.jp/"
        cView.webScrollTrue(color: .black)
        cView.contentOffSetY(y: 3)
        w = cView.webViewMerge()
        view.addSubview(w)
        // onlyCalculator
        // cView.onlyCalculator()
        // onlyEyeData
        // cView.onlyEyeData()
    }

    @objc func startRecording() {
        // RARFScreenRecorder(vc: self).startRecording()
        // statusBarUI(st: "Stop",color: .red, sec: #selector(stopRecording))
        // Web Scroll function
    }

    @objc func stopRecording() {
        // RARFScreenRecorder(vc: self).stopRecording()
        // statusBarUI(st: "Record",color: .clear,sec: #selector(startRecording))
        // collectionSet()
    }

    @objc func collectionSet() {
        // cView.viewHidden()
        // Web Scroll function
        RepeatedHits = false
    }

    @objc func eyesTracking() {
        if RepeatedHits == false {
            RepeatedHits = true
          /*
          // Calculator or Luangage function
          cView.viewEyesTracking()
          */

          /*
          // Table Scroll function
          cView.tableScrollTrue(color: .black)
          let table = cView.tableMerge()
          table.rowHeight = 100
          table.backgroundColor = .white
          view.addSubview(table)
          */

          /*
          // Web Scroll function
          RASRFWebUrlPath = "https://www.google.co.jp/"
          cView.webScrollTrue(color: .black)
          cView.contentOffSetY(y: 3)
          w = cView.webViewMerge()
          view.addSubview(w)
          */
        }
    }

    func statusBarUI(st: String, color: UIColor, sec: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: st, style: .plain, target: self, action: sec)
        statusBar.backgroundColor = color
    }
}

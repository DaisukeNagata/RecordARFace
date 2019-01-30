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
        cView.aView.tableView.delegate = self
        cView.aView.tableView.dataSource = self
        return cView
    }()


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
    }

    @objc func startRecording() {
        RARFScreenRecorder(vc: self).startRecording()
        statusBarUI(st: "Stop",color: .red, sec: #selector(stopRecording))
    }

    @objc func stopRecording() {
        RARFScreenRecorder(vc: self).stopRecording()
        statusBarUI(st: "Record",color: .clear,sec: #selector(startRecording))
    }

    @objc func collectionSet() { cView.viewHidden()
        // Version 0.4
        cView.aView.tableView.isHidden = true
    }
    @objc func eyesTracking() { cView.viewEyesTracking()
        // Version 0.4
        cView.aView.tableView.alpha = 0.7
        cView.aView.tableView.rowHeight = 100
        cView.aView.tableView.backgroundColor = .black
    }

    func statusBarUI(st: String, color: UIColor, sec: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: st, style: .plain, target: self, action: sec)
        statusBar.backgroundColor = color
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
}

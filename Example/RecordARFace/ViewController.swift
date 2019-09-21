//
//  ViewController.swift
//  RecordARFace
//
//  Created by daisukenagata on 01/06/2019.
//  Copyright (c) 2019 daisukenagata. All rights reserved.
//

import UIKit
import WebKit
import ARKit
import RecordARFace

class ViewController: UIViewController {

    private var w: WKWebView?
    private let ob = SampleTableData()
    private var statusBar = RARFStatusBarUI().statusBar
    private lazy var cView: RARFCollectionView = {
        let cView = RARFCollectionView(alphaSets: 0.7)
        return cView
    }()
    private lazy var stView: SampleTableView = {
        let stView = SampleTableView()
        stView.table.dataSource = ob
        stView.table.delegate = self
        return stView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        if ARFaceTrackingConfiguration.isSupported {
            print ("ARFaceTrackingConfiguration is supported. You can work with ARKit")
        } else {
            print ("ARFaceTrackingConfiguration is not supported. You cannot work with ARKit")
        }
        
        if ARConfiguration.isSupported {
            print ("ARConfiguration is supported. You can work with ARKit")
        } else {
            print ("ARConfiguration is not supported. You cannot work with ARKit")
        }

        // URLSetting
        RARFUrlPath = "https://www.google.co.jp/search?q="

        let button =  UIButton(type: UIButton.ButtonType.custom) as UIButton
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        button.setTitle("EyesTrack", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(eyesTracking), for: UIControl.Event.touchUpInside)
        self.navigationItem.titleView = button

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Record", style: .plain, target: self, action: #selector(startRecording))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Collection", style: .plain, target: self, action: #selector(collectionSet))
        navigationController?.navigationBar.addSubview(statusBar)
        view.addSubview(cView)
        view.addSubview(stView.table)

        // onlyCalculator
        // cView.onlyCalculator()
        // onlyEyeData
        // cView.onlyEyeData()
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

    @objc func collectionSet() { cView.rUseCase.viewHidden() }

    @objc func eyesTracking() {
        guard stView.table.frame.origin.y == 0 else {
            UIView.animate(withDuration: 0.5) { self.stView.table.frame.origin.y = 0 }
            return
        }
        UIView.animate(withDuration: 0.5) { self.stView.table.frame.origin.y -= self.view.frame.height }
    }

    func statusBarUI(st: String, color: UIColor, sec: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: st, style: .plain, target: self, action: sec)
        statusBar.backgroundColor = color
    }

    func cViewSet() {
        cView.removeFromSuperview()
        cView = RARFCollectionView(alphaSets: 0.7)
        view.addSubview(cView)

        stView.removeFromSuperview()
        stView = {
            let stView = SampleTableView()
            stView.table.dataSource = ob
            stView.table.delegate = self
            return stView
        }()
        view.addSubview(stView.table)
    }
}

// TODO MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) { self.stView.table.frame.origin.y -= self.view.frame.height }
        switch Count(rawValue: indexPath.row) {
        case .number?:
            // Web Scroll function
            RASRFWebUrlPath = "https://www.google.co.jp/"
            cViewSet()
            cView.rUseCase.webScrollTrue(color: .black)
            cView.rUseCase.contentOffSetY(y: 3)
            view.addSubview(w ?? WKWebView())
        case .keyBoard?:
            w?.removeFromSuperview()
            cViewSet()
            cView.rUseCase.viewEyesTracking()
        case .table?:
            w?.removeFromSuperview()
            cViewSet()
            cView.rUseCase.contentOffSetY(y: 5)
            cView.rUseCase.tableScrollTrue(color: .black)
            let table = cView.rUseCase.tableMerge()
            table.rowHeight = 200
            table.backgroundColor = .white
        default: break
        }
    }
}


final class SampleTableView: UIView {

    lazy var table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "SampleCell")
        table.rowHeight = 80
        return table
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.frame = UIScreen.main.bounds
        table.frame = self.frame
        table.frame.origin.y = -self.frame.height
        self.addSubview(table)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

enum Count: Int { case number, keyBoard, table, index }

final class SampleTableData: NSObject {}

// TODO MARK: UITableViewDataSource
extension SampleTableData: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Count.index.rawValue
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SampleCell", for: indexPath)
        switch Count(rawValue: indexPath.row) {
        case .number?:
            cell.textLabel?.text = "WebScroll"
            return cell
        case .keyBoard?:
            cell.textLabel?.text = "Calculator or Luangage function"
            return cell
        case .table?:
            cell.textLabel?.text = "Table Scroll"
            return cell
        default: break
        }
        return cell
    }
}

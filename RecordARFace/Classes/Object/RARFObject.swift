//
//  RARFObject.swift
//  RecordARFace
//
//  Created by 永田大祐 on 2019/01/06.
//

//
//  RARFObject.swift
//  RecordARFace
//
//  Created by 永田大祐 on 2019/01/06.
//

import ARKit
import UIKit
import WebKit

public var RASRFWebUrlPath = String()

@available(iOS 11.0, *)
protocol ARSCNDelegate: ARSCNViewDelegate {
    var resource: UIColor { get set }
    var contentNode: SCNNode? { get set }
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode?
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor)
}


@available(iOS 11.0, *)
final class RARFObject: NSObject, ARSessionDelegate, WKNavigationDelegate, WKUIDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate {

    public var indexNumber = 0
    public var contentOffSetY: CGFloat = 0
    private var privateOffsetY: CGFloat = 0

    var webFlg = false
    var tableFlg = false

    var timer: Timer?
    var numTimer: Timer?
    var spellTimer: Timer?
    var anchors: ARAnchor?
    var vc = UIViewController()
    var sc = UIScrollView()
    var rARFWebUIView: RARFWebUIView!
    var spellKey: RARFSpellAndKeyBoard?
    var luangageKey: RARFLuangageKeyBoard!
    var numberKey = RARFNumberKeyboardView()
    var numberChangeView: RARFNumberChangeKeyBoardView?

    lazy var webView: WKWebView = {
        var webView = WKWebView()
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.scrollView.delegate = self
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.frame = UIScreen.main.bounds
        tableView.register(RARFTableCell.self, forCellReuseIdentifier: "RARFTableCell")
        return tableView
    }()
    private var cells = RARFTableCell()
    private var indexPath = IndexPath()

    lazy var arscnView: ARSCNView = {
        let arscnView = ARSCNView()
        arscnView.automaticallyUpdatesLighting = true
        arscnView.delegate = self
        arscnView.session.delegate = self
        arscnView.frame.size = CGSize(width: 0.1, height: 0.1)
        return arscnView
    }()

    lazy var eView: UIView = {
        let eView = UIView()
        eView.frame = CGRect(x: 0,y: 0 ,width: 25, height: 25)
        eView.layer.cornerRadius = eView.frame.height/2
        return eView
    }()

    private var screenNode: SCNNode = {
        let screenNode = SCNPlane(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        screenNode.firstMaterial?.isDoubleSided = true
        return SCNNode(geometry: screenNode)
    }()

    private var nodeFace = SCNNode()
    private var phoneNode = SCNNode()
    private var eyeData: RARFEyeData?
    private var texturedFace: RARFTexturedFace?


    override init() {
        super.init()

        rARFWebUIView = RARFWebUIView()
        rARFWebUIView.goBt.alpha = 0
        rARFWebUIView.forwardBt.alpha = 0
        spellKey = RARFSpellAndKeyBoard(ob: self)
        numberChangeView = RARFNumberChangeKeyBoardView(ob: self)
        luangageKey = RARFLuangageKeyBoard(spellKey: spellKey!  ,numberKey: numberChangeView!)
        tableView.addSubview(numberKey)
        tableView.addSubview(spellKey!)
        tableView.addSubview(luangageKey!)
        tableView.addSubview(numberChangeView!)
        
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                 name: UIResponder.keyboardWillShowNotification, object: nil)

        let notificationHide = NotificationCenter.default
        notificationHide.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                     name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(_ notification: Notification?) {
        webFlg = false
        let offset = CGPoint(x: 0, y: -(UINavigationController().navigationBar.frame.height + UIApplication.shared.statusBarFrame.height))
        webView.scrollView.setContentOffset(offset, animated: false)
    }

    @objc func keyboardWillHide(_ notification: Notification?) { webFlg = true }

    func webReload() {
        webFlg = true
        guard let url = URL(string: RASRFWebUrlPath) else { fatalError() }
        let request = URLRequest(url: url)
        webView.load(request)
    }

    func webForward() {
        if webView.canGoForward == true {
            webView.goForward()
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { self.webFlg = true }
        }
    }

    func webBack() {
        if webView.backForwardList.backList.count == 0 {
            webView.isHidden = true
        } else {
            webView.goBack()
            webView.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { self.webFlg = true }
        }
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(WKNavigationActionPolicy.allow)

        self.privateOffsetY = 0
        self.webFlg = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { self.webFlg = true }
    }

    func resetTracking() {
        if self.anchors != nil { self.arscnView.session.remove(anchor: self.anchors!) }
        UIApplication.shared.isIdleTimerDisabled = true
        guard ARFaceTrackingConfiguration.isSupported else { return }
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        self.arscnView.session.run(configuration, options: [.resetTracking])
    }

    func texturedFace(color: UIColor) {
        eView.isHidden = true
        resetTracking()
        texturedFace = RARFTexturedFace(resource: color)
    }

    func eyeTracking(color: UIColor, flg: Bool) {
        tableFlg = false
        eView.isHidden = false
        tableView.isHidden = false
        texturedFace = RARFTexturedFace(resource: .clear)
        #if targetEnvironment(simulator)
        #else
        if flg == false {
            numberKey.isHidden = false
            spellKey?.isHidden = true
            luangageKey?.isHidden = true
            numberChangeView?.isHidden = true
            timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(numberKeyUpdate), userInfo: nil, repeats: true)
        } else {
            numberKey.isHidden = true
            spellKey?.isHidden = false
            luangageKey?.isHidden = false
            numberChangeView?.isHidden = false
            timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(luangageKeyUpdate), userInfo: nil, repeats: true)
        }
        arscnView.addSubview(eView)
        arscnView.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        eView = RARFFlameView(eView: eView, color: color).eViews
        eyeData = RARFEyeData()
        arscnView.scene.rootNode.addChildNode(eyeData!)
        arscnView.scene.rootNode.addChildNode(phoneNode)
        phoneNode.geometry?.firstMaterial?.isDoubleSided = true
        phoneNode.addChildNode(screenNode)
        resetTracking()
        #endif
    }

    func eyeTrackDataSet(color: UIColor? = .white) {
        eView.isHidden = false
        tableView.isHidden = false
        numberKey.isHidden = true
        spellKey?.isHidden = true
        luangageKey?.isHidden = true
        numberChangeView?.isHidden = true
        eView = RARFFlameView(eView: eView, color: color!).eViews
        eyeData = RARFEyeData()
        arscnView.scene.rootNode.addChildNode(eyeData!)
        arscnView.scene.rootNode.addChildNode(phoneNode)
        phoneNode.geometry?.firstMaterial?.isDoubleSided = true
        phoneNode.addChildNode(screenNode)
        resetTracking()
    }

    func eyeTrackingScroll(color: UIColor? = .white) {
        #if targetEnvironment(simulator)
        #else
        tableFlg = true
        tableView.addSubview(eView)
        arscnView.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        didSelectCell()
        eyeTrackDataSet(color: color)
        #endif
    }

    func eyeTrackingWebView(color: UIColor? = .white) {
        #if targetEnvironment(simulator)
        #else
        tableFlg = false

        webReload()
        webView.addSubview(eView)
        webView.addSubview(rARFWebUIView)
        eyeTrackDataSet(color: color)
        #endif
    }

    func tableContentOff() {
        if tableFlg == true {
            if eView.frame.origin.y > tableView.contentOffset.y {
                self.privateOffsetY += self.contentOffSetY
            } else {
                self.privateOffsetY -= self.contentOffSetY
            }
            let offset = CGPoint(x: 0, y: self.privateOffsetY)
            tableView.setContentOffset(offset, animated: true)
        }
    }

    func tableSetFlg() {
        if self.eView.frame.origin.x < 0 {
            self.tableFlg = false
        } else if eView.frame.origin.x > UIScreen.main.bounds.width {
            self.tableFlg = true
        }
    }

    @objc func didSelectUpdate() {
        cells.cellFlg = true
        cells.didselectBt(table: tableView, eView: eView, index: indexPath)
    }

    @objc func numberKeyUpdate() { numberKey.originTextField(rect: self.eView.frame) }

    @objc func luangageKeyUpdate() { luangageKey.originTextField(rect: self.eView.frame, timer: timer!) }

    @objc func numBarUpdate() { numberChangeView?.originTextField(rect: self.eView.frame, timer: numTimer!) }

    @objc func spellKeyUpdate() { spellKey?.originTextField(rect: self.eView.frame, timer: spellTimer!, view: luangageKey) }

    func didSelectCell() { timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(didSelectUpdate), userInfo: nil, repeats: true) }

    func updateNumber() { numTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(numBarUpdate), userInfo: nil, repeats: true) }

    func updateSpellKey() { spellTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(spellKeyUpdate), userInfo: nil, repeats: true) }

    func upDateluangageKey() { timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(luangageKeyUpdate), userInfo: nil, repeats: true) }

    private func webEViewSet() {

        if webFlg == true && eView.frame.origin.y > -(UINavigationController().navigationBar.frame.height + UIApplication.shared.statusBarFrame.height) {
            let offset = CGPoint(x: 0, y: eView.frame.origin.y + self.privateOffsetY)
            webView.scrollView.setContentOffset(offset, animated: true)
            rARFWebUIView.goBt.frame.origin.y = UIScreen.main.bounds.height/2
            rARFWebUIView.forwardBt.frame.origin.y = UIScreen.main.bounds.height/2
            rARFWebUIView.originTextField(rect: eView.frame, rARFObject: self)
        }
    }

    private func webContentOffSetX() {
        if self.eView.frame.origin.y > self.webView.frame.height/2 {
            self.privateOffsetY += self.contentOffSetY
        } else {
            self.privateOffsetY -= self.contentOffSetY
        }
        if self.eView.frame.origin.x < 150 {
            UIView.animate(withDuration: 0.3) { self.rARFWebUIView.goBt.alpha = 1 }
        } else {
            UIView.animate(withDuration: 0.3) { self.rARFWebUIView.goBt.alpha = 0 }
        }

        if self.eView.frame.origin.x > UIScreen.main.bounds.width - 150 {
            UIView.animate(withDuration: 0.3) { self.rARFWebUIView.forwardBt.alpha = 1 }
        } else {
            UIView.animate(withDuration: 0.3) { self.rARFWebUIView.forwardBt.alpha = 0 }
        }

        if self.eView.frame.origin.x < 0 {
            webFlg = false
        } else if eView.frame.origin.x > UIScreen.main.bounds.width {
            self.privateOffsetY  = webView.scrollView.contentOffset.y
            webFlg = true
        }
    }
}

// MARK: ARSCNViewDelegate
@available(iOS 11.0, *)
extension RARFObject: ARSCNViewDelegate {

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        anchors = anchor
        guard texturedFace?.renderer(renderer, nodeFor: anchor) == nil else {
            guard let contentNode = texturedFace?.renderer(renderer, nodeFor: anchor) else { return }

            nodeFace = contentNode
            node.addChildNode(contentNode)
            return
        }
        guard let contentNode = eyeData?.renderer(renderer, nodeFor: anchor) else { return }
        nodeFace = contentNode
        node.addChildNode(contentNode)
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard texturedFace?.contentNode == nil else {
            texturedFace?.renderer(renderer, didUpdate: nodeFace, for: anchor)
            return
        }
        eyeData?.transform = node.transform
        eyeData?.renderer(renderer, didUpdate: node, for: anchor)
    }

    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        DispatchQueue.main.async {
            guard self.eyeData?.contentNode == nil else {
                if let arscnView = self.arscnView.pointOfView { self.phoneNode.transform = arscnView.transform }
                let options : [String: Any] = [SCNHitTestOption.backFaceCulling.rawValue: false,
                                               SCNHitTestOption.searchMode.rawValue: 1,
                                               SCNHitTestOption.ignoreChildNodes.rawValue : false,
                                               SCNHitTestOption.ignoreHiddenNodes.rawValue : false]

                let leftEye = self.phoneNode.hitTestWithSegment (
                    from: self.phoneNode.convertPosition(self.eyeData!.leftEye.worldPosition, from: nil),
                    to:  self.phoneNode.convertPosition(self.eyeData!.leftEyeEnd.worldPosition, from: nil),
                    options: options)

                let rightEye = self.phoneNode.hitTestWithSegment (
                    from: self.phoneNode.convertPosition(self.eyeData!.rightEye.worldPosition, from: nil),
                    to:  self.phoneNode.convertPosition(self.eyeData!.rightEyeEnd.worldPosition, from: nil),
                    options: options)

                if !leftEye.isEmpty && !rightEye.isEmpty {

                    guard let coords = self.eyeData?.eyePosition(leftEye[0], secondResult: rightEye[0]) else { return }

                    self.eView.frame.origin.x = CGFloat(coords.x)
                    self.eView.frame.origin.y = CGFloat(coords.y)

                    guard self.indexNumber == 0 else {
                        self.tableSetFlg()
                        self.eView.frame.origin.y = self.tableView.contentOffset.y
                        self.eView.frame.origin.y += CGFloat(coords.y)*2
                        self.tableContentOff()
                        self.tableSetFlg()
                        return
                    }

                    guard self.webView.url == nil else {
                        self.webContentOffSetX()
                        self.webEViewSet()
                        return
                    }
                }
                return
            }
        }
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate
@available(iOS 11.0, *)
extension RARFObject: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row, "RARFTableCell")
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RARFTableCell", for: indexPath) as? RARFTableCell {
            cells = cell
            self.indexPath = indexPath
            cell.textLabel?.text = indexPath.row.description
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return indexNumber
    }
}

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

    public var contentOffSetY: CGFloat = 0
    private var privateOffsetY: CGFloat = 0

    var webFlg = false
    var tableFlg = false
    var timer: Timer?
    var numTimer: Timer?
    var spellTimer: Timer?
    var vc: UIViewController?
    var rARFWebUIView: RARFWebUIView?
    var spellKey: RARFSpellAndKeyBoard?
    var luangageKey: RARFLuangageKeyBoard?
    var numberKey: RARFNumberKeyboardView?
    var numberChangeView: RARFNumberChangeKeyBoardView?

    var data = RARFTableViewDataSource()

    lazy var webView: WKWebView = {
        var webView = WKWebView()
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.scrollView.delegate = data
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.frame = UIScreen.main.bounds
        tableView.register(RARFTableCell.self, forCellReuseIdentifier: "RARFTableCell")
        return tableView
    }()

    lazy var arscnView: ARSCNView = {
        let arscnView = ARSCNView()
        arscnView.automaticallyUpdatesLighting = true
        arscnView.delegate = self
        arscnView.session.delegate = self
        arscnView.frame.size = CGSize(width: 0.1, height: 0.1)
        arscnView.frame.origin.y = UINavigationController.init().navigationBar.frame.height + UIApplication.shared.statusBarFrame.height
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

        eyeData = RARFEyeData()
        rARFWebUIView = RARFWebUIView()

        rARFWebUIView?.goBt.alpha = 0
        rARFWebUIView?.forwardBt.alpha = 0

        numberKey = RARFNumberKeyboardView()
        spellKey = RARFSpellAndKeyBoard(ob: self)
        numberChangeView = RARFNumberChangeKeyBoardView(ob: self)
        luangageKey = RARFLuangageKeyBoard(spellKey: spellKey, numberKey: numberChangeView)

        webView.addSubview(rARFWebUIView ?? UIView())

        arscnView.addSubview(tableView)
        arscnView.addSubview(spellKey!)
        arscnView.addSubview(numberKey!)
        arscnView.addSubview(luangageKey!)
        arscnView.addSubview(numberChangeView!)

        spellKey?.isHidden = true
        numberKey?.isHidden = true
        luangageKey?.isHidden = true
        numberChangeView?.isHidden = true

        tableView.delegate = data
        tableView.dataSource = data

        eView = RARFFlameView(eView: eView, color: .black).eViews
        arscnView.scene.rootNode.addChildNode(eyeData!)
        arscnView.scene.rootNode.addChildNode(phoneNode)
        phoneNode.geometry?.firstMaterial?.isDoubleSided = true
        phoneNode.addChildNode(screenNode)

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
        if webView.canGoForward == true { webView.goForward() }
        privateOffsetY = webView.scrollView.contentOffset.y
        let offset = CGPoint(x: 0, y: privateOffsetY)
        webView.scrollView.setContentOffset(offset, animated: true)
    }

    func webBack() {
        if webView.backForwardList.backList.count == 0 {
            webView.isHidden = true
        } else {
            webView.goBack()
            webView.isHidden = false
        }
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(WKNavigationActionPolicy.allow)

        self.privateOffsetY = 0
        self.webFlg = false
    }

    func resetTracking() {
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

    func eyeTracking(color: UIColor?, flg: Bool) {
        tableFlg = false
        eView.isHidden = false
        webView.isHidden = true
        tableView.isHidden = true
        texturedFace = RARFTexturedFace(resource: .clear)
        #if targetEnvironment(simulator)
        #else
        if flg == false {
            spellKey?.isHidden = true
            numberKey?.isHidden = false
            luangageKey?.isHidden = true
            numberChangeView?.isHidden = true
            timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(numberKeyUpdate), userInfo: nil, repeats: true)
        } else {
            spellKey?.isHidden = false
            numberKey?.isHidden = true
            luangageKey?.isHidden = false
            numberChangeView?.isHidden = false
            timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(luangageKeyUpdate), userInfo: nil, repeats: true)
        }
        eView.removeFromSuperview()
        eView = RARFFlameView(eView: eView, color: .black).eViews
        arscnView.addSubview(eView)
        resetTracking()
        #endif
    }

    func eyeTrackDataSet() {
        eView.isHidden = false
        tableView.isHidden = false
        numberKey?.isHidden = true
        spellKey?.isHidden = true
        luangageKey?.isHidden = true
        numberChangeView?.isHidden = true
        resetTracking()
    }

    func eyeTrackingScroll(color: UIColor? = .white) {
        #if targetEnvironment(simulator)
        #else
        tableFlg = true
        webView.isHidden = true
        eView.removeFromSuperview()
        eView = RARFFlameView(eView: eView, color: color ?? UIColor()).eViews
        tableView.addSubview(eView)
        didSelectCell()
        eyeTrackDataSet()
        #endif
    }

    func eyeTrackingWebView(color: UIColor? = .white) {
        #if targetEnvironment(simulator)
        #else
        tableFlg = false
        webView.isHidden = false
        tableView.isHidden = true
        eView.removeFromSuperview()
        eView = RARFFlameView(eView: eView, color: color ?? UIColor()).eViews
        webView.addSubview(eView)
        webReload()
        eyeTrackDataSet()
        #endif
    }

    func tableContentOff() {
        if tableFlg == true {
            if eView.frame.origin.y > tableView.contentOffset.y {
                privateOffsetY += self.contentOffSetY
            } else {
                privateOffsetY -= self.contentOffSetY
            }
            let offset = CGPoint(x: 0, y: privateOffsetY)
            tableView.setContentOffset(offset, animated: true)
        }
    }

    func tableSetFlg() {
        if eView.frame.origin.x < 0 {
            privateOffsetY = tableView.contentOffset.y
            let offset = CGPoint(x: 0, y: privateOffsetY)
            tableView.setContentOffset(offset, animated: true)
            tableFlg = false
        } else if eView.frame.origin.x > UIScreen.main.bounds.width {
            privateOffsetY = tableView.contentOffset.y
            tableFlg = true
        }
    }

    func tableFlgSetTrue() {
        privateOffsetY = tableView.contentOffset.y
        tableFlg = true
    }

    func tableFlgSetFalse() {
        privateOffsetY = tableView.contentOffset.y
        let offset = CGPoint(x: 0, y: privateOffsetY)
        tableView.setContentOffset(offset, animated: true)
        tableFlg = false
    }

    @objc func didSelectUpdate(timer: Timer) {
        data.cells.cellFlg = true
        if tableFlg == false { data.cells.didSelectBt(table: tableView, eView: eView) }
    }

    @objc func numberKeyUpdate() { numberKey?.originTextField(rect: self.eView.frame) }

    @objc func luangageKeyUpdate() { luangageKey?.originTextField(rect: self.eView.frame, timer: timer ?? Timer()) }

    @objc func numBarUpdate() { numberChangeView?.originTextField(rect: self.eView.frame, timer: numTimer ?? Timer()) }

    @objc func spellKeyUpdate() { spellKey?.originTextField(rect: self.eView.frame, timer: spellTimer ?? Timer(), view: luangageKey ?? RARFLuangageKeyBoard()) }

    func didSelectCell() { timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(didSelectUpdate), userInfo: nil, repeats: true) }

    func updateNumber() { numTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(numBarUpdate), userInfo: nil, repeats: true) }

    func updateSpellKey() { spellTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(spellKeyUpdate), userInfo: nil, repeats: true) }

    func upDateluangageKey() { timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(luangageKeyUpdate), userInfo: nil, repeats: true) }

    private func webEViewSet() {
        if webFlg == true && eView.frame.origin.y > -(UINavigationController().navigationBar.frame.height + UIApplication.shared.statusBarFrame.height) {
            let offset = CGPoint(x: 0, y: eView.frame.origin.y + privateOffsetY)
            webView.scrollView.setContentOffset(offset, animated: true)
            rARFWebUIView?.goBt.frame.origin.y = UIScreen.main.bounds.height/2
            rARFWebUIView?.forwardBt.frame.origin.y = UIScreen.main.bounds.height/2
            rARFWebUIView?.originTextField(rect: eView.frame, rARFObject: self)
        }
    }

    private func webContentOffSetX() {

        if self.eView.frame.origin.y > self.webView.frame.height/2 {
            self.privateOffsetY += self.contentOffSetY
        } else {
            self.privateOffsetY -= self.contentOffSetY
        }

        if eView.frame.origin.x < 150 {
            UIView.animate(withDuration: 0.3) { self.rARFWebUIView?.goBt.alpha = 1 }
        } else {
            UIView.animate(withDuration: 0.3) { self.rARFWebUIView?.goBt.alpha = 0 }
        }

        if self.eView.frame.origin.x > UIScreen.main.bounds.width - 150 {
            UIView.animate(withDuration: 0.3) { self.rARFWebUIView?.forwardBt.alpha = 1 }
        } else {
            UIView.animate(withDuration: 0.3) { self.rARFWebUIView?.forwardBt.alpha = 0 }
        }

        if self.eView.frame.origin.y < 0 || eView.frame.origin.y > UIScreen.main.bounds.height{ webFlg = true }
    }
}

// MARK: ARSCNViewDelegate
@available(iOS 11.0, *)
extension RARFObject: ARSCNViewDelegate {

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let contentNode = texturedFace?.renderer(renderer, nodeFor: anchor) else { return }
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
                    from: self.phoneNode.convertPosition(self.eyeData?.leftEye.worldPosition ?? SCNVector3(), from: nil),
                    to:  self.phoneNode.convertPosition(self.eyeData?.leftEyeEnd.worldPosition ?? SCNVector3(), from: nil),
                    options: options)

                let rightEye = self.phoneNode.hitTestWithSegment (
                    from: self.phoneNode.convertPosition(self.eyeData?.rightEye.worldPosition ?? SCNVector3(), from: nil),
                    to:  self.phoneNode.convertPosition(self.eyeData?.rightEyeEnd.worldPosition ?? SCNVector3(), from: nil),
                    options: options)

                guard leftEye.isEmpty, rightEye.isEmpty else {

                    guard let coords = self.eyeData?.eyePosition(leftEye[0], secondResult: rightEye[0]) else { return }
                    self.eView.frame.origin = CGPoint(x: CGFloat(coords.x), y: CGFloat(coords.y))

                    guard self.data.indexNumber == 0 else {
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
                    return
                }
                return
            }
        }
    }
}

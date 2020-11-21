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
final class RARFObject: NSObject, ARSessionDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate {

    public var contentOffSetY: CGFloat = 0
    private var privateOffsetY: CGFloat = 0

    var tableFlg = false
    var timer: Timer?
    var numTimer: Timer?
    var spellTimer: Timer?
    var anchors: ARAnchor?
    var vc: UIViewController?
    var spellKey: RARFSpellAndKeyBoard?
    var luangageKey: RARFLuangageKeyBoard?
    var numberKey: RARFNumberKeyboardView?
    var numberChangeView: RARFNumberChangeKeyBoardView?

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.frame = UIScreen.main.bounds
        tableView.backgroundColor = .clear
        tableView.register(RARFTableCell.self, forCellReuseIdentifier: "RARFTableCell")
        return tableView
    }()

    lazy var arscnView: ARSCNView = {
        var statusBarHeight: CGFloat  = 0
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0

        let arscnView = ARSCNView()
        arscnView.automaticallyUpdatesLighting = true
        arscnView.delegate = self
        arscnView.session.delegate = self
        arscnView.frame.size = CGSize(width: 0.1, height: 0.1)
        arscnView.frame.origin.y = UINavigationController.init().navigationBar.frame.height + statusBarHeight
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

    private var eyeData: RARFEyeData?
    private var texturedFace: RARFTexturedFace?
    private var nodeFace: SCNNode
    private var phoneNode: SCNNode


    override init() {
        nodeFace = SCNNode()
        phoneNode = SCNNode()
        super.init()

        eyeData = RARFEyeData()
        numberKey = RARFNumberKeyboardView()
        spellKey = RARFSpellAndKeyBoard(ob: self)
        numberChangeView = RARFNumberChangeKeyBoardView(ob: self)
        luangageKey = RARFLuangageKeyBoard(spellKey: spellKey, numberKey: numberChangeView)

        arscnView.addSubview(tableView)
        arscnView.addSubview(numberKey!)
        arscnView.addSubview(spellKey!)
        arscnView.addSubview(luangageKey!)
        arscnView.addSubview(numberChangeView!)
        numberKey?.isHidden = true
        spellKey?.isHidden = true
        luangageKey?.isHidden = true
        numberChangeView?.isHidden = true

        eView = RARFFlameView(eView: eView, color: .black).eViews
        arscnView.addSubview(eView)
        arscnView.scene.rootNode.addChildNode(eyeData!)
        arscnView.scene.rootNode.addChildNode(phoneNode)
        phoneNode.geometry?.firstMaterial?.isDoubleSided = true
        phoneNode.addChildNode(screenNode)

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

    func eyeTracking(color: UIColor?, flg: Bool) {
        tableFlg = false
        eView.isHidden = false
        tableView.isHidden = true
        texturedFace = RARFTexturedFace(resource: .clear)
        #if targetEnvironment(simulator)
        #else
        if flg == false {
            numberKey?.isHidden = false
            spellKey?.isHidden = true
            luangageKey?.isHidden = true
            numberChangeView?.isHidden = true
            timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(numberKeyUpdate), userInfo: nil, repeats: true)
        } else {
            numberKey?.isHidden = true
            spellKey?.isHidden = false
            luangageKey?.isHidden = false
            numberChangeView?.isHidden = false
            timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(luangageKeyUpdate), userInfo: nil, repeats: true)
        }
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
        eView.removeFromSuperview()
        eView = RARFFlameView(eView: eView, color: color ?? UIColor()).eViews
        tableView.addSubview(eView)
        eyeTrackDataSet()
        #endif
    }

    func eyeTrackingWebView(color: UIColor? = .white) {
        #if targetEnvironment(simulator)
        #else
        tableFlg = false
        tableView.isHidden = true
        eView.removeFromSuperview()
        eView = RARFFlameView(eView: eView, color: color ?? UIColor()).eViews
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

    @objc func numberKeyUpdate() { numberKey?.originTextField(rect: self.eView.frame) }

    @objc func luangageKeyUpdate() { luangageKey?.originTextField(rect: self.eView.frame, timer: timer ?? Timer()) }

    @objc func numBarUpdate() { numberChangeView?.originTextField(rect: self.eView.frame, timer: numTimer ?? Timer()) }

    @objc func spellKeyUpdate() { spellKey?.originTextField(rect: self.eView.frame, timer: spellTimer ?? Timer(), view: luangageKey ?? RARFLuangageKeyBoard()) }

    func updateNumber() { numTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(numBarUpdate), userInfo: nil, repeats: true) }

    func updateSpellKey() { spellTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(spellKeyUpdate), userInfo: nil, repeats: true) }

    func upDateluangageKey() { timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(luangageKeyUpdate), userInfo: nil, repeats: true) }

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
            let options : [String: Any] = [SCNHitTestOption.backFaceCulling.rawValue: false,
                                           SCNHitTestOption.searchMode.rawValue: 0,
                                           SCNHitTestOption.ignoreChildNodes.rawValue : false,
                                           SCNHitTestOption.ignoreHiddenNodes.rawValue : false]

            if let arscnView = self.arscnView.pointOfView { self.phoneNode.transform = arscnView.transform }
            let leftEye = self.phoneNode.hitTestWithSegment (
                from: self.phoneNode.convertPosition(self.eyeData?.leftEye.worldPosition ?? SCNVector3(), from: nil),
                to:  self.phoneNode.convertPosition(self.eyeData?.leftEyeEnd.worldPosition ?? SCNVector3(), from: nil),
                options: options)

            let rightEye = self.phoneNode.hitTestWithSegment (
                from: self.phoneNode.convertPosition(self.eyeData?.rightEye.worldPosition ?? SCNVector3(), from: nil),
                to:  self.phoneNode.convertPosition(self.eyeData?.rightEyeEnd.worldPosition ?? SCNVector3(), from: nil),
                options: options)

            guard leftEye.isEmpty, rightEye.isEmpty else {
                let coords = self.eyeData?.eyePosition((leftEye[0]), secondResult: (rightEye[0]))
                self.eView.frame.origin = CGPoint(x: CGFloat(coords?.x ?? Float(CGFloat())), y: CGFloat(coords?.y ?? Float(CGFloat())))

                return
            }
        }
    }
}

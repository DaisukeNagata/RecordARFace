//
//  RARFView.swift
//  RecordARFace
//
//  Created by 永田大祐 on 2019/01/06.
//

import ARKit

@available(iOS 11.0, *)
protocol ARSCNDelegate: ARSCNViewDelegate {
    var contentNode: SCNNode? { get set }
    var resource: UIColor { get set }
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode?
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor)
}


@available(iOS 11.0, *)
final class RARFView: NSObject, ARSessionDelegate {

    lazy var arscnView: ARSCNView = {
        let arscnView = ARSCNView()
        arscnView.automaticallyUpdatesLighting = true
        arscnView.frame = UIScreen.main.bounds
        arscnView.delegate = self
        arscnView.session.delegate = self
        arscnView.frame = UIScreen.main.bounds
        return arscnView
    }()

    private lazy var eView: UIView = {
        let eView = UIView()
        eView.frame = CGRect(x: 0,y:0 ,width:25 ,height:25)
        eView.layer.cornerRadius = eView.frame.height/2
        return eView
    }()

    private var screenNode: SCNNode = {
        let screenNode = SCNPlane(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        screenNode.firstMaterial?.isDoubleSided = true
        return SCNNode(geometry: screenNode)
    }()

    private var phoneNode: SCNNode = SCNNode()
    private var tx: RARFTexturedFace?
    private var rf: RARFEyeData?


    override init() {
        super.init()

        arscnView.addSubview(eView)
    }

    func resetTracking() {
        UIApplication.shared.isIdleTimerDisabled = true
        guard ARFaceTrackingConfiguration.isSupported else { return }
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        arscnView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }

    func texturedFace(color: UIColor) {
        resetTracking()
        tx = RARFTexturedFace(resource: color)
    }

    func eyeTracking(color: UIColor) {
        #if targetEnvironment(simulator)
        #else
        eView = RARFFlameView(eView: eView, color: color).eViews
        let eyeGeometry = ARSCNFaceGeometry(device: arscnView.device!)
        rf = RARFEyeData(geometry: eyeGeometry!)
        arscnView.scene.rootNode.addChildNode(rf!)
        arscnView.scene.rootNode.addChildNode(phoneNode)
        phoneNode.geometry?.firstMaterial?.isDoubleSided = true
        phoneNode.addChildNode(screenNode)
        resetTracking()
        #endif
    }
}

// MARK: ARSCNViewDelegate
@available(iOS 11.0, *)
extension RARFView: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {

        if let contentNode = tx?.renderer(renderer, nodeFor: anchor) {
            node.addChildNode(contentNode)
        } else if let contentNode = rf?.renderer(renderer, nodeFor: anchor) {
            node.addChildNode(contentNode)
        }
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {

        if let contentNode = tx?.renderer(renderer, nodeFor: anchor) {
            tx?.renderer(renderer, didUpdate: contentNode, for: anchor)
        }  else if let contentNode = rf?.renderer(renderer, nodeFor: anchor) {
            rf?.transform = node.transform
            rf?.renderer(renderer, didUpdate: contentNode, for: anchor)
        }
    }

    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {

        guard rf?.contentNode == nil else {
            phoneNode.transform = (arscnView.pointOfView?.transform)!

            let options : [String: Any] = [SCNHitTestOption.backFaceCulling.rawValue: false,
                                           SCNHitTestOption.searchMode.rawValue: 1,
                                           SCNHitTestOption.ignoreChildNodes.rawValue : false,
                                           SCNHitTestOption.ignoreHiddenNodes.rawValue : false]

            let leftEye = phoneNode.hitTestWithSegment (
                from: phoneNode.convertPosition(rf!.leftEye.worldPosition, from:nil),
                to:  phoneNode.convertPosition(rf!.leftEyeEnd.worldPosition, from:nil),
                options: options)

            let rightEye = phoneNode.hitTestWithSegment (
                from: phoneNode.convertPosition(rf!.rightEye.worldPosition, from:nil),
                to:  phoneNode.convertPosition(rf!.rightEyeEnd.worldPosition, from:nil),
                options: options)

            guard let coords = rf?.eyePosition(leftEye[0], secondResult: rightEye[0]) else { return }
            DispatchQueue.main.sync{ self.eView.frame.origin = CGPoint(x: CGFloat(coords.x), y: CGFloat(coords.y)) }
            return
        }
    }
}

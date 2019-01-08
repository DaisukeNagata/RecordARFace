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
    private var currentFaceAnchor: ARFaceAnchor?
    var tx: RARFTexturedFace?


    func resetTracking(color: UIColor) {
        tx = RARFTexturedFace(resource: color)
        UIApplication.shared.isIdleTimerDisabled = true
        guard ARFaceTrackingConfiguration.isSupported else { return }
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        arscnView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
}

// MARK: ARSCNViewDelegate
@available(iOS 11.0, *)
extension RARFView: ARSCNViewDelegate {
     func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let faceAnchor = anchor as? ARFaceAnchor else { return }
        currentFaceAnchor = faceAnchor
        if node.childNodes.isEmpty, let contentNode = tx?.renderer(renderer, nodeFor: faceAnchor) {
            node.addChildNode(contentNode)
        }
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard anchor == currentFaceAnchor,
            let contentNode = tx?.contentNode,
            contentNode.parent == node
            else { return }
        tx?.renderer(renderer, didUpdate: contentNode, for: anchor)
    }
}

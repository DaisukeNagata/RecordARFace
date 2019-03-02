//
//  RARFTexturedFace.swift
//  RecordARFace
//
//  Created by 永田大祐 on 2019/01/06.
//  Copyright © 2019 永田大祐. All rights reserved.
//

import ARKit

@available(iOS 11.0, *)
final class RARFTexturedFace: NSObject, ARSCNDelegate {

    var resource: UIColor
    var contentNode: SCNNode?


    init(resource: UIColor) {
        self.resource = resource
    }

    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {

        guard let sceneView = renderer as? ARSCNView,
            anchor is ARFaceAnchor,
            resource != .clear
            else { return nil }
        #if targetEnvironment(simulator)
        #else
        let faceGeometry = ARSCNFaceGeometry(device: sceneView.device!)!
        let material = faceGeometry.firstMaterial!

        material.diffuse.contents = resource
        material.lightingModel = .physicallyBased

        contentNode = SCNNode(geometry: faceGeometry)
        #endif
        return contentNode
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {

        guard let faceGeometry = node.geometry as? ARSCNFaceGeometry,
            let faceAnchor = anchor as? ARFaceAnchor
            else { return }

        faceGeometry.update(from: faceAnchor.geometry)
    }
}

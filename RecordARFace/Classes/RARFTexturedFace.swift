//
//  RARFTexturedFace.swift
//  RecordARFace
//
//  Created by 永田大祐 on 2019/01/06.
//  Copyright © 2019 永田大祐. All rights reserved.
//

import ARKit
import SceneKit

@available(iOS 11.0, *)
class RARFTexturedFace: NSObject, ARSCNDelegate {

    var resource: String
    var contentNode: SCNNode?

    init(resource: String) {
        self.resource = resource
    }

    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard let sceneView = renderer as? ARSCNView,
            anchor is ARFaceAnchor,
            !resource.isEmpty
            else { return nil }
        #if targetEnvironment(simulator)
        #error("ARKit is not supported in iOS Simulator. Connect a physical iOS device and select it as your Xcode run destination, or select Generic iOS Device as a build-only destination.")
        #else
        let faceGeometry = ARSCNFaceGeometry(device: sceneView.device!)!
        let material = faceGeometry.firstMaterial!

        material.diffuse.contents = #imageLiteral(resourceName: resource)
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

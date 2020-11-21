//
//  RARFEyeData.swift
//  Pods-RecordARFace_Example
//
//  Created by 永田大祐 on 2019/01/13.
//

import ARKit
import SceneKit

@available(iOS 11.0, *)
final class RARFEyeData: SCNNode {

    let leftEye: SCNNode
    let rightEye: SCNNode
    let leftEyeEnd: SCNNode
    let rightEyeEnd: SCNNode
    var contentNode: SCNNode?
    var resource: UIColor
    private let numPositions = 30
    private let floatRaycastDistance: Float = 1
    private var positions: Array<simd_float2>


    override init() {

        leftEye = SCNNode()
        rightEye = SCNNode()
        resource = UIColor()
        leftEyeEnd = SCNNode()
        rightEyeEnd = SCNNode()
        contentNode = SCNNode()
        positions = Array<simd_float2>()

        leftEye.addChildNode(leftEyeEnd)
        leftEyeEnd.simdPosition = simd_float3(0 , 0, floatRaycastDistance)

        rightEye.addChildNode(rightEyeEnd)
        rightEyeEnd.simdPosition = simd_float3(0 , 0, floatRaycastDistance)

        super.init()

        addChildNode(leftEye)
        addChildNode(rightEye)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@available(iOS 11.0, *)
extension RARFEyeData {
    func eyePosition(_ res: SCNHitTestResult, secondResult resSecound: SCNHitTestResult) -> simd_float2 {
        let iPhoneSize = simd_float2(Float(UIScreen.main.bounds.width),Float(UIScreen.main.bounds.height))

        let xLC = ((res.localCoordinates.x + resSecound.localCoordinates.x))
        let x = ( xLC * iPhoneSize.x * 3 ) + Float(UIScreen.main.bounds.width / 2)

        let yLC = -((res.localCoordinates.y + resSecound.localCoordinates.y))
        let y = yLC * iPhoneSize.y * 3

        positions.append(simd_float2(x,y))
        if positions.count > numPositions { positions.removeFirst() }

        var total = simd_float2(0,0)
        for pos in positions { total += pos }
        total /= Float( positions.count )

        return total
    }
}

// MARK: ARSCNViewDelegate
@available(iOS 11.0, *)
extension RARFEyeData: ARSCNDelegate {

    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        #if targetEnvironment(simulator)
        #else
        #endif
        return contentNode
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        let  anchor = anchor as! ARFaceAnchor
        leftEye.simdTransform = anchor.leftEyeTransform
        rightEye.simdTransform = anchor.rightEyeTransform
    }
}

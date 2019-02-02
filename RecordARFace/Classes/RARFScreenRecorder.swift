//
//  RARFScreenRecorder.swift
//  RecordARFace
//
//  Created by 永田大祐 on 2019/01/06.
//  Copyright © 2019 永田大祐. All rights reserved.
//

import ReplayKit

public class RARFScreenRecorder: NSObject,RPPreviewViewControllerDelegate {

    private var vc: UIViewController


    public init(vc: UIViewController) {
        self.vc = vc
    }

    var recorder: RPScreenRecorder = {
        let recorder = RPScreenRecorder.shared()
        recorder.isMicrophoneEnabled = true
        return recorder
    }()

    @available(iOS 10.0, *)
    public func startRecording() {
            self.recorder.startRecording { (error) in
                guard error == nil else { return }
        }
    }

    public func stopRecording() {
        DispatchQueue.main.async {
            self.recorder.stopRecording { (preview, error) in
                guard preview == nil else {
                    preview?.previewControllerDelegate = self
                    self.vc.present(preview!, animated: true)
                    return
                }
            }
        }
    }

    public func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        vc.dismiss(animated: true)
    }
}

//
//  RecorderView.swift
//  Pods-SwiftVideoRecorder_Example
//
//  Created by Максим Ефимов on 26.06.2018.
//

import UIKit
import AVFoundation

open class RecorderView: UIView {
    public private(set) var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    public var recorder: Recorder = {
        var recorder = Recorder()
        return recorder
    }()
    
    public init() {
        super.init(frame: CGRect())
        self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.recorder.captureSession)
        self.videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspect
        //добавляем лэйер превью перед всеми лэйэрами
        if let sublayers = self.layer.sublayers, !sublayers.isEmpty {
            self.layer.insertSublayer(self.videoPreviewLayer!, below: sublayers[0])
        }
        else {
            self.layer.addSublayer(self.videoPreviewLayer!)
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.videoPreviewLayer?.frame = self.layer.bounds
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

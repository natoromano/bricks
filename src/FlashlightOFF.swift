//
//  FlashlightON.swift
//  CodeBuilderApp
//
//  Created by Geneviève Robin on 10/12/2014.
//  Copyright (c) 2014 Geneviève Robin. All rights reserved.
//

import Foundation
import AVFoundation

class FlashlightOFF:Node {
    
    override init() {
        super.init()
        self.name="flashlightOFF"
    }
    
    override func add(var list: [Node])->[Node] {
        println("FLASHOFF : add")
        if !list.isEmpty {
            self.leftChild=list.removeAtIndex(0)
        }
        println("FLASHOFF : end add")
        return list
    }
    
    func toggleFlash() {
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        if (device.hasTorch) {
            device.lockForConfiguration(nil)
            let torchOn = !device.torchActive
            device.torchMode = AVCaptureTorchMode.Off
            device.unlockForConfiguration()
        }
    }
    
    override func run() {
        toggleFlash()
        if let defNode=self.leftChild{
            defNode.run()
        }
        else{
            return
        }
    }
    
}
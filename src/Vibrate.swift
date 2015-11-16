//
//  Vibrate.swift
//  CodeBuilderApp
//
//  Created by Geneviève Robin on 10/12/2014.
//  Copyright (c) 2014 Geneviève Robin. All rights reserved.
//

import Foundation
import UIKit
import AudioToolbox

class Vibrate:Node{
    
    var vibrations:Int?
    //number of repetitions of vibrations, max 20
    
    override init() {
        super.init()
        self.name="vibrate"
        self.vibrations=3
    }
    
    override func add(var list: [Node])->[Node] {
        println("VIBRATE : add")
        if !list.isEmpty {
            self.leftChild=list.removeAtIndex(0)
        }
        println("VIBRATE : end add ")
        return list
    }
    
    override func run(){
        println("VIBRATE : running ")
        assert(vibrations>0 && vibrations<=20)
        for var i=0 ; i<vibrations ; i++ {
            println("VIBRATE : for \(i) ")
            sleep(UInt32(1))
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
        if let defNext=leftChild{
            println("VIBRATE : defNext.run() ")
            defNext.run()
        }
        else{
            return
        }
    }
}

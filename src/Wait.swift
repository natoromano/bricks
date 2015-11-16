//
//  Wait.swift
//  CodeBuilderApp
//
//  Created by Geneviève Robin on 10/12/2014.
//  Copyright (c) 2014 Geneviève Robin. All rights reserved.
//

import Foundation
import UIKit

class Wait: Node {
    
    //var time:Int?
    //time in seconds
    
    override init() {
        super.init()
        self.name="wait"
    }
     
    override func add(var list: [Node])->[Node] {
        println("WAIT : starting add ")
        if !list.isEmpty {
            self.leftChild=list.removeAtIndex(0)
        }
        println("WAIT : end add ")
        return list
    }
    
    override func run() {
        println("WAIT : running ")
        let defTime = 5 //(time>20) ? 20 : time
        println("WAIT : sleeping ")
        sleep(UInt32(defTime/*!*/))
        println("WAIT : end sleep ")
        if let defLeft=self.leftChild{
            println("WAIT : defLeft.run() ")
            self.leftChild!.run()
        }
        else {
            return
        }
    }
    
}
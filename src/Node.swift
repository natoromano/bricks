//
//  Node.swift
//  CodeBuilderApp
//
//  Created by Geneviève Robin on 04/12/2014.
//  Copyright (c) 2014 Geneviève Robin. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class Node {
    
    var key:Int?
    var name:String?
    var leftChild:Node?
    var rightChild:Node?
    
    init()  {
        self.leftChild = nil
        self.rightChild = nil
        self.key = nil
        self.name = nil
    }
    
    func add(list:[Node])->[Node]{
        println("NODE : add")
        return list
    }
    
    
    func run() {
        println("NODE : run")
    }
    
    func next()->Node {
        var current = self
        while (current.leftChild != nil) {
            current=current.leftChild!
        }
        return current
    }
    
}



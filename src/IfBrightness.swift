//
//  IfBrightness.swift
//  CodeBuilderApp
//
//  Created by Geneviève Robin on 10/12/2014.
//  Copyright (c) 2014 Geneviève Robin. All rights reserved.
//

import Foundation
import UIKit

class IfBrightness:Node {
    
    var condition:Bool
    // <= -> true ; > -> false
    var brightness:Int
    var min:Int?
    
    override init() {
        self.condition = false
        self.brightness=5
        self.min=0
        super.init()
        self.name="IFBrightness"
    }
    
    override func run() {
        println("-> IFBRIGHTNESS : running")
        let CurrentBrightness = UIScreen.mainScreen().brightness
        println(Float(brightness)/10.0)
        println(CurrentBrightness)
        self.condition = (CGFloat(Float(brightness)/10.0)>CurrentBrightness)
        if (self.condition==true) {
            if let defLeft = self.leftChild{
                println("IFBRIGHTNESS : defLeft.run()")
                defLeft.run()
            }
        }
        else {
            if let defRight = self.rightChild{
                println(" IFBRIGHTNESS : defRight.run()")
                defRight.run()
            }
        }
    }
    
    override func add(var list:[Node])->[Node] {
        println("IFBRIGHTNESS : starting add")
        // Initialize Node on which to add the list
        var current:Node=self
        
        // Stopping condition
        while !list.isEmpty{
            // Initialize first block to add
            var firstBlock=list.removeAtIndex(0)
            
            if firstBlock.name=="then"{
                println("IFBRIGHTNESS : starting then blocks")
                while firstBlock.name != "else" && firstBlock.name != "end" && !list.isEmpty{
                    println("IFBRIGHTNESS : then block : " + firstBlock.name!)
                    current.leftChild = firstBlock
                    current = firstBlock
                    firstBlock = list.removeAtIndex(0)
                }
                var lastThen = current
                
                current = self
                if !list.isEmpty {
                    if firstBlock.name=="else"{
                        for node in list {
                            println(node.name)
                        }
                        println("IFBRIGHTNESS : starting else blocks")
                        current.rightChild = firstBlock
                        current = firstBlock
                        while firstBlock.name != "end" && !list.isEmpty{
                            println("IFBRIGHTNESS : else block : " + firstBlock.name!)
                            current.leftChild = firstBlock
                            current = firstBlock
                            firstBlock = list.removeAtIndex(0)
                        }

                    } else{
                        current.leftChild=list.removeAtIndex(0)
                    }
                    if !list.isEmpty{
                        var next = list.removeAtIndex(0)
                        current.leftChild = next
                        lastThen.leftChild = next
                    }
                }
                
            }
            
        }
        println("IFBRIGHTNESS : end add")
        return list
    }
    
    
}

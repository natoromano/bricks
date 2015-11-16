//
//  If.swift
//  CodeBuilderApp
//
//  Created by Geneviève Robin on 04/12/2014.
//  Copyright (c) 2014 Geneviève Robin. All rights reserved.
//

import Foundation
import UIKit

class IfTime:Node {
    
    var condition:Bool?
    // <= -> true ; > -> false
    var hour:Int?
    var min:Int?
    
    override init() {
        super.init()
        self.condition = false
        self.hour=10
        self.min=0
        self.name="IFTime"
    }
    
    override func run() {
        println("IFTIME : running")
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
        let hour = components.hour
        let minutes = components.minute
        
        println(hour)
        println(minutes)
        
        if self.hour>hour{
            println("VRAI")
            self.condition = true
        }
        else if self.hour==hour && self.min>minutes{
            println("VRAI")
            self.condition = true
        }
        else {
            println("FAUX")
            self.condition = false
        }
        if (self.condition == true) {
            if let defLeft = leftChild{
                println("IFTIME : defLeft.run()")
                defLeft.run()
            }
        }
        else {
            if let defRight = rightChild{
                println("IFTIME : defRight.run()")
                defRight.run()
            }
        }
    }
    
    override func add(var list:[Node])->[Node] {
        println("IFTIME : starting add")
        // Initialize Node on which to add the list
        var current:Node=self
        
        // Stopping condition
        while !list.isEmpty{
            // Initialize first block to add
            var firstBlock=list.removeAtIndex(0)
            
            if firstBlock.name=="then"{
                println("IFTIME : starting then blocks")
                while firstBlock.name != "else" && firstBlock.name != "end" && !list.isEmpty{
                    println("IFTIME : then block : " + firstBlock.name!)
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
                        println("IFTIME : starting else blocks")
                        current.rightChild = firstBlock
                        current = firstBlock
                        while firstBlock.name != "end" && !list.isEmpty{
                            println("IFTIME : else block : " + firstBlock.name!)
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
        println("IFTIME : end add")
        return list
    }

    
}
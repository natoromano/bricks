//
//  Brightness.swift
//  CodeBuilderApp
//
//  Created by Geneviève Robin on 10/12/2014.
//  Copyright (c) 2014 Geneviève Robin. All rights reserved.
//

import Foundation
import UIKit

class Brightness: Node {
    
    var brightness:Int?
    //Brightness between 0 and 10
    
    override init() {
        super.init()
        self.brightness=5
        self.name="brightness"
    }
    
    override func add(var list: [Node])->[Node] {
        if !list.isEmpty {
            self.leftChild=list.removeAtIndex(0)
        }
        return list
    }
    
    override func run(){
        assert(brightness>=0 && brightness<=10)
        
        //UIScreen.mainScreen().brightness = CGFloat(Float(brightness)/10.0)
        UIScreen.mainScreen().brightness = CGFloat(1.0)
        
        
        
        if let defNode=self.leftChild{
            defNode.run()
        }
        else{
            return
        }
    }
    
}
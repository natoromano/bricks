//
//  File.swift
//  CodeBuilderApp
//
//  Created by Geneviève Robin on 10/12/2014.
//  Copyright (c) 2014 Geneviève Robin. All rights reserved.
//

import Foundation

class Then: Node{
    
    override init(){
        super.init()
        self.name="then"
    }
    
    override func add(var list: [Node])->[Node] {
        println("THEN : add")
        if !list.isEmpty {
            self.leftChild=list.removeAtIndex(0)
        }
        println("THEN : end add ")
        return list
    }
    
    override func run(){
        println("THEN : run")
        if self.leftChild != nil {
            println("THEN : leftChild!.run")
            self.leftChild!.run()
        }
    }
    
}
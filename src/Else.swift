//
//  Else.swift
//  CodeBuilderApp
//
//  Created by Geneviève Robin on 10/12/2014.
//  Copyright (c) 2014 Geneviève Robin. All rights reserved.
//


class Else:Node{
    
    override init() {
        super.init()
        self.name="else"
    }
    
    override func add(var list: [Node])->[Node] {
        if !list.isEmpty {
            self.leftChild=list.removeAtIndex(0)
        }
        return list
    }
    
    override func run(){
        if let defNode=self.leftChild{
            defNode.run()
        }
        else{
            return
        }
    }
    
}

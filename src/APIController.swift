//
//  APIController.swift
//
//  Created by Nathanaël Romano on 25/11/2014.
//  Copyright (c) 2014 Nathanaël Romano. All rights reserved.
//

import Foundation
protocol APIControllerProtocol {
    func didReceiveAPIResults(results: NSArray)
}

class APIController {
    
    var delegate: APIControllerProtocol
    
    init(delegate: APIControllerProtocol) {
        self.delegate = delegate
    }
    
    func get(path: String) {
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
            println("Task completed")
            if(error != nil) {
                // If there is an error in the web request, print it to the console
                println(error.localizedDescription)
            }
            var err: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSArray
            if(err != nil) {
                // If there is an error parsing JSON, print it to the console
                println("JSON Error \(err!.localizedDescription)")
            }
            self.delegate.didReceiveAPIResults(jsonResult)
            
        })
        task.resume()
    }
    
    func getBlocks() {
        let urlPath = "https://api-codebuilder.herokuapp.com/blocks.json"
        get(urlPath)
    }
    
}
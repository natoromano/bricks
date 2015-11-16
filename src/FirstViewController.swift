//
//  FirstViewController.swift
//  interne
//
//  Created by Nathanaël Romano on 07/12/2014.
//  Copyright (c) 2014 Nathanaël Romano. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, APIControllerProgProtocol {
    
    @IBOutlet var appTableView: UITableView!
    
    var programme : Programme = Programme()
    var api : APIControllerProg?
    let kCellIdentifier: String = "SearchResultCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api = APIControllerProg(delegate: self)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        api!.getBlocks()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return programme.blocks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as? UITableViewCell
        let block = self.programme.blocks[indexPath.row]
        if var labeltext = cell?.textLabel {
            labeltext.text = block.indent(self.programme.blocks,j: indexPath.row) + block.name
        }
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        var id = self.programme.blocks[indexPath.row].id
        if editingStyle == UITableViewCellEditingStyle.Delete {
            programme.blocks.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            var apiURL = "http://api-codebuilder.herokuapp.com/programmes/"+String(id)
            api!.delete(id,url: apiURL)
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
        })
    }
    
    func didReceiveAPIResults(results: NSArray) {
        dispatch_async(dispatch_get_main_queue(), {
            self.programme.blocks = Programme.blockswithJSON(results)
            println("coucou")
            self.appTableView!.reloadData()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "deleteEntry") {
            var keepView: UITabBarController = segue.destinationViewController as UITabBarController
            var blockIndex = appTableView!.indexPathForSelectedRow()!.row
            var selectedBlock = self.programme.blocks[blockIndex]
            var apiURL = "http://api-codebuilder.herokuapp.com/programmes/"+String(selectedBlock.id)
            println(apiURL)
            api!.delete(selectedBlock.id,url: apiURL)
        }
        else {
            var executeViewController: ExecuteViewController = segue.destinationViewController as ExecuteViewController
            executeViewController.programme = self.programme
        }
    }
    
    
    @IBAction func refreshButton(sender: UIButton) {
        api!.getBlocks()
        self.appTableView!.reloadData()
    }
    
}
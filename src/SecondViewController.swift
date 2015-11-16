
import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, APIControllerProtocol, APIControllerProgProtocol {
    
    @IBOutlet var appTableView: UITableView!
    
    var blocks = [Block]()
    var api : APIController?
    var api2 : APIControllerProg?
    let kCellIdentifier: String = "SearchResultCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api = APIController(delegate: self)
        api2 = APIControllerProg(delegate: self)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        api!.getBlocks();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blocks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as? UITableViewCell
        
        let block = self.blocks[indexPath.row]
        
        if var labeltext = cell?.textLabel {
            labeltext.text = block.name
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
        })
    }
    
    func didReceiveAPIResults(results: NSArray) {
        dispatch_async(dispatch_get_main_queue(), {
            self.blocks = Block.blocksWithJSON(results,cat: "logique")
            self.appTableView!.reloadData()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var addProgram: UITabBarController = segue.destinationViewController as UITabBarController
        var blockIndex = appTableView!.indexPathForSelectedRow()!.row
        var selectedBlock = self.blocks[blockIndex]
        println(blockIndex)
        api2!.post(selectedBlock.toDict(),url: "http://api-codebuilder.herokuapp.com/programmes")
    }
    
}
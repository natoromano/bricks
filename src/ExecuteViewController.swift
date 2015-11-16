import UIKit

class ExecuteViewController: UIViewController {
    
    var programme = Programme()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    override func viewDidAppear(animated: Bool) {
        self.programme.build()
        self.programme.root.run()
        let alert = UIAlertView()
        alert.title = "Terminé !"
        alert.message = "Bravo, le programme s'est correctement exécuté."
        alert.addButtonWithTitle("Cool !")
        alert.show()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
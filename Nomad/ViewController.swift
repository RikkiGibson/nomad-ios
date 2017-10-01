import UIKit

class ViewController: UIViewController {
    
    let browser = NetServiceBrowser()
    let delegate = NomadNetBrowserDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.browser.delegate = self.delegate
        self.browser.searchForServices(ofType: "_http._tcp.", inDomain: "local.")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

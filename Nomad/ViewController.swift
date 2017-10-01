import UIKit

let DOMAIN = "local"
let TYPE = "_nomad._tcp."
let SERVICE_NAME = "nomad"
let SERVICE_PORT: Int32 = 6543

class ViewController: UIViewController, NetServiceDelegate {
    
    let netService = NetService(
        domain: DOMAIN,
        type: TYPE,
        name: SERVICE_NAME,
        port: SERVICE_PORT)
    
    let browser = NetServiceBrowser()
    let delegate = NomadNetBrowserDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        netService.delegate = self
        netService.publish()
        
        browser.delegate = delegate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // - MARK: NetServiceDelegate
    func netServiceDidPublish(_ sender: NetService) {
        DispatchQueue.main.async {
            self.browser.searchForServices(ofType: TYPE, inDomain: "")
        }
    }
}

class NomadNetBrowserDelegate: NSObject, NetServiceBrowserDelegate {
    func netServiceBrowserWillSearch(_ browser: NetServiceBrowser) {
        print("Will search")
    }
    
    func netServiceBrowserDidStopSearch(_ browser: NetServiceBrowser) {
        print("Stopped search")
    }
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
        print(service)
    }
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didFindDomain domainString: String, moreComing: Bool) {
        print(domainString)
    }
}

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

class NomadNetServiceDelegate: NSObject, NetServiceDelegate {
    func netServiceDidResolveAddress(_ sender: NetService) {
        var addr: sockaddr
        var pointer = UnsafeMutablePointer(&addr)
        sender.addresses![0].copyBytes(to: pointer)
        
        guard let hostName = sender.hostName,
            let url = URL(string: "http://" + hostName + ":" + String(sender.port)) else {
                
                fatalError()
        }
        
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.httpBody = "http://google.com".data(using: .utf8)
        
        URLSession.shared.dataTask(with: req, completionHandler: { (data, res, err) in
            if let err = err {
                print(err)
            }
        }).resume()
    }
}

let netServiceDelegate = NomadNetServiceDelegate()
var services: [NetService] = []

class NomadNetBrowserDelegate: NSObject, NetServiceBrowserDelegate {
    func netServiceBrowserWillSearch(_ browser: NetServiceBrowser) {
        print("Will search")
    }
    
    func netServiceBrowserDidStopSearch(_ browser: NetServiceBrowser) {
        print("Stopped search")
    }
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
        service.delegate = netServiceDelegate
        service.resolve(withTimeout: 10000)
        services.append(service)
        print(service)
    }
}

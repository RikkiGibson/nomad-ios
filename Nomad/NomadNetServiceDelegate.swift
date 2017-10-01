import Foundation

class NomadNetServiceDelegate: NSObject, NetServiceDelegate {
    /** The URL to be sent to through the Nomad service. */
    var targetURL: URL?
    var onComplete: (() -> Void)?
    
    func netServiceDidResolveAddress(_ sender: NetService) {
        guard let hostName = sender.hostName,
            let serviceURL = URL(string: "http://" + hostName + ":" + String(sender.port)) else {
                
                fatalError()
        }
        
        var req = URLRequest(url: serviceURL)
        req.httpMethod = "POST"
        if let targetURL = self.targetURL {
            req.httpBody = targetURL.absoluteString.data(using: .utf8)
        }
        
        URLSession.shared.dataTask(with: req, completionHandler: { (data, res, err) in
            if let err = err {
                print(err)
            }
            if let onComplete = self.onComplete {
                onComplete()
            }
        }).resume()
    }
}

class NomadNetBrowserDelegate: NSObject, NetServiceBrowserDelegate {
    let netServiceDelegate = NomadNetServiceDelegate()
    var services: [NetService] = []
    
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

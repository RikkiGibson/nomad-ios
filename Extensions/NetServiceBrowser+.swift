import Foundation

extension NetServiceBrowser {
    func searchForHTTPService() {
        searchForServices(ofType: "_http._tcp.", inDomain: "local.")
    }
}

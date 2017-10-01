import UIKit

extension NSItemProvider {
    var hasURL: Bool {
        return hasItemConformingToTypeIdentifier("public.url")
    }
    
    func loadURL(callback: @escaping (URL?, Error?) -> Void) {
        loadItem(forTypeIdentifier: "public.url", options: nil) { (res, err) in
            callback(res as? URL, err)
        }
    }
}

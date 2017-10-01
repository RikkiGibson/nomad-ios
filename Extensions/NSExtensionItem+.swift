import UIKit

extension NSExtensionItem {
    var attachmentsTyped: [NSItemProvider] {
        return self.attachments as! [NSItemProvider]
    }
}

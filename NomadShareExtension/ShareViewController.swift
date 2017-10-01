//
//  ShareViewController.swift
//  NomadShareExtension
//
//  Created by Rikki Gibson on 10/1/17.
//  Copyright © 2017 Rikki Gibson. All rights reserved.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {
    let browser = NetServiceBrowser()
    let browserDelegate = NomadNetBrowserDelegate()
    
    override func viewDidLoad() {
        browser.delegate = browserDelegate
        browserDelegate.netServiceDelegate.onComplete = {
            self.extensionContext!.completeRequest(returningItems: nil, completionHandler: nil)
        }
    }

    override func isContentValid() -> Bool {
        guard let extensionContext = extensionContext else {
            return false
        }
        
        let items = extensionContext.inputItemsTyped
        if items.count != 1 {
            return false
        }
        
        let attachments = items[0].attachmentsTyped
        if attachments.count != 1 {
            return false
        }
        
        return attachments[0].hasURL
    }

    override func didSelectPost() {
        let attachment = extensionContext!.inputItemsTyped[0].attachmentsTyped[0]
        attachment.loadURL { url, err in
            if let err = err {
                print(err)
            }
            
            self.browserDelegate.netServiceDelegate.targetURL = url
            self.browser.searchForHTTPService()
        }
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }

}

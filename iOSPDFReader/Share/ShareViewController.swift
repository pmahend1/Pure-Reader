//
//  ShareViewController.swift
//  Share
//
//  Created by Prateek Mahendrakar on 1/27/24.
//

import PDFKit
import Social
import UIKit
import UniformTypeIdentifiers
import SwiftUI

class ShareViewController: SLComposeServiceViewController {
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.

        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Ensure access to extensionItem and itemProvider
        guard let extensionItem = extensionContext?.inputItems.first as? NSExtensionItem,
              let itemProvider = extensionItem.attachments?.first else {
            close()
            return
        }

        print(itemProvider)
        // Check type identifier
        let pdfType = UTType.pdf.identifier
        if itemProvider.hasItemConformingToTypeIdentifier(pdfType) {
            // Load the item from itemProvider
            itemProvider.loadItem(forTypeIdentifier: pdfType, options: nil) { pdf, error in
                if let error {
                    print(error)
                    self.close()
                    return
                }

                if let url = pdf as? URL {
                    DispatchQueue.main.async {
                        // host the SwiftU view
                        let contentView = UIHostingController(rootView: PDFDisplayView(pdfFile: PDFFile(url: url)))
                        self.addChild(contentView)
                        self.view.addSubview(contentView.view)

                        // set up constraints
                        contentView.view.translatesAutoresizingMaskIntoConstraints = false
                        contentView.view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
                        contentView.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
                        contentView.view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
                        contentView.view.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
                    }
                } else {
                    self.close()
                    return
                }
            }
        } else {
            close()
            return
        }
    }

    func close() {
        extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }
}

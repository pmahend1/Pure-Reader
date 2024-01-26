//
//  PDFFile.swift
//  iOSPDFReader
//
//  Created by Prateek Mahendrakar on 1/25/24.
//

import Foundation

struct PDFFile {
    var fileName: String {
        get {
            return url.lastPathComponent
        }
    }
    var url: URL

    init(url: URL) {
        self.url = url
    }
}

//
//  PDFFile.swift
//  Share
//
//  Created by Prateek Mahendrakar on 1/27/24.
//

import Foundation

struct PDFFile {
    var fileName: String {
        return url.lastPathComponent
    }

    var url: URL

    init(url: URL) {
        self.url = url
    }
}

//
//  PdfThumbnail.swift
//  iOSPDFReader
//
//  Created by Prateek Mahendrakar on 6/22/24.
//

import Foundation
import QuickLookThumbnailing

struct PDFThumbnail: Hashable {
    public var fileName: String
    public var thumbNail: QLThumbnailRepresentation
    public var url: URL? {
        return URL(filePath: fileName)
    }
}

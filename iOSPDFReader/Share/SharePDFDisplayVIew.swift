//
//  SharePDFDisplayVIew.swift
//  Share
//
//  Created by Prateek Mahendrakar on 1/27/24.
//

import SwiftUI

struct SharePDFDisplayVIew: View {
    @StateObject private var viewModel: PDFViewModel
    init(pdfFile: PDFFile?) {
        _viewModel = StateObject(wrappedValue: .init(pdfFile: pdfFile))
    }

    var body: some View {
        if let pdfFile = viewModel.pdfFile {
            PDFControlView(url: pdfFile.url)
                .navigationTitle("\(pdfFile.fileName)")
        } else {
            Text("Invalid URL")
        }
    }
}

#Preview {
    SharePDFDisplayVIew(pdfFile: PDFFile(url: URL(filePath: "somepath")))
}

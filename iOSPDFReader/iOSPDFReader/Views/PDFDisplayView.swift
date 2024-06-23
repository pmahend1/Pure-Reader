//
//  PDFView.swift
//  iOSPDFReader
//
//  Created by Prateek Mahendrakar on 1/25/24.
//

import PDFKit
import SwiftUI

struct PDFDisplayView: View {
    @StateObject private var viewModel: PDFViewModel
    init(pdfFile: PDFFile?) {
        _viewModel = StateObject(wrappedValue: .init(pdfFile: pdfFile))
    }

    var body: some View {
        if let pdfFile = viewModel.pdfFile {
            PDFControlView(url: pdfFile.url)
                .navigationTitle("\(pdfFile.fileName)")
                .navigationBarTitleDisplayMode(.inline)
        } else {
            Text("Invalid URL")
        }
    }
}

#Preview {
    PDFDisplayView(pdfFile: PDFFile(url: URL(filePath: "somepath")))
}

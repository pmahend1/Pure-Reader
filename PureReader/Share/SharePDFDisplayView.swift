//
//  SharePDFDisplayVIew.swift
//  Share
//
//  Created by Prateek Mahendrakar on 1/27/24.
//

import PDFKit
import SwiftUI

struct SharePDFDisplayView: View {
    @StateObject private var viewModel: PDFViewModel
    @State private var pdfDocument: PDFDocument?
    private var shareViewController: ShareViewController

    init(pdfFile: PDFFile?, shareViewController: ShareViewController) {
        _viewModel = StateObject(wrappedValue: .init(pdfFile: pdfFile))
        self.shareViewController = shareViewController
    }

    var body: some View {
        if let pdfFile = viewModel.pdfFile {
            NavigationStack {
                PDFControlView(pdfDocument: pdfDocument, searchResults: viewModel.searchResults)
                    .navigationTitle("\(pdfFile.fileName)")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        Button("Close", systemImage: "xmark.circle.fill") {
                            shareViewController.close()
                        }
                    }
                    .onAppear {
                        pdfDocument = PDFDocument(url: pdfFile.url)
                    }
            }

        } else {
            Text("Invalid URL")
        }
    }
}

#Preview {
    SharePDFDisplayView(pdfFile: PDFFile(url: URL(filePath: "somepath")), shareViewController: .init())
}

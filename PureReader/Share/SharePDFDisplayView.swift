//
//  SharePDFDisplayVIew.swift
//  Share
//
//  Created by Prateek Mahendrakar on 1/27/24.
//

import SwiftUI

struct SharePDFDisplayView: View {
    @StateObject private var viewModel: PDFViewModel

    private var shareViewController: ShareViewController

    init(pdfFile: PDFFile?, shareViewController: ShareViewController) {
        _viewModel = StateObject(wrappedValue: .init(pdfFile: pdfFile))
        self.shareViewController = shareViewController
    }

    var body: some View {
        if let pdfFile = viewModel.pdfFile {
            NavigationStack {
                PDFControlView(url: pdfFile.url)
                    .navigationTitle("\(pdfFile.fileName)")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        Button("Close", systemImage: "xmark.circle.fill") {
                            shareViewController.close()
                        }
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

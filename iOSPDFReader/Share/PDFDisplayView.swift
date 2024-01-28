//
//  PDFDisplayView.swift
//  Share
//
//  Created by Prateek Mahendrakar on 1/27/24.
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
            VStack {
                Text("PDF Reader")
                    .font(.title2)
                    .foregroundStyle(.blue)
                Text("\(viewModel.pdfFile?.fileName ?? "Shared File")")
                PDFControlView(url: pdfFile.url)
            }

        } else {
            Text("Invalid URL")
        }
    }
}

#Preview {
    PDFDisplayView(pdfFile: PDFFile(url: URL(filePath: "somepath")))
}

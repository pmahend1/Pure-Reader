//
//  PDFView.swift
//  PureReader
//
//  Created by Prateek Mahendrakar on 1/25/24.
//

import PDFKit
import SwiftUI

struct PDFDisplayView: View {
    @StateObject private var viewModel: PDFViewModel
    @State private var searchResults = [PDFSelection]()
    @State private var pdfDocument: PDFDocument?

    init(pdfFile: PDFFile?) {
        _viewModel = StateObject(wrappedValue: .init(pdfFile: pdfFile))
    }

    var body: some View {
        if let pdfFile = viewModel.pdfFile {
            VStack {
                HStack {
                    TextField("Search", text: $viewModel.searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Button("Search", systemImage: "magnifyingglass.circle.fill") {
                        searchPDF()
                    }
                    .padding()
                }

                PDFControlView(pdfDocument: pdfDocument, searchResults: searchResults)
                    .onAppear {
                        pdfDocument = PDFDocument(url: pdfFile.url)
                    }
                    .navigationTitle("\(pdfFile.fileName)")
                    .navigationBarTitleDisplayMode(.inline)
            }

        } else {
            Text("Invalid URL")
        }
    }

    func searchPDF() {
        guard let document = pdfDocument else { return }
        searchResults.removeAll()

        let selections = document.findString(viewModel.searchText, withOptions: .caseInsensitive)
        searchResults.append(contentsOf: selections)
        
    }
}

#Preview {
    PDFDisplayView(pdfFile: PDFFile(url: URL(filePath: "somepath")))
}

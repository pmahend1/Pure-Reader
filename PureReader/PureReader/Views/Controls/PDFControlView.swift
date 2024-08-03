//
//  PDFView.swift
//  PureReader
//
//  Created by Prateek Mahendrakar on 1/25/24.
//

import PDFKit
import SwiftUI

struct PDFControlView: UIViewRepresentable {
    var pdfDocument: PDFDocument?
    var searchResults: [PDFSelection]

    func makeUIView(context _: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = pdfDocument
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ pdfView: PDFView, context _: Context) {
        pdfView.document = pdfDocument
        pdfView.updateFocusIfNeeded()
        if #available(iOS 17.0, *) {
            pdfView.updateTraitsIfNeeded()
        }
        pdfView.updateConstraintsIfNeeded()
        pdfView.layoutIfNeeded()
        highlightSearchResults(in: pdfView)
    }

    private func highlightSearchResults(in pdfView: PDFView) {
        for selection in searchResults {
            selection.color = .yellow
            pdfView.setCurrentSelection(selection, animate: true)
        }
    }
}

//
//  PDFView.swift
//  PureReader
//
//  Created by Prateek Mahendrakar on 1/25/24.
//

import PDFKit
import SwiftUI

struct PDFControlView: UIViewRepresentable {
    
    let url: URL

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: url)
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ pdfView: PDFView, context: Context) {
        // Update pdf if needed
        pdfView.document = PDFDocument(url: url)
        
        pdfView.updateFocusIfNeeded()
        if #available(iOS 17.0, *) {
            pdfView.updateTraitsIfNeeded()
        }
        pdfView.updateConstraintsIfNeeded()
        pdfView.layoutIfNeeded()
    }
}


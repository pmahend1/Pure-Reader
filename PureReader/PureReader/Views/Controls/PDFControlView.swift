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

    @State var text: String = ""

    private func updateText(pdfView: PDFView) {
        if let pdfDocUnwrap = pdfView.document {
            let pageCount = pdfDocUnwrap.pageCount
            let documentContent = NSMutableAttributedString()

            for i in 0 ..< pageCount {
                guard let page = pdfDocUnwrap.page(at: i) else { continue }
                guard let pageContent = page.attributedString else { continue }
                documentContent.append(pageContent)
            }
            text = "\(documentContent)"
        }
    }

    func makeUIView(context _: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: url)
        pdfView.autoScales = true
        updateText(pdfView: pdfView)
        return pdfView
    }

    func updateUIView(_ pdfView: PDFView, context _: Context) {
        pdfView.document = PDFDocument(url: url)
        updateText(pdfView: pdfView)
        pdfView.updateFocusIfNeeded()
        if #available(iOS 17.0, *) {
            pdfView.updateTraitsIfNeeded()
        }
        pdfView.updateConstraintsIfNeeded()
        pdfView.layoutIfNeeded()
    }
}

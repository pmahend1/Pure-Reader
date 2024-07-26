//
//  PDFThumbView.swift
//  PureReader
//
//  Created by Prateek Mahendrakar on 7/26/24.
//
import PDFKit
import SwiftUI

struct PDFThumbView: UIViewRepresentable {
    var pdfView: PDFView

    func makeUIView(context _: Context) -> PDFThumbnailView {
        let thumbnail = PDFThumbnailView()
        thumbnail.pdfView = pdfView
        thumbnail.thumbnailSize = CGSize(width: 100, height: 100)
        thumbnail.layoutMode = .horizontal
        return thumbnail
    }

    func updateUIView(_: PDFThumbnailView, context _: Context) {
        let thumbnail = PDFThumbnailView()
        thumbnail.translatesAutoresizingMaskIntoConstraints = false
        pdfView.addSubview(thumbnail)

        thumbnail.leadingAnchor.constraint(equalTo: pdfView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        thumbnail.trailingAnchor.constraint(equalTo: pdfView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        thumbnail.bottomAnchor.constraint(equalTo: pdfView.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

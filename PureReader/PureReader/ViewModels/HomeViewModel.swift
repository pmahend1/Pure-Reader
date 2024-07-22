//
//  HomeViewModel.swift
//  PureReader
//
//  Created by Prateek Mahendrakar on 1/25/24.
//

import Foundation
import QuickLookThumbnailing

class HomeViewModel: BaseViewModel {
    // MARK: - Properties

    @Published var fileName = ""
    @Published var isFileImportOpen = false
    @Published var isPDFOpen = false
    @Published var pdfFile: PDFFile? = nil
    @Published var thumbnails: [PDFThumbnail] = .init()

    public func getPdfs() -> [PDFFile] {
        var pdfFiles = [PDFFile]()

        do {
            let urls = try FileManager.default.contentsOfDirectory(at: URL.documentsDirectory, includingPropertiesForKeys: nil)
            for url in urls {
                if pdfFiles.count < 8 { // max 8 for performance
                    pdfFiles.append(PDFFile(url: url))
                }
            }

        } catch {
            print(error)
        }
        return pdfFiles
    }
}

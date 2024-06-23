//
//  HomeViewModel.swift
//  iOSPDFReader
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
    @Published var thumbnails: Array<PDFThumbnail> = .init()

    public func getPdfs() -> [PDFFile] {
        var pdfFiles = [PDFFile]()

        do {
            let urls = try FileManager.default.contentsOfDirectory(at: URL.downloadsDirectory, includingPropertiesForKeys: nil)
            for url in urls {
                print(url)
                pdfFiles.append(PDFFile(url: url))
            }

        } catch {
            print(error)
        }
        return pdfFiles
    }

    
}

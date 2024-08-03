//
//  PDFViewModel.swift
//  PureReader
//
//  Created by Prateek Mahendrakar on 1/25/24.
//

import Foundation
import PDFKit

final class PDFViewModel: BaseViewModel {
    @Published var pdfFile : PDFFile?
    @Published var searchText: String = ""
    @Published var shouldDisplaySearch: Bool = false
    @Published var searchResults: [PDFSelection] = [PDFSelection]()
    
    init(pdfFile: PDFFile?) {
        self.pdfFile = pdfFile
    }
}

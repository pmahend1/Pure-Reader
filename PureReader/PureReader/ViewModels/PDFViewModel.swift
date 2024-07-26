//
//  PDFViewModel.swift
//  PureReader
//
//  Created by Prateek Mahendrakar on 1/25/24.
//

import Foundation

final class PDFViewModel: BaseViewModel {
    @Published var pdfFile : PDFFile?
    @Published var searchText: String = ""
    
    init(pdfFile: PDFFile?) {
        self.pdfFile = pdfFile
    }
}

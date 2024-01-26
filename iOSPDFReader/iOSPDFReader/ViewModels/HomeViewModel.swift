//
//  HomeViewModel.swift
//  iOSPDFReader
//
//  Created by Prateek Mahendrakar on 1/25/24.
//

import Foundation

class HomeViewModel: BaseViewModel {
    // MARK: - Properties
    @Published var fileName = ""
    @Published var isFileImportOpen = false
    @Published var isPDFOpen = false
    @Published var pdfFile: PDFFile? = nil
    
}

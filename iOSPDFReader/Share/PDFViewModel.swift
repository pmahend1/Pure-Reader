//
//  PDFViewModel.swift
//  Share
//
//  Created by Prateek Mahendrakar on 1/27/24.
//

import Foundation

class BaseViewModel: ObservableObject {
    public var isBusy = false
}

final class PDFViewModel: BaseViewModel {
    @Published var pdfFile: PDFFile?

    init(pdfFile: PDFFile?) {
        self.pdfFile = pdfFile
    }
}

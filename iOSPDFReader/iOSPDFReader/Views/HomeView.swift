//
//  ContentView.swift
//  iOSPDFReader
//
//  Created by Prateek Mahendrakar on 1/25/24.
//

import PDFKit
import SwiftData
import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                Text(viewModel.fileName)
                
                Button {
                    viewModel.isFileImportOpen.toggle()
                } label: {
                    Text("Open a PDF file")
                }
            }
            .navigationDestination(isPresented: $viewModel.isPDFOpen) {
                PDFDisplayView(pdfFile: viewModel.pdfFile)
            }
            .fileImporter(isPresented: $viewModel.isFileImportOpen,
                          allowedContentTypes: [.pdf],
                          allowsMultipleSelection: false) { result in
                do {
                    let fileURLs = try result.get()
                    print(fileURLs)
                    if let fileURL = fileURLs.first {
                        let pdfFile = PDFFile(url: fileURL)
                        viewModel.pdfFile = pdfFile
                        viewModel.isPDFOpen = true
                        viewModel.fileName = pdfFile.fileName == "" ?  "file not available" : fileURL.lastPathComponent
                    }
                    
                } catch {
                    print("error reading file \(error.localizedDescription)")
                }
            }
        }
    }
}

#Preview {
    HomeView()
}

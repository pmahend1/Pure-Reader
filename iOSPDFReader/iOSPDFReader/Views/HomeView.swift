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
    @State var fileName = ""
    @State var openFile = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                Text(self.fileName)
                Button {
                    self.openFile.toggle()
                } label: {
                    Text("Open a PDF file")
                }
            }
            .fileImporter(isPresented: $openFile,
                          allowedContentTypes: [.pdf],
                          allowsMultipleSelection: false,
                          onCompletion: { result in
                              do {
                                  let fileURL = try result.get()
                                  print(fileURL)
                                  self.fileName = fileURL.first?.lastPathComponent ?? "file not available"
                              } catch {
                                  print("error reading file \(error.localizedDescription)")
                              }
                          })
        }
    }
}

#Preview {
    HomeView()
}

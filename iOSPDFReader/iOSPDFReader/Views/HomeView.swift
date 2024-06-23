//
//  ContentView.swift
//  iOSPDFReader
//
//  Created by Prateek Mahendrakar on 1/25/24.
//

import PDFKit
import QuickLookThumbnailing
import SwiftData
import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    let columns = [
        GridItem(.flexible(minimum: 100, maximum: 300)),
        GridItem(.flexible(minimum: 100, maximum: 300)),
    ]
    var body: some View {
        NavigationStack {
            HStack(alignment: .top) {
                VStack(alignment: .center, spacing: 20) {
                    Button {
                        viewModel.isFileImportOpen.toggle()
                    } label: {
                        Text(LocalizedStringKey("Open a PDF file"))
                    }
                    .padding(.all, 10)
                    .background(Color.accentColor, in: .rect(cornerSize: .init(width: 10.0, height: 10.0)))
                    .foregroundStyle(.white)
                    .padding(.top, 50)

                    if viewModel.thumbnails.isEmpty == false {
                        Text("Files in Documents")
                            .font(.title3)
                    }

                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(viewModel.thumbnails, id: \.fileName) { pdfThumbNail in
                            NavigationLink {
                                PDFDisplayView(pdfFile: PDFFile(url: pdfThumbNail.url!))
                            } label: {
                                VStack {
                                    Image(uiImage: pdfThumbNail.thumbNail.uiImage)
                                    if let url = pdfThumbNail.url {
                                        Text(url.lastPathComponent)
                                            .font(.footnote)
                                            .foregroundStyle(.white)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)

                    Spacer()
                }
            }

            .navigationTitle("PDF Reader")
            .navigationBarTitleDisplayMode(.automatic)
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
                        viewModel.fileName = pdfFile.fileName == "" ? "file not available" : fileURL.lastPathComponent
                    }

                } catch {
                    print("error reading file \(error.localizedDescription)")
                }
            }
            .onAppear {
                generateThumbnailRepresentations()
            }
        }
    }

    public func generateThumbnailRepresentations() {
        let files = viewModel.getPdfs()

        for pdfFile in files {
            let size = CGSize(width: 60, height: 90)
            let scale = UIScreen.main.scale

            // Create the thumbnail request.
            let request = QLThumbnailGenerator.Request(fileAt: pdfFile.url,
                                                       size: size,
                                                       scale: scale,
                                                       representationTypes: .all)

            // Retrieve the singleton instance of the thumbnail generator and generate the thumbnails.
            let generator = QLThumbnailGenerator.shared
            generator.generateRepresentations(for: request) { thumbnailOptional, type, error in
                DispatchQueue.main.async {
                    print("\(type)")
                    guard error == nil, let thumbNail = thumbnailOptional else { return }
                    let exists = viewModel.thumbnails.contains(where: { x in
                        x.fileName == pdfFile.fileName && x.thumbNail.type == .thumbnail
                    })

                    guard exists == false else { return }

                    let pdfThumbNail = PDFThumbnail(fileName: pdfFile.fileName,
                                                    thumbNail: thumbNail)

                    viewModel.thumbnails.removeAll { $0.fileName == pdfFile.fileName }

                    viewModel.thumbnails.append(pdfThumbNail)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}

//
//  PDFView.swift
//  final 2
//
//  Created by James Toh on 2/12/23.
//

import SwiftUI
import UniformTypeIdentifiers
import WebKit

class AttachmentManager: ObservableObject {
    @Published var attachments: [URL] = []

    func addAttachment(_ url: URL) {
        attachments.append(url)
    }
}

struct PDFView: View {
    @StateObject private var attachmentManager = AttachmentManager()
    @State private var isDocumentPickerPresented: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                Button("Import Attachment") {
                    isDocumentPickerPresented.toggle()
                }
                .fileImporter(
                    isPresented: $isDocumentPickerPresented,
                    allowedContentTypes: [.pdf],
                    allowsMultipleSelection: true
                ) { result in
                    do {
                        let urls = try result.get()
                        attachmentManager.attachments.append(contentsOf: urls)
                    } catch {
                        print("Error importing document: \(error)")
                    }
                }

                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(attachmentManager.attachments, id: \.self) { url in
                            NavigationLink(
                                destination: PDFViewer(pdfURL: url),
                                label: {
                                    Text(url.lastPathComponent)
                                }
                            )
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("PDF Viewer")
        }
        .environmentObject(attachmentManager)
    }
}

struct PDFViewer: View {
    let pdfURL: URL

    var body: some View {
        WebView(url: pdfURL)
            .navigationTitle(pdfURL.lastPathComponent)
    }
}

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

struct PDFView_Previews: PreviewProvider {
    static var previews: some View {
        PDFView()
    }
}


#Preview(body: {
    PDFView()
})

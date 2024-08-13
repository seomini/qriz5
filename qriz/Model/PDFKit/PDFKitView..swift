//
//  PDFKitView..swift
//  qriz
//
//  Created by mimi_0_0 on 2024/07/09.
//

import SwiftUI
import PDFKit

struct PDFKitView: View {
    let pdfURL: URL?
    
    var body: some View {
        if let pdfURL = pdfURL {
            PDFKitContentView(pdfURL: pdfURL)
        } else {
            Text("PDF 파일이 없습니다.")
                .foregroundColor(.black)
                .padding()
        }
    }
}

struct PDFKitContentView: UIViewRepresentable {
    let pdfURL: URL
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: pdfURL)
        pdfView.autoScales = true
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
        // 업데이트 로직이 필요한 경우에 여기에 추가합니다.
    }
}

//
//  ConceptBookMainView.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/07/03.
//

import SwiftUI
import PDFKit

struct ConceptBookMainView: View {
    @ObservedObject var conceptBookMainViewModel: ConceptBookMainViewModel
    
    var body: some View {
        ZStack {
            Color.customBackground.edgesIgnoringSafeArea(.all)
            VStack(spacing:0) {
                Spacer().frame(height: 1)
                TitleConceptBookView(topic: conceptBookMainViewModel.topic, subjectType: conceptBookMainViewModel.subjectType)
                
                PDFKitView(pdfURL: conceptBookMainViewModel.pdfURL)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.gray)
                
            }
            .navigationTitle(conceptBookMainViewModel.topic)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton()
                }
            }
        }
    }
}

// MARK: - TitleConceptBookView
struct TitleConceptBookView: View {
    let topic: String
    let subjectType: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                VStack(alignment: .leading) {
                    Text(subjectType.contains("SQL") ? "2과목" : "1과목")
                        .font(.system(size: 16))
                    Spacer().frame(height: 5)
                    Text(topic)
                        .font(.system(size: 16))
                }
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
        }
    }
}

// MARK: - Preview
struct ConceptBookMainView_Previews: PreviewProvider {
    static var previews: some View {
        ConceptBookMainView(conceptBookMainViewModel: ConceptBookMainViewModel(topic: "데이터모델의 이해", subjectType: "1과목"))
    }
}

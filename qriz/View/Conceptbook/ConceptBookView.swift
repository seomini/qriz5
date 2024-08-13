//
//  ConceptBookView.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/07/03.
//

import SwiftUI

struct ConceptBookView: View {
    @ObservedObject var conceptBookViewModel = ConceptBookViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.customBackground.edgesIgnoringSafeArea(.all)
                VStack {
                    CustomNavigationBar(
                        isDisplayLeftBtn: false,
                        isDisplayRightBtn: false,
                        isCenterTitle: true,
                        centerTitleType: .concept
                    )
                    ConceptBookMain(conceptBookViewModel: conceptBookViewModel)
                }
            }
        }
    }
}

//MARK: ConceptBookMain
struct ConceptBookMain: View {
    @ObservedObject var conceptBookViewModel: ConceptBookViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("1과목")
                    .font(.system(size: 18,weight: .bold))
                    .padding(.leading, 16)
                Text("데이터 모델링의 이해")
                    .font(.system(size: 16))
                    .padding(.leading, 16)
                HStack(spacing: 16) {
                    ForEach(conceptBookViewModel.subjects[0...1]) { subject in
                        NavigationLink(destination: ConceptBookDetailView(conceptBookDetailViewModel: ConceptBookDetailViewModel(subject: subject))) {
                            VStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(height: 160)
                                
                                Text("세부항목 \(subject.topics.count)개")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .padding(.bottom, 2)
                                Text(subject.name)
                                    .font(.system(size: 16))
                                    .foregroundColor(.gray)
                            }
                            .frame(width: 100)
                        }
                    }
                }
                .padding(.leading, 16)
                .padding(.trailing, 16)
                
                Text("2과목")
                    .font(.system(size: 18,weight: .bold))
                    .padding(.leading, 16)
                Text("SQL 기본 및 활용")
                    .font(.system(size: 16))
                    .padding(.leading, 16)
                
                HStack(spacing: 16) {
                    ForEach(conceptBookViewModel.subjects[2...4]) { subject in
                        NavigationLink(destination: ConceptBookDetailView(conceptBookDetailViewModel: ConceptBookDetailViewModel(subject: subject))) {
                            VStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(height: 160)
                                
                                Text("세부항목 \(subject.topics.count)개")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                                    .padding(.bottom, 2)
                                
                                Text(subject.name)
                                    .font(.system(size: 16))
                                    .foregroundColor(.gray)
                            }
                            .frame(width: 100)
                        }
                    }
                }
                .padding(.leading, 16)
                .padding(.trailing, 16)
            }
        }
    }
}

#Preview {
    ConceptBookView()
}


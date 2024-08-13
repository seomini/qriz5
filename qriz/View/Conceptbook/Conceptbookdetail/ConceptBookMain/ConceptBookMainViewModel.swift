//
//  ConceptBookMainViewModel.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/07/03.
//

import Foundation
import Combine

//class ConceptBookMainViewModel: ObservableObject {
//    @Published var topic: String
//    @Published var subjectType: String 
//    
//    init(topic: String, subjectType: String) {
//        self.topic = topic
//        self.subjectType = subjectType
//    }
//}
import SwiftUI

class ConceptBookMainViewModel: ObservableObject {
    @Published var topic: String
    @Published var subjectType: String
    @Published var pdfURL: URL? // PDF URL을 저장하는 속성
    
    init(topic: String, subjectType: String, pdfURL: URL? = nil) {
        self.topic = topic
        self.subjectType = subjectType
        self.pdfURL = pdfURL
    }
}

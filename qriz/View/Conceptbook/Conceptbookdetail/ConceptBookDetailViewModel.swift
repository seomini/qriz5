//
//  ConceptBookDetailViewModel.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/07/03.
//

import Foundation
import SwiftUI

class ConceptBookDetailViewModel: ObservableObject {
    @Published var subject: Subject
    
    init(subject: Subject) {
        self.subject = subject
    }
}

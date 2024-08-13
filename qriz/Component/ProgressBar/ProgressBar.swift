//
//  ProgressBar.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/05/30.
//

import SwiftUI

// MARK: - Progress Bar View
struct ProgressBar: View {
    let steps: [SignUpStep]
    let currentStep: SignUpStep
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(steps.indices, id: \.self) { index in
                    Rectangle()
                        .fill(index <= steps.firstIndex(of: currentStep) ?? 0 ? Color.customProgressBarOn: Color.customProgressBarOff)
                        .frame(width: geometry.size.width / CGFloat(steps.count))
                }
            }
        }
        .frame(height: 4)
        .background(Color.gray.opacity(0.1)) // Light gray background
    }
}

// MARK: - 문제 진행률 프로그래스 바
struct ExamProgressBar: View {
    let value: Double
    
    var body: some View {
        ZStack(alignment: .leading) {
            Capsule()
                .frame(height: 8)
                .foregroundColor(Color.customProgressBarOff)
            
            Capsule()
                .frame(width: CGFloat(value) * UIScreen.main.bounds.width , height: 4)
                .foregroundColor(Color.customProgressBarOn)
                .animation(.linear, value: value)
        }
    }
}

//
//  UnderlineSegmentedControl.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/05/27.
//

import SwiftUI




import SwiftUI

struct UnderlineSegmentedControl: View {
    @Binding var selectedSegment: Int
    let segments: [String]

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(0..<segments.count, id: \.self) { index in
                    Button(action: {
                        withAnimation {
                            selectedSegment = index
                        }
                    }) {
                        Text(segments[index])
                            .font(.headline)
                            .foregroundColor(selectedSegment == index ? .black : .gray)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                }
            }
            .background(Color.clear)
            
            HStack(spacing: 0) {
                ForEach(0..<segments.count, id: \.self) { index in
                    Rectangle()
                        .fill(selectedSegment == index ? Color.black : Color.clear)
                        .frame(height: 2)
                        .frame(maxWidth: .infinity)
                }
            }
        }
    }
}

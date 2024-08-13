//
//  TabButton.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/07/09.
//

import Foundation
import SwiftUI

struct TabButton: View {
    let title: String
    @Binding var selectedTab: String
    
    var body: some View {
        VStack {
            Button(action: {
                selectedTab = title
            }) {
                Text(title)
                    .foregroundColor(selectedTab == title ? .blue : Color.customProgressBarTC)
            }
            .padding(.vertical, 8)
            
            if selectedTab == title {
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(.blue)
            } else {
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(.clear)
            }
            
        }
    }
}

struct FilterButton: View {
    let title: String
    var imageName: String?
    @Binding var isSelected: Bool

    var body: some View {
        Button(action: {
            isSelected.toggle()
        }) {
            HStack(spacing: 0) {
                if let imageName = imageName, !imageName.isEmpty {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                Text(title)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .foregroundColor(isSelected ? .blue : .black)
            }
            .padding(1)
            .frame(height: 40)
            .background(isSelected ? Color.white : Color(red: 240/255, green: 244/255, blue: 247/255))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isSelected ? Color.blue : .clear)
            )
        }
    }
}

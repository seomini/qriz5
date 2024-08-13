//
//  BackButton.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/08/01.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image("Back")
                .foregroundColor(.black)
                .font(.system(size: 24, weight: .bold))
        }
    }
}


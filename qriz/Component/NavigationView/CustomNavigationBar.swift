//
//  CustomNavigationBar.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/05/22.
//

import SwiftUI

struct CustomNavigationBar: View {
    let isDisplayLeftBtn: Bool
    let isDisplayRightBtn: Bool
    let isCenterTitle: Bool
    let leftBtnAction: () -> Void
    let rightBtnAction: () -> Void
    let centerTitleType: NavigationTitleType
    
    init(
        isDisplayLeftBtn: Bool = true,
        isDisplayRightBtn: Bool = true,
        isCenterTitle: Bool = true,
        leftBtnAction: @escaping () -> Void = {},
        rightBtnAction: @escaping () -> Void = {},
        centerTitleType: NavigationTitleType = .close
    ) {
        self.isDisplayLeftBtn = isDisplayLeftBtn
        self.isDisplayRightBtn = isDisplayRightBtn
        self.isCenterTitle = isCenterTitle
        self.leftBtnAction = leftBtnAction
        self.rightBtnAction = rightBtnAction
        self.centerTitleType = centerTitleType
    }
    
    var body: some View {
            HStack {
                if isDisplayLeftBtn {
                    Button (
                        action: leftBtnAction,
                        label: { Image("leftArrow") }
                    ).frame(width: 40)
                } else {
                    Spacer()
                        .frame(width: 40)
                }
                
                Spacer()
                
                if isCenterTitle {
                    Text(centerTitleType.rawValue)
                        .font(.headline)
                        .foregroundColor(.primary)
                } else {
                    Spacer()
                }
                
                Spacer()
                
                if isDisplayRightBtn {
                    Button(action: rightBtnAction) {
                        Image("setting")
                            .resizable()
                            .frame(width: 40, height: 24)
                            .aspectRatio(contentMode: .fit)
                    }
                } else {
                    Spacer()
                        .frame(width: 40)
                }
            }
            .padding(.horizontal, 10)
            .frame(height: 44)
    }
}

#Preview {
    CustomNavigationBar()
}

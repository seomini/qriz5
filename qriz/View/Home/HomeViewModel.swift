//
//  HomeViewModel.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/05/28.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var selectedTab: Tab
    
    init() {
        self.selectedTab = .mainPage
    }

    func changeSelectedTab(_ tab: Tab) {
        selectedTab = tab
    }
}


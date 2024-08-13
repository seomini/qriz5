//
//  Onbording.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/05/28.
//

import Foundation

struct SelectableBox: Identifiable, Hashable {
    let id = UUID()
    let title: String
    var isSelected: Bool = false
    
    static func == (lhs: SelectableBox, rhs: SelectableBox) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

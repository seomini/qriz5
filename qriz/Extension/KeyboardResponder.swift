//
//  KeyboardResponder.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/06/11.
//

import SwiftUI
import Combine

final class KeyboardResponder: ObservableObject {
    private var notificationCenter: NotificationCenter
    @Published private(set) var currentHeight: CGFloat = 0
    
    var cancellable: AnyCancellable?

    init(center: NotificationCenter = .default) {
        notificationCenter = center
        cancellable = center.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .merge(with: center.publisher(for: UIResponder.keyboardWillHideNotification))
            .compactMap { notification in
                notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            }
            .map { rect in
                rect.height
            }
            .sink { [weak self] height in
                self?.currentHeight = height
            }
    }
}

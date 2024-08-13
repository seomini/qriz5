//
//  MainPageViewModel.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/05/28.
//

import SwiftUI
import Foundation

class MainPageViewModel: ObservableObject {
    @Published var selectedDay: Int? = 2
    @Published var firstText: String = "관계형 DB는 이상 현상을 제거하고 데이터 중복을 피할 수 있으며 동시성 관리, 병행제어를 통해 많은 사용자들이 동시에 데이터를 공유 및 조작 할 수 있는 기능을 제공인증된 사용자만이 참조할 수 있도록 보안 기능을 제공 데이터의 무결성을 보장 DBMS는 장애로부터 사용자의 데이터가 제대로 반영될 수 있도록 보장 + 시스템 다운/재해 등의 상황에서도 데이터를 회복/복구 할 수 있는 기능을 제공"
    @Published var topicTitle: String = "SQL기본 - 관계형 데이터 베이스"
    @Published var subTopicTitle: String = "관계형 데이터 베이스의 개념"
}

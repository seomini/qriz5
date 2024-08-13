//
//  OnboardingViewModel.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/05/27.
//

import Foundation
import SwiftUI
import Combine

class OnboardingViewModel : ObservableObject {
    
}

class SelectBoxViewModel: ObservableObject {
    @Published private(set) var selectedItems: [String] = []
    @Published var items: [SelectableBox] = [
        SelectableBox(title: "전혀 몰라요"),
        SelectableBox(title: "전부 알아요"),
        SelectableBox(title: "항목 1"),
        SelectableBox(title: "항목 2"),
        SelectableBox(title: "항목 3"),
        SelectableBox(title: "항목 4"),
        SelectableBox(title: "항목 5"),
        SelectableBox(title: "항목 6"),
        SelectableBox(title: "항목 7"),
        SelectableBox(title: "항목 8"),
        SelectableBox(title: "항목 9")
    ]
    
    private let apiService = APIService()
    private var cancellables = Set<AnyCancellable>()
    
    var chunkedItems: [[SelectableBox]] {
        items.chunked(into: 1)
    }
    
    func toggleSelection(of item: SelectableBox) {
        if let index = items.firstIndex(of: item) {
            if item.title == "전혀 몰라요" || item.title == "전부 알아요" {
                deselectOtherItems(except: item)
            } else {
                items[index].isSelected.toggle()
                if items[index].isSelected {
                    selectedItems.append(item.title)
                } else {
                    selectedItems.removeAll(where: { $0 == item.title })
                }
                
                // "전혀 몰라요" 또는 "전부 알아요" 항목이 선택된 경우 선택 해제
                deselectSpecialItems()
            }
        }
    }
    
    private func deselectOtherItems(except selectedItem: SelectableBox) {
        for index in items.indices {
            if items[index].title != selectedItem.title {
                items[index].isSelected = false
            }
        }
        // 업데이트된 선택 상태를 반영
        selectedItems = items.filter { $0.isSelected }.map { $0.title }
    }
    
    private func deselectSpecialItems() {
        // "전혀 몰라요" 또는 "전부 알아요" 항목이 선택된 경우, 다른 항목의 선택을 해제합니다.
        if selectedItems.contains("전혀 몰라요") || selectedItems.contains("전부 알아요") {
            for index in items.indices {
                if items[index].title == "전혀 몰라요" || items[index].title == "전부 알아요" {
                    items[index].isSelected = true
                } else {
                    items[index].isSelected = false
                }
            }
            selectedItems = items.filter { $0.isSelected }.map { $0.title }
        }
    }
    
    func submitSurvey() {
        let request = SurveyRequest(keyConcepts: generateKeyConcepts())
        
        apiService.submitSurvey(request: request)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Survey submission finished")
                case .failure(let error):
                    print("Failed to submit survey: \(error.localizedDescription)")
                }
            }, receiveValue: { response in
                print("Survey submitted successfully: \(response)")
            })
            .store(in: &cancellables)
    }
    
    private func generateKeyConcepts() -> [String] {
        if selectedItems.contains("전혀 몰라요") {
            return ["KNOWS_NOTHING"]
        } else if selectedItems.contains("전부 알아요") {
            return ["KNOWS_EVERYTHING"] // 만약 이와 같은 항목이 있다면 추가
        } else {
            return selectedItems
        }
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}


//
//  qrizApp.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/05/21.
//

import SwiftUI

@main
struct qrizApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var container: DIContainer = .init(services: Services())
    
    
    var body: some Scene {
        WindowGroup {
            HomeView()
//            ExamView()
//            AuthenticatedView(authViewModel: .init(container: container))
//            LoginView()
//                .environmentObject(PathModel())
        }
    }
}

//
//  AuthenticationView.swift
//  qriz
//
//  Created by mimi_0_0 on 2024/07/11.
//

import SwiftUI

struct AuthenticatedView: View {
    @StateObject var authViewModel: AuthenticationViewModel
    @EnvironmentObject var pathModel: PathModel
    
    var body: some View {
        if authViewModel.authenticationState == .unauthenticated {
            LoginView()
                .environmentObject(PathModel())
                .environmentObject(authViewModel)
        } else if authViewModel.authenticationState == .authenticated {
            HomeView()
        }
    }
}

struct AuthenticatedView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticatedView(authViewModel: .init(container: .init(services: StubService())))
    }
}

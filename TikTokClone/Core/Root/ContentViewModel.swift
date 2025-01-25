//
//  ContentViewModel.swift
//  TikTokClone
//
//  Created by Brody on 1/24/25.
//

import Combine
import Foundation
import FirebaseAuth

@MainActor
class ContentViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    
    @Published var currentUser: User? // current user on the app
    
    private let authService: AuthService
    private let userService: UserService
    private var cancellables = Set<AnyCancellable>()
    
    init(authService: AuthService, userService: UserService){
        self.authService = authService
        self.userService = userService
        
        setupSubscribers()
        authService.updateUserSession()
    }
    
    // .sink and .store are from the Combine import
    private func setupSubscribers(){
        authService.$userSession.sink{ [weak self] user in // grabs self from the authService. Sink is used to make a closure
            self?.userSession = user
            self?.fetchCurrentUser()
        }.store(in: &cancellables)
    }
    
    func fetchCurrentUser() {
        guard userSession != nil else { return }
        Task { self.currentUser = try await userService.fetchCurrentUser()}
    }
}

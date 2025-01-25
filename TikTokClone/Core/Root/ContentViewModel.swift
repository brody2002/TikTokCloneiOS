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
    
    private let authService: AuthService
    private var cancellables = Set<AnyCancellable>()
    
    init(authService: AuthService){
        self.authService = authService
        
        setupSubscribers()
        authService.updateUserSession()
    }
    
    private func setupSubscribers(){
        authService.$userSession.sink{ [weak self] user in // grabs self from the authService ||||||| Sink is used to make a closure
            self?.userSession = user
        }.store(in: &cancellables)
    }
}

//
//  ExploreView.swift
//  TikTokClone
//
//  Created by Brody on 1/25/25.
//

import Foundation

@MainActor
class ExploreViewModel: ObservableObject {
    @Published var users = [User]()
    private let userService: UserServiceProtocol
    init(userService: UserServiceProtocol) {
        self.userService = userService
        Task{ await fetchUsers() }
    }
    
    func fetchUsers() async {
        do {
            self.users = try await userService.fetchUsers()
        }
        catch {
            print("DEBUG: Failed to fetcj users with error: \(error.localizedDescription)")
        }
    }
}

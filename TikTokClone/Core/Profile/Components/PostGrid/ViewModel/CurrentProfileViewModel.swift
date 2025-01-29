//
//  CurrentProfileViewModel.swift
//  TikTokClone
//
//  Created by Brody on 1/29/25.
//

import Foundation

@MainActor
class PostGridViewModel: ObservableObject {
    @Published var posts = [Post]()
    private let userService: UserService
    
    init(userService: UserService){
        self.userService = userService
        
        Task { await fetchCurrentUserPosts() }
    }
    
    func fetchCurrentUserPosts() async {
        var optionalUser: User?
        optionalUser = try? await userService.fetchCurrentUser()
        guard let user = optionalUser else { return }
        do { self.posts = try await userService.fetchPosts(user: user) }
        catch { print("DEBUG: Failed to fetch the Current Users's posts with error: \(error.localizedDescription)")}
    }
    
    func fetctUserPosts(user: User) async {
        do { self.posts = try await userService.fetchPosts(user: user) }
        catch { print("DEBUG: Failed to fetch the regular Users's posts with error: \(error.localizedDescription)")}
    }
}


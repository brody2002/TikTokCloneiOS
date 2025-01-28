//
//  User.swift
//  TikTokClone
//
//  Created by Brody on 1/24/25.
//

import Foundation

protocol UserType {
    var id: String { get }
    var username: String { get }
    var email: String { get }
    var fullName: String { get }
    var bio: String? { get }
    var profileImageUrl: String? { get }
}

// Only apply set to classes, NOT structs
protocol EditableUserType: UserType {
    var id: String { get set }
    var username: String { get set }
    var email: String { get set }
    var fullName: String { get set }
    var bio: String? { get set }
    var profileImageUrl: String? { get set }
}

// User (Struct) conforms to UserType (Immutable)
struct User: Identifiable, Codable, Hashable, UserType {
    var id: String
    var username: String
    var email: String
    var fullName: String
    var bio: String?
    var profileImageUrl: String?
}

// CurrentUser (Class) conforms to EditableUserType (Mutable)
class CurrentUser: ObservableObject, EditableUserType {
    @Published var id: String
    @Published var username: String
    @Published var email: String
    @Published var fullName: String
    @Published var bio: String?
    @Published var profileImageUrl: String?

    init(id: String, username: String, email: String, fullName: String, bio: String? = nil, profileImageUrl: String? = nil) {
        self.id = id
        self.username = username
        self.email = email
        self.fullName = fullName
        self.bio = bio
        self.profileImageUrl = profileImageUrl
    }
}

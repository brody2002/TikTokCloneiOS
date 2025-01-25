//
//  User.swift
//  TikTokClone
//
//  Created by Brody on 1/24/25.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let username: String
    let email: String
    let fullName: String
    var bio: String?
    var profileImageUrl: String?
}

// Future implment: changing username, email, and profileImage


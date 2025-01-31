//
//  Comment.swift
//  TikTokClone
//
//  Created by Brody on 1/31/25.
//

import Foundation

struct CommentSection: Identifiable, Codable{
    var id: String
    var commentAmount: Int
    var commentList: [Comment]
}

struct Comment: Identifiable, Codable {
    var id: String
    var username: String
    var usernameId: String
    var message: String
    var timestamp: String
}

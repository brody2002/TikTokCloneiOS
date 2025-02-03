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
    var commentIds: [String]
}

struct Comment: Identifiable, Codable {
    var id: String
    var postId: String
    var username: String
    var userId: String
    var message: String
    var timestamp: String
    var likes: Int
    var thumbsDown: Int
    var replyList: [String]
    var replyAmount: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "commentId"
        case postId
        case username
        case userId = "id"
        case message
        case timestamp
        case likes
        case thumbsDown
        case replyList
        case replyAmount
    }
}



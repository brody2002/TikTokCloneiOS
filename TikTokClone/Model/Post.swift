//
//  Post.swift
//  TikTokClone
//
//  Created by Brody on 1/22/25.
//

import Foundation

/// A model representing a post in the TikTokClone app.
struct Post: Identifiable, Codable {
    /// Unique identifier for the post.
    let id: String
    ///  UserID of the person who uploaded the post
    let userId: String
    /// URL of the video associated with the post.
    let videoURL: String
    /// Time the post was uploaded
    let timestamp: String
    /// Caption or description provided by the user for the post.
    var caption: String
    /// The number of likes the post has received, represented as a string.
    var likesAmount: Int
    /// The number of comments on the post, represented as a string.
    var commentsAmount: Int
    /// The number of times the post has been saved, represented as a string.
    var savesAmount: Int
    /// Username of the uploader: Isn't set initally but set in the FeedViewModel of this app
    var username: String?
    /// Placeholder Image for profiles
    var imageUrl: String?
    /// Object that store every comment  of a post
    var commentSectionId: String?
    /// Object that stores all the Ids that have liked this post
    var likedIds: Set<String>?
    
    enum CodingKeys: String, CodingKey {
        case id = "postId"
        case userId = "id"
        case videoURL = "videoUrl"
        case timestamp
        case caption
        case likesAmount
        case commentsAmount
        case savesAmount
        case username
        case imageUrl
        case commentSectionId
        case likedIds
    }
}





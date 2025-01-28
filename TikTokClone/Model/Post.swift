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
    
    /// URL of the video associated with the post.
    let videoURL: String
    
    /// Username of the user who created the post.
    let user: String
    
    /// Caption or description provided by the user for the post.
    let caption: String?
    
    /// The number of likes the post has received, represented as a string.
    let likesAmount: String?
    
    /// The number of comments on the post, represented as a string.
    let commentsAmount: String?
    
    /// The number of times the post has been saved, represented as a string.
    let savesAmount: String?
    
    
}

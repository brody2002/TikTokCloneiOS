//
//  PreviewProvider.swift
//  TikTokClone
//
//  Created by Brody on 1/25/25.
//

import Foundation

// MOCK DATA:
struct DeveloperPreview {
    
    static var user = User(
        id: NSUUID().uuidString,
        username: "lebron_james",
        email: "lebron@gmail.com",
        fullName: "Lebron James",
        bio: "Hello guys... It's me Lebron James"
    )
    
    static var currentUser = CurrentUser(
        id: NSUUID().uuidString,
        username: "lebron_james",
        email: "lebron@gmail.com",
        fullName: "Lebron James"
    )
    static var users: [User] = [
        .init(id: NSUUID().uuidString, username: "EarhSpirtitMeeiiin", email: "kairoberts@gmail.com", fullName: "Kai Roberts"),
        .init(id: NSUUID().uuidString, username: "brody.roberts", email: "brody@gmail.com", fullName: "Brody Roberts"),
        .init(id: NSUUID().uuidString, username: "sarah.graessley", email: "sarah@gmail.com", fullName: "Sarah Graessely"),
        .init(id: NSUUID().uuidString, username: "lauren.spellman", email: "lauren@gmail.com", fullName: "Lauren Spellman")
    ]
    
    static var post: Post = Post(
        id: "somerandomPostID",
        videoURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
        user: "LebronJames",
        caption: "Ima the goat",
        likesAmount: "1023",
        commentsAmount: "34",
        savesAmount: "400"
    )
}

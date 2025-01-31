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
        bio: "Hello guys... It's me Lebron James",
        profileImageUrl: "https://firebasestorage.googleapis.com:443/v0/b/tiktokclone-5ce67.firebasestorage.app/o/profile_images%2FB08BDBD9-0495-433A-A969-30166333B97C?alt=media&token=08ec3334-719d-4c5a-80f5-8ea0f28ff92f"
    )
    
    static var currentUser = CurrentUser(
        id: NSUUID().uuidString,
        username: "lebron_james",
        email: "lebron@gmail.com",
        fullName: "Lebron James"
    )
    static var users: [User] = [
        .init(
            id: NSUUID().uuidString,
            username: "EarhSpirtitMeeiiin",
            email: "kairoberts@gmail.com",
            fullName: "Kai Roberts"
        ),
        .init(
            id: NSUUID().uuidString,
            username: "brody.roberts",
            email: "brody@gmail.com",
            fullName: "Brody Roberts"
        ),
        .init(
            id: NSUUID().uuidString,
            username: "sarah.graessley",
            email: "sarah@gmail.com",
            fullName: "Sarah Graessely"
        ),
        .init(
            id: NSUUID().uuidString,
            username: "lauren.spellman",
            email: "lauren@gmail.com",
            fullName: "Lauren Spellman"
        )
    ]
    
    static var post: Post = Post(
            id: NSUUID().uuidString,
            userId: "38sbsefhsefh",
            videoURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
            timestamp: "2025-02-10 02:10:23",
            caption: "That's Arbol",
            likesAmount: 123,
            commentsAmount: 33,
            savesAmount: 1000,
            username: nil
    )
}

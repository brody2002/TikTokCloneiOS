//
//  FeedViewModel.swift
//  TikTokClone
//
//  Created by Brody on 1/22/25.
//

import Foundation
import FirebaseFirestore



@Observable
class FeedViewModel: ObservableObject {
    var posts = [Post]() // Make it @Published so views update
    init() {
        fetchPosts()
    }
    func fetchPosts() {
        FirestoreConstants.PostCollection
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Failed to fetch posts: \(error.localizedDescription)")
                    return
                }
                guard let documents = snapshot?.documents else {
                    print("No documents found.")
                    return
                }
                // Print raw Firestore data
                for doc in documents {
                    print("Raw Document Data:", doc.data())
                }
                // NOTE DECODING DATA INTO STRUCT INCORRECTLY
                // MUST MAKE THE SAME
                DispatchQueue.main.async {
                    self.posts = documents.compactMap { try? $0.data(as: Post.self) }
                    print("Decoded Posts:", self.posts)
                }
            }
    }
}

@Observable
class MockFeedViewModel: ObservableObject {
    var posts = [Post]()
    let videoURLs = [
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4",
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4",
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4",
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/VolkswagenGTIReview.mp4",
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4",
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4",
        
    ]
    
    init(){
        fetchPosts()
    }
    
    func fetchPosts(){
        self.posts = [
            .init(
                id: NSUUID().uuidString,
                videoURL: videoURLs[0],
                user: "LeBron James",
                caption: "Im the goat",
                likesAmount: "1200",
                commentsAmount: "250",
                savesAmount: "600"
            ),
            .init(
                id: NSUUID().uuidString,
                videoURL: videoURLs[1],
                user: "MoneyMan33",
                caption: "MoneyMan dont play with this shiet",
                likesAmount: "5400",
                commentsAmount: "180",
                savesAmount: "900"
            ),
            .init(
                id: NSUUID().uuidString,
                videoURL: videoURLs[2],
                user: "Ghandi73-23",
                caption: "PEACE... PEACE IS LOVE. WORD",
                likesAmount: "3100",
                commentsAmount: "300",
                savesAmount: "750"
            ),
            .init(
                id: NSUUID().uuidString,
                videoURL: videoURLs[3],
                user: "TheTrainMan",
                caption: "WOOT TOOOT",
                likesAmount: "8900",
                commentsAmount: "500",
                savesAmount: "1200"
            ),
            .init(
                id: NSUUID().uuidString,
                videoURL: videoURLs[4],
                user: "OtterLife33",
                caption: "I miss pookie wookie",
                likesAmount: "6700",
                commentsAmount: "220",
                savesAmount: "980"
            ),
            .init(
                id: NSUUID().uuidString,
                videoURL: videoURLs[5],
                user: "Sarah Graessley",
                caption: "Im the goat",
                likesAmount: "4500",
                commentsAmount: "190",
                savesAmount: "870"
            ),
            .init(
                id: NSUUID().uuidString,
                videoURL: videoURLs[6],
                user: "Kanye West",
                caption: "Im the goat",
                likesAmount: "3200",
                commentsAmount: "160",
                savesAmount: "740"
            ),
            .init(
                id: NSUUID().uuidString,
                videoURL: videoURLs[7],
                user: "Kai Roberts",
                caption: "Ima earth spritit main",
                likesAmount: "7600",
                commentsAmount: "280",
                savesAmount: "1000"
            ),
            .init(
                id: NSUUID().uuidString,
                videoURL: videoURLs[8],
                user: "BunnyObama",
                caption: "ima bunny",
                likesAmount: "9500",
                commentsAmount: "400",
                savesAmount: "1300"
            ),
            .init(
                id: NSUUID().uuidString,
                videoURL: videoURLs[9],
                user: "TheMilfInYourLocalArea",
                caption: "I want to fuck you",
                likesAmount: "8200",
                commentsAmount: "320",
                savesAmount: "1100"
            ),
            .init(
                id: NSUUID().uuidString,
                videoURL: videoURLs[10],
                user: "pokemonMASTABAITER",
                caption: "ima catch them all",
                likesAmount: "8700",
                commentsAmount: "260",
                savesAmount: "1050"
            ),
            .init(
                id: NSUUID().uuidString,
                videoURL: videoURLs[11],
                user: "Keanu Reeves",
                caption: "im in cyber punk",
                likesAmount: "9200",
                commentsAmount: "350",
                savesAmount: "1250"
            ),
            .init(
                id: NSUUID().uuidString,
                videoURL: videoURLs[12],
                user: "Drake",
                caption: "Im the goat",
                likesAmount: "7800",
                commentsAmount: "290",
                savesAmount: "970"
            )
            ]
    }
                  
                  
}

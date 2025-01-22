//
//  FeedViewModel.swift
//  TikTokClone
//
//  Created by Brody on 1/22/25.
//

import Foundation

@Observable
class FeedViewModel: ObservableObject {
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
        fetchPost()
    }
    
    func fetchPost(){
        self.posts = [
            .init(id: NSUUID().uuidString, videoURL: videoURLs[0]),
            .init(id: NSUUID().uuidString, videoURL: videoURLs[1]),
            .init(id: NSUUID().uuidString, videoURL: videoURLs[2]),
            .init(id: NSUUID().uuidString, videoURL: videoURLs[3]),
            .init(id: NSUUID().uuidString, videoURL: videoURLs[4]),
            .init(id: NSUUID().uuidString, videoURL: videoURLs[5]),
            .init(id: NSUUID().uuidString, videoURL: videoURLs[6]),
            .init(id: NSUUID().uuidString, videoURL: videoURLs[7]),
            .init(id: NSUUID().uuidString, videoURL: videoURLs[8]),
            .init(id: NSUUID().uuidString, videoURL: videoURLs[9]),
            .init(id: NSUUID().uuidString, videoURL: videoURLs[10]),
            .init(id: NSUUID().uuidString, videoURL: videoURLs[11]),
            .init(id: NSUUID().uuidString, videoURL: videoURLs[12])
        ]
    }
}

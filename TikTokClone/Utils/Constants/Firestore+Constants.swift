//
//  Firestore+Constants.swift
//  TikTokClone
//
//  Created by Brody on 1/25/25.
//

import Foundation
import FirebaseFirestore

struct FirestoreConstants{
    static let Root = Firestore.firestore()
    static let UsersCollection = Root.collection("users")
    static let PostCollection = Root.collection("posts")
}

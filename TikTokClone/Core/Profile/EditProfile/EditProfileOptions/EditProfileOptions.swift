//
//  EditProfileOptions.swift
//  TikTokClone
//
//  Created by Brody on 1/25/25.
//

import Foundation

enum EditProfileOptions: Hashable {
    case name
    case username
    case bio
    
    var title: String {
        switch self {
        case .name:
            return "Name"
        case .username:
            return "Username"
        case .bio:
            return "Bio"
        }
    }
    
    var firebaseTitle: String {
        switch self {
        case .name:
            return "fullName"
        case .username:
            return "username"
        case .bio:
            return "bio"
        }
    }
}

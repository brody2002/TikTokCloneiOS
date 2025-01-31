//
//  Timestamp.swift
//  TikTokClone
//
//  Created by Brody on 1/31/25.
//
import Foundation
struct Timestamp {
    static func formatDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: Date())
        return dateString
    }
}

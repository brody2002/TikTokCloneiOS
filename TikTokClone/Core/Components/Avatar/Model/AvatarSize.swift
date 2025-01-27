//
//  AvatarSize.swift
//  TikTokClone
//
//  Created by Brody on 1/27/25.
//

import Foundation

/// Represents different avatar sizes used in the app.
enum AvatarSize {
    
    /// Extra extra small avatar size (28pt).
    case xxSmall
    
    /// Extra small avatar size (32pt).
    case xSmall
    
    /// Small avatar size (40pt).
    case small
    
    /// Medium avatar size (48pt).
    case medium
    
    /// Large avatar size (64pt).
    case large
    
    /// Extra large avatar size (80pt).
    case xLarge
    
    /// Returns the corresponding dimension (in points) for each avatar size.
    var dimension: CGFloat {
        switch self {
        case .xxSmall: return 28
        case .xSmall: return 32
        case .small: return 40
        case .medium: return 48
        case .large: return 64
        case .xLarge: return 80
        }
    }
}


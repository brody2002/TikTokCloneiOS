//
//  StandardTextFieldModifier.swift
//  TikTokClone
//
//  Created by Brody on 1/24/25.
//

import Foundation
import SwiftUI

struct StandardTextFieldModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(12)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal, 24)
    }
}

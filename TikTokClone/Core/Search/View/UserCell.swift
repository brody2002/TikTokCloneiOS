//
//  UserCell.swift
//  TikTokClone
//
//  Created by Brody on 1/22/25.
//

import SwiftUI

struct UserCell: View {
    let user: User
    var body: some View {
        HStack(spacing: 12){
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 48, height: 48)
                .foregroundStyle(Color(.systemGray5))
            VStack(alignment: .leading){
                Text("\(user.username)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                
                Text("\(user.fullName)")
                    .font(.footnote)
                    .foregroundStyle(.black)
            }
            Spacer()
        }
    }
}

#Preview {
    UserCell(user: DeveloperPreview.user)
}

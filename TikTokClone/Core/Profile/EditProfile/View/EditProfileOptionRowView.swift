//
//  EditProfileOptionRowView.swift
//  TikTokClone
//
//  Created by Brody on 1/26/25.
//

import SwiftUI

struct EditProfileOptionRowView: View {
    let option: EditProfileOptions
    let value: String
    
    var body: some View{
        NavigationLink(value: option){
            Text(option.title)
                .foregroundStyle(.black)
            Spacer()
            Text(value)
                .foregroundStyle(.primary)
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    EditProfileOptionRowView(option: .username, value: "lebron james")
}

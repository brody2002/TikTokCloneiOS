//
//  ProfilePostNavBar.swift
//  TikTokClone
//
//  Created by Brody on 1/30/25.
//

import SwiftUI

struct ProfilePostNavBar: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .stroke(style: StrokeStyle(lineWidth: 1))
                .fill(Color(.systemGray6))
                .frame(height: 40)
            HStack(spacing: 10){
                Button(
                    action:{
                        dismiss()
                    },
                    label:{
                        Image(systemName: "lessthan")
                            .resizable()
                            .frame(width: 14, height: 14)
                            .foregroundStyle(Color(.systemGray3))
                            .padding(.leading)
                    }
                )
                HStack(spacing: 1) {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 22, height: 22)
                        .foregroundStyle(Color(.systemGray3))
                        .padding(.leading)
                    
                    Text("Find related Content")
                        .padding(.horizontal, 10)
                        .frame(height: 18)
                        .cornerRadius(8)
                        .foregroundStyle(Color(.systemGray6))
                        .font(.system(size: 15))
                }
                Spacer()
            }
            
        }
        

        
    }
}

#Preview {
    ProfilePostNavBar()
}

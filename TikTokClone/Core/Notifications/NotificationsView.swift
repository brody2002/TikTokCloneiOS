//
//  NotificationsView.swift
//  TikTokClone
//
//  Created by Brody on 1/22/25.
//

import SwiftUI

struct NotificationsView: View {
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVStack(spacing: 24){
                    ForEach(0 ..< 10){ notificaiton in
                        NotificationCell()
                    }
                }
            }
            .navigationTitle("Notifcations")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.top)
        }
    }
}

#Preview {
    NotificationsView()
}

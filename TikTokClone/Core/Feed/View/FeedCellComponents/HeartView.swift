//
//  HeartView.swift
//  TikTokClone
//
//  Created by Brody on 2/3/25.
//

import SwiftUI


struct HeartView: View {
    @State var width: CGFloat
    @State var height: CGFloat
    let inputData: Int
    
    // Heart Modifiers
    @State var heartColor: Bool = false
    @State var heartSize: CGFloat = 28.00
    init(width: CGFloat = 28, height: CGFloat = 28, inputData: Int) {
        self.width = width
        self.height = height
        self.inputData = inputData
    }
    
    var body: some View {
        VStack{
            Image(systemName: "heart.fill")
                .resizable()
                .frame(width: heartSize, height: heartSize)
                .foregroundStyle(heartColor ? Color.pink : Color.white)
                .onTapGesture { heartToggleFunc() }
            
            PostNumericsHandler(inputData: inputData)
                .font(.caption)
                .foregroundStyle(.white)
                .bold()
        }
    }
    
    private func heartToggleFunc() {
        if heartColor == false {
            withAnimation(.spring(response: 0.2)){
                heartColor.toggle()
                heartSize = 34.0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                withAnimation(.spring(response: 0.2)) { heartSize = 28.0 }
            }
        } else { withAnimation(.spring(response: 0.3)){ heartColor.toggle() } }
    }
    
}



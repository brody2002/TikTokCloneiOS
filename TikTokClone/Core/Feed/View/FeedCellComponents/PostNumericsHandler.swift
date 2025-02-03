//
//  PostNumericsHandler.swift
//  TikTokClone
//
//  Created by Brody on 2/3/25.
//

import SwiftUI

struct PostNumericsHandler: View {
    var inputData: Int
    var body: some View {
        if inputData > 0{
            Text("\(inputData)")
        } else { Text("") }
    }
}

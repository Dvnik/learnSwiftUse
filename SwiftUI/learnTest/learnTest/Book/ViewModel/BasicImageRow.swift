//
//  BasicImageRow.swift
//  learnTest
//
//  Created by on 2024/2/15.
//

import SwiftUI

/**
 BasicImageRow 與FullImageRow
 是展示如何通過預先製作的方式達到一瞬間替換樣式的做法
 
 */
struct BasicImageRow: View {
    var restaurant: Restaurant
    
    var body: some View {
        HStack {
            Image(restaurant.image)
                .resizable()
                .frame(width: 40, height: 40)
                .cornerRadius(5)
            Text(restaurant.name)
        }
    }
}

//
//  RestaurantDetailView.swift
//  learnTest
//
//  Created by 翊軒 on 2024/2/15.
//

import SwiftUI


struct RestaurantDetailView: View {
    @Environment(\.dismiss) var dismiss

    var restaurant: Restaurant
    
    var body: some View {
        VStack {
            Image(restaurant.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text(restaurant.name)
                .font(.system(.title, design: .rounded))
                .fontWeight(.black)
          
            Spacer()
        }
        
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Text("\(Image(systemName: "chevron.left")) \(restaurant.name)")
                        .foregroundColor(.black)
                }

            }
        }
    }
}


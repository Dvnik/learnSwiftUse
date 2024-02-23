//
//  Ch11View.swift
//  learnTest
//
//  Created by on 2024/2/15.
//
// 運用導覽 UI 與導覽列客製化

/**
 
 
 在 UIKit 中，我們可以使用 UINavigationController 來實作這類型的介面。在 SwiftUI 中，Apple 稱其為「NavigationView」。由 iOS 16 開始，這個 「NavigationView」 以 「NavigationStack」取替。
 
 在 iOS 16 中，Apple 將 NavigationView 替換為 NavigationStack。 你仍然可以使用 NavigationView 來創建導航視圖， 但建議使用 NavigationStack，因為 NavigationView 最終會從 SDK 中移除。
 
 
 使用 NavigationLink 傳送資料至細節視圖
 SwiftUI 提供一個名為 NavigationLink 的特殊按鈕，它能夠偵測使用者的觸控，並觸發導覽顯示，NavigationLink 的基本用法如下：

 NavigationLink(destination: DetailView()) {
     Text("Press me for details")
 }
 
 */

import SwiftUI

struct Ch11View: View {
    var restaurants = [ Restaurant(name: "Cafe Deadend", image: "cafedeadend"),
                        Restaurant(name: "Homei", image: "homei"),
                        Restaurant(name: "Teakha", image: "teakha"),
                        Restaurant(name: "Cafe Loisl", image: "cafeloisl"),
                        Restaurant(name: "Petite Oyster", image: "petiteoyster"),
                        Restaurant(name: "For Kee Restaurant", image: "forkeerestaurant"),
                        Restaurant(name: "Po's Atelier", image: "posatelier"),
                        Restaurant(name: "Bourke Street Bakery", image: "bourkestreetbakery"),
                        Restaurant(name: "Haigh's Chocolate", image: "haighschocolate"),
                        Restaurant(name: "Palomino Espresso", image: "palominoespresso"),
                        Restaurant(name: "Homei", image: "upstate"),
                        Restaurant(name: "Traif", image: "traif"),
                        Restaurant(name: "Graham Avenue Meats And Deli", image: "grahamavenuemeats"),
                        Restaurant(name: "Waffle & Wolf", image: "wafflewolf"),
                        Restaurant(name: "Five Leaves", image: "fiveleaves"),
                        Restaurant(name: "Cafe Lore", image: "cafelore"),
                        Restaurant(name: "Confessional", image: "confessional"),
                        Restaurant(name: "Barrafina", image: "barrafina"),
                        Restaurant(name: "Donostia", image: "donostia"),
                        Restaurant(name: "Royal Oak", image: "royaloak"),
                        Restaurant(name: "CASK Pub and Kitchen", image: "caskpubkitchen")
    ]
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.red, .font: UIFont(name: "ArialRoundedMTBold", size: 35)!]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.red, .font: UIFont(name: "ArialRoundedMTBold", size: 20)!]
        navBarAppearance.setBackIndicatorImage(UIImage(systemName: "arrow.turn.up.left"), transitionMaskImage: UIImage(systemName: "arrow.turn.up.left"))
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(restaurants) { restaurant in
                    NavigationLink(destination: RestaurantDetailView(restaurant: restaurant)) {
                        BasicImageRow(restaurant: restaurant)
                    }
                    
                }
            }
            .listStyle(.plain)
            
            .navigationTitle("Restaurants")
            .navigationBarTitleDisplayMode(.automatic)
            
        }
        .accentColor(.black)
        
    }
}

#Preview {
    Ch11View()
}





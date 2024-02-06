//
//  Ch10View.swift
//  learnTest
//
//  Created by 翊軒 on 2024/2/6.
//
// 動態清單、ForEach 與識別

import SwiftUI

/**
 * 在SwiftUI 中，TableView用"List"這個View表示
 在 SwiftUI 中，我們使用 List 代替表格視圖來顯示資料列。如果你之前使用過 UIKit 建立表格視圖，你應該知道實作一個簡單的表格視圖，就需要花一點工夫。而若是要建立自訂 Cell 佈局的表格視圖，則要做的工作更多。SwiftUI 簡化了整個過程，只需幾行程式碼，你就能以表格形式來陳列資料。即使你需要自訂列的佈局，也只需要極少的工夫即可辦到。
 
 1.直接將View擺在List中
 List {
 Text("Item 1")
 Text("Item 2")
 Text("Item 3")
 Text("Item 4")
 }
 
 2.可以使用 ForEach 來編寫
 List {
 ForEach(1...4, id: \.self) { index in
 Text("Item \(index)")
 }
 }
 List {
     ForEach(1...4, id: \.self) {
         Text("Item \($0)")
     }
 }
 */

struct Ch10View: View {
    /*
     原先分開的兩個資料可以結合成一個結構
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats And Deli", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
    var restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkeerestaurant", "posatelier", "bourkestreetbakery", "haighschocolate", "palominoespresso", "upstate", "traif", "grahamavenuemeats", "wafflewolf", "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "caskpubkitchen"]
    */
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
                   Restaurant(name: "Upstate", image: "upstate"),
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
    
    var body: some View {
        
        List {
            ForEach(restaurants.indices, id: \.self) { index in
                if (0...1).contains(index) {
                    FullImageRow(restaurant: self.restaurants[index])
                } else {
                    BasicImageRow(restaurant: self.restaurants[index])
                }
            }
            /**
             更改行分隔符的顏色
             從 iOS 15 開始，Apple 為開發人員提供了自定義列表視圖外觀的選項。 要更改行分隔符的色調顏色，可以使用 listRowSeparatorTint 修飾符
             */
            .listRowSeparatorTint(.green)
            /**
             隱藏列表分隔線
             iOS 15 引入了其中一個最受期待的 List 功能。 你終於可以使用 listRowSeparator 修飾器並將其值設置為 .hidden 以隱藏分隔線。
             */
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        /**
         自定義滾動區域的背景
         只需將 scrollContentBackground 修飾符附加到 List 視圖並將其設置為您喜歡的顏色。
         */
        
        //end
    }
}

#Preview {
    Ch10View()
}

struct Restaurant {
    //因為SwiftUI簡化了很多UI的佈局，所以像List要抓出特訂的項目就需要特定的方式去辨別個體位置，UUID就是一個普遍的方法
    var id = UUID()
    
    var name: String
    var image: String
}
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

struct FullImageRow: View {
    var restaurant: Restaurant

    var body: some View {
        ZStack {
            Image(restaurant.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .cornerRadius(10)
                .overlay(
                    Rectangle()
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .opacity(0.2)
                )

            Text(restaurant.name)
                .font(.system(.title, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(.white)
        }
    }
}

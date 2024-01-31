//
//  Ch04View.swift
//  learnTest
//
//  Created by on 2024/1/31.
// 以堆疊佈局使用者介面

import SwiftUI


/**
 HStack - 水平排列視圖。
 VStack - 垂直排列視圖。
 ZStack - 在一個視圖重疊在其他視圖之上。
 * Stack是可以容納多個View，所以是SwiftUI主要的編排關鍵字
 * 用大括號包住
 * Stack可以層層包覆
 1. VStack(alignment: .leading, spacing: 2) 表示 alignment為leading，每個View間距2
 2.快速生成包覆的Stack View，可按住control鍵，，並點選 VStack 關鍵字，這會帶出一個顯示所有可用選項的內容選單（content menu ），選擇「Embed in VStack」來嵌入 VStack。
 3.取出視圖：同樣的方法改選「Extract Subview」，則是自動生成ExtractedView的Struct，裡面包的是取出的UI
   - 因為是自動命名，所以生成之後要再去修改名稱
 
 */

struct Ch04View: View {
    var body: some View {
        VStack {
            HeaderView()
            
            HStack(spacing: 15) {
                PricingView(title: "Basic", price: "$9", textColor: .white, bgColor: .purple)
                
                ZStack {
                    PricingView(title: "Pro", price: "$19", textColor: .black, bgColor: Color(red: 240/255, green: 240/255, blue: 240/255))
                    
                    Text("Best for designer")
                        .font(.system(.caption, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(5)
                        .background(Color(red: 255/255, green: 183/255, blue: 37/255))
                        .offset(x: 0, y: 87)
                }
                
            }
            .padding(.horizontal)
            
            ZStack {
                PricingView(title: "Team", price: "$299", textColor: .white, bgColor: Color(red: 62/255, green: 63/255, blue: 70/255), icon: "wand.and.rays")
                    .padding()
                
                Text("Perfect for teams with 20 members")
                    .font(.system(.caption, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color(red: 255/255, green: 183/255, blue: 37/255))
                    .offset(x: 0, y: 110)
            }
            
            // Add a spacer
            Spacer()
        }
    }
}

#Preview {
    Ch04View()
}



struct HeaderView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("Choose")
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.black)
                Text("Your Plan")
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.black)
            }
            
            Spacer()
        }
        .padding()
    }
}

struct PricingView: View {
    
    var title: String
    var price: String
    var textColor: Color
    var bgColor: Color
    var icon: String?
    
    var body: some View {
        VStack {
            
            if let icon = icon {
                
                Image(systemName: icon)
                    .font(.largeTitle)
                    .foregroundColor(textColor)
                
            }
            
            Text(title)
                .font(.system(.title, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(textColor)
            Text(price)
                .font(.system(size: 40, weight: .heavy, design: .rounded))
                .foregroundColor(textColor)
            Text("per month")
                .font(.headline)
                .foregroundColor(textColor)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
        .padding(40)
        .background(bgColor)
        .cornerRadius(10)
    }
}

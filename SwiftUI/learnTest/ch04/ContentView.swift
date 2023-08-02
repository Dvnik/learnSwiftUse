//
//  ContentView.swift
//  ch04
//
//  Created by on 2023/8/2.
//
//  第 4 章 以堆疊佈局使用者介面
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        /**
         要將目前的 VStack 嵌入另外一個 VStack，你可以按住 command 鍵，並點選 VStack 關鍵字，這會帶出一個顯示所有可用選項的內容選單（content menu ），選擇「Embed in VStack」來嵌入 VStack
         */
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
                PricingView(title: "Team", price: "$299", textColor: .white, bgColor: Color(red: 62/255, green: 63/255, blue: 70/255), systemIcon: "wand.and.rays")
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
/**
 按住 command 鍵，選擇「Extract Subview」
 則會自動做一個[ExtractedView]的struct
 改名的話可用refactor來更名
 */
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
            /**
             SwiftUI 沒有自動佈局，而是提供一個稱為「留白」（Spacer ）的視圖來建立複雜的佈局。
             */
            Spacer()
        }
        .padding()
    }
}
/**
將ExtractedView拉出來之後，套用自定義參數的方法
 */
struct PricingView: View {
    var title: String
    var price: String
    var textColor: Color
    var bgColor: Color
    var systemIcon: String?
    
    var body: some View {
        VStack {
            if let icon = systemIcon {
                
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

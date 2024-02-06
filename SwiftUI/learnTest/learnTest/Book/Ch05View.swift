//
//  Ch05View.swift
//  learnTest
//
//  Created by on 2024/1/31.
//
// 了解滾動視圖與建立輪播 UI

import SwiftUI
/**
 以卡片形式的UI範例來示範ScrollView
 
 此範例用了CardView與ContentView兩種
 CardView編輯重複UI的樣式
 ContentView則使用CardView去佈置UI
 
 在滾動視圖時，螢幕底部附近有一個滾動指示器。這個指示器預設是顯示的。如果你想要隱藏它，你可以將 ScrollView 的程式碼變更如下：
 ScrollView(.horizontal, showsIndicators: false)
 
 * SwiftUI 中可以使用 .minimumScaleFactor 修飾器來自動縮小文字。
 
 */
struct Ch05View: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("MONDAY, AUG 20")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("Your Reading")
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.black)
                }
                
                Spacer()
            }
            .padding([.top, .horizontal])
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack {
                    Group {
                        Ch05CardView(image: "swiftui-button", category: "SwiftUI", heading: "Drawing a Border with Rounded Corners", author: "Simon Ng")
                        Ch05CardView(image: "macos-programming", category: "macOS", heading: "Building a Simple Editing App", author: "Gabriel Theodoropoulos")
                        Ch05CardView(image: "flutter-app", category: "Flutter", heading: "Building a Complex Layout with Flutter", author: "Lawrence Tan")
                        Ch05CardView(image: "natural-language-api", category: "iOS", heading: "What's New in Natural Language API", author: "Sai Kambampati")
                    }
                    .frame(width: 300)
                }
            }
            
        }
    }
}

#Preview {
    Ch05View()
}

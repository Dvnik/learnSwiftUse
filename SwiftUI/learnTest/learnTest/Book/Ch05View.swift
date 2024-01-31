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
            
            ScrollView {
                
                VStack {
                    Ch05CardView(image: "swiftui-button", category: "SwiftUI", heading: "Drawing a Border with Rounded Corners", author: "Simon Ng")
                    Ch05CardView(image: "macos-programming", category: "macOS", heading: "Building a Simple Editing App", author: "Gabriel Theodoropoulos")
                    Ch05CardView(image: "flutter-app", category: "Flutter", heading: "Building a Complex Layout with Flutter", author: "Lawrence Tan")
                    Ch05CardView(image: "natural-language-api", category: "iOS", heading: "What's New in Natural Language API", author: "Sai Kambampati")
                }
            }
        }
    }
}

#Preview {
    Ch05View()
}

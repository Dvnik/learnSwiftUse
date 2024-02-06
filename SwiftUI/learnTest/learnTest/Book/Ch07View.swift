//
//  Ch07View.swift
//  learnTest
//
//  Created by on 2024/2/1.
//
//  了解狀態與綁定

import SwiftUI

/**
 在 SwiftUI 中，內建了一些狀態管理的功能，特別是它導入了一個名為「@State」的屬性包裝器（ Property Wrapper ）。當你使用 @State 來標註一個屬性時，SwiftUI 會自動將其儲存在你的應用程式中的某處。此外，使用該屬性的視圖會自動監聽屬性值的變更，當狀態改變時，SwiftUI 將重新計算這些視圖，並更新應用程式的外觀。
 
 @State是主要管理狀態
 @Binding則是將不同的View連結到@State上做同步資訊
  * 使用到需要@Binding的參數時要用"$"在變數前面註記
 「那麼 $ 符號是什麼呢? 在 SwiftUI 中， 你使用 $ 前綴運算子從狀態變數取得綁定。」
 

 */

struct Ch07View: View {
    //App 如何監聽狀態（即 isPlaying ）的變化，並自動更新按鈕呢？使用 SwiftUI，你需要做的是在 isPlaying 屬性前面加上 @State。
//    @State private var isPlaying = false
    
    @State private var counter = 1
    
    var body: some View {
        //        Button {
        //            // 在「播放」與「停止」按鈕之間切換
        //            self.isPlaying.toggle()
        //        } label: {
        //            Image(systemName: isPlaying ? "stop.circle.fill" : "play.circle.fill")
        //                .font(.system(size: 150))
        //                .foregroundColor(isPlaying ? .red : .green)
        //        }
        VStack {
            CounterButton(counter: $counter, color: .blue)
            CounterButton(counter: $counter, color: .green)
            CounterButton(counter: $counter, color: .red)
        }
    }
}

#Preview {
    Ch07View()
}


struct CounterButton: View {
    @Binding var counter: Int
    
    var color: Color
    
    var body: some View {
        Button {
            counter += 1
        } label: {
            Circle()
                .frame(width: 200, height: 200)
                .foregroundColor(color)
                .overlay {
                    Text("\(counter)")
                        .font(.system(size: 100, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                }
        }
    }
}

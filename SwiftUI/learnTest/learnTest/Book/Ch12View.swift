//
//  Ch12View.swift
//  learnTest
//
//  Created by 翊軒 on 2024/2/19.
//
// 實作強制回應視圖、浮動按鈕與警告提示視窗
//

/**
 其實就是暫時性的彈出視窗(sheet)
 
 要顯示強制回應視圖，你可應用 sheet 修飾器，如下所示：

 .sheet(isPresented: $showModal) {
     DetailView()
 }
 它採用布林值來指示是否顯示強制回應視圖，如果 isPresented 設定為 true，則強制回應視圖將自動以卡片形式顯示。

 顯示強制回應視圖的另一種方式，可以寫成如下程式碼：

 .sheet(item: $itemToDisplay) {
     DetailView()
 }
 
 */

import SwiftUI

struct Ch12View: View {
    @State var showDetailView = false
    
    
    var body: some View {
        NavigationStack {
            List(articles) { article in
                ArticleRow(article: article)
                
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            
            .navigationTitle("Your Reading")
        }
    }
}

#Preview {
    Ch12View()
}


//
//  ContentView.swift
//  ch03
//
//  Created by on 2023/8/1.
//
// 第 3 章 圖片與標籤的處理

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            //SF Symbols圖片
            Image(systemName: "cloud.heavyrain")
            //SF Symbols圖片可用font調整
            Image(systemName: "cloud.heavyrain")
                .font(.system(size: 100))
                .foregroundColor(.blue)//顏色
                .shadow(color: .gray, radius: 10, x: 0, y: 10)//陰影
            //有顏色的 SF Symbols
            Image(systemName: "cloud.sun.rain")
                .symbolRenderingMode(.palette)
                .foregroundStyle(.indigo, .yellow, .gray)
            
            Image(systemName: "slowmo", variableValue: 0.5)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.indigo)
                .font(.largeTitle)
        }
        .padding()
        //Assets的圖片
        //如果沒有用Stack之類的包起來，佈局就不會是同一個畫面
        //在測試時可以這樣使用，但實戰上就不好了
        Image("cat01")
            .resizable()//調整圖片
            .ignoresSafeArea(.container, edges: .bottom)//忽略底部邊緣的安全區域
            
        
        Image("cat01")
            .resizable()
            .scaledToFit()//保持原來的長寬比
            .clipShape(Circle())//圓形圖片
            .opacity(0.5)//不透明度的調整
        
        
        Image("cat01")
            .resizable()
            .aspectRatio(contentMode: .fill)//可修改的圖片配置模式
            .frame(width: 300)//限制圖片的大小
            .clipped()//消除視圖額外的部分
        //以重疊來使圖片變暗
            .overlay(
                Color.black
                    .opacity(0.4)
                    .overlay(
                        Text("Cats")
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .foregroundColor(.white)
                            .frame(width: 200)
                    )
                )
        //應用圖片重疊
        Image("cat01")
            .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300)
                .clipShape(Circle())
        //overlay表示在這個View上疊其他的View
        //因為SwiftUI的預設用Stack之類的排列不會交互影響
                .overlay(
                    Image(systemName: "heart.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.black)
                        .opacity(0.5)
                    
                )
                .overlay(
                    Text("If you are lucky enough to have lived in Paris as a young man, then wherever you go for the rest of your life it stays with you, for Paris is a moveable feast.\n\n- Ernest Hemingway")
                                .fontWeight(.heavy)
                                .font(.system(.headline, design: .rounded))
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(10)
                                .opacity(0.8)
                                .padding(),

                            alignment: .top
                )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

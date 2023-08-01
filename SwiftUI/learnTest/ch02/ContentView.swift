//
//  ContentView.swift
//  ch02
//
//  Created by on 2023/8/1.
//
//  第 2 章SwiftUI 入門-文字的處理
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            // defalut text
//            Text("Stay Hungry. Stay Foolish.")
            // bold
//            Text("Stay Hungry. Stay Foolish.").fontWeight(.bold)
            // blod + title
//            Text("Stay Hungry. Stay Foolish.")
//                .fontWeight(.bold)
//                .font(.title)
            // system font
            Text("Stay Hungry. Stay Foolish.")
                .fontWeight(.bold)
                .font(.system(.largeTitle, design: .rounded))
            // system size + color
            Text("Stay Hungry. Stay Foolish.")
                .font(.system(size: 20))
                .foregroundColor(.green)
            //多行(switUI下文字預設是多行處理)
            Text("Your time is limited, so don’t waste it living someone else’s life. Don’t be trapped by dogma—which is living with the results of other people’s thinking. Don’t let the noise of others’ opinions drown out your own inner voice. And most important, have the courage to follow your heart and intuition.")
                .fontWeight(.bold)
                .font(.title)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)// 置中
                .lineLimit(3)//限制行數
                .truncationMode(.head)//修改文字的截斷模式(預設設定是截斷字尾)
            //間距與行距
            Text("Stay Hungry. Stay Foolish.")
                .multilineTextAlignment(.center)// 置中
                .lineSpacing(10)//文字間距
                .padding()//UI與UI的間距
                .rotationEffect(.degrees(45))//旋轉
            //以特定點來旋轉（譬如左上角）
            //位置是該UI本身的座標
            Text("Stay Hungry. Stay Foolish.")
                .rotationEffect(.degrees(20), anchor: UnitPoint(x: 0, y: 0))
            // 3D旋轉效果
            Text("Stay Hungry. Stay Foolish.")
                .rotation3DEffect(.degrees(60), axis: (x: 1, y: 0, z: 0))
                .shadow(color: .gray, radius: 2, x: 0, y: 15)//陰影
            //自定義字體
            Text("Stay Hungry. Stay Foolish.")
                .font(.custom("NotoSansTC-Regular", size: 25))
            //MARKDOWN:SwiftUI 內置了對 Markdown 的支援
            Text("**This is how you bold a text**. *This is how you make text italic.* You can [click this link](https://www.appcoda.com) to go to appcoda.com")
                .font(.title)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

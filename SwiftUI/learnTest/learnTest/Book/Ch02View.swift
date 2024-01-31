//
//  Ch02View.swift
//  learnTest
//
//  Created by on 2024/1/30.
//

import SwiftUI

/**
 1.文字簡單呈現：Text("內容")
 2.使用點語法（dot syntax）來存取修飾器，使其改變性質，如下
   粗體：.fontWeight(.bold)
   大小：.font(.system(size: 20))
   顏色：.foregroundColor(.green)
 3.預設支援多行文字，能夠下些修飾器
 置中對齊：.multilineTextAlignment(.center)
 限制行數：.lineLimit(3)
 預設設定是截斷字尾，改成截斷字頭：.truncationMode(.head)
 4.間距與行距
 行距：.lineSpacing(10)
 間距：.padding()
 5.旋轉：.rotationEffect(.degrees(45))
 degrees是旋轉角度，如果要以特定座標旋轉(預設為中心點)：.rotationEffect(.degrees(20), anchor: UnitPoint(x: 0, y: 0))
 3D 效果：.rotation3DEffect(.degrees(60), axis: (x: 1, y: 0, z: 0))
 陰影效果：.shadow(color: .gray, radius: 2, x: 0, y: 15)
 6.自訂字體
 需要將字體存入專案，然後以語法.font(.custom("Nunito", size: 25))帶入匯入的字型就好
 7.SwiftUI 內置了對 Markdown 的支援。
 */
struct Ch02View: View {
    var body: some View {
//        Text("Your time is limited, so don’t waste it living someone else’s life. Don’t be trapped by dogma—which is living with the results of other people’s thinking. Don’t let the noise of others’ opinions drown out your own inner voice. And most important, have the courage to follow your heart and intuition.")
////            .fontWeight(.bold)
////            .font(.title)
//            .foregroundColor(.gray)
//            .multilineTextAlignment(.center)
//            .font(.custom("Nunito", size: 25))
        Text("**This is how you bold a text**. *This is how you make text italic.* You can [click this link](https://www.appcoda.com) to go to appcoda.com")
            .font(.custom("Nunito", size: 25))
    }
}
/**
 iOS17之後，Preview被縮寫了。
 
 原有的表示方法為:
 struct Ch02View_Previews: PreviewProvider {
    static var previews: some View {
        Ch02View()
    }
 
 }
 */
#Preview {
    Ch02View()
}

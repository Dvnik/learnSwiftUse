//
//  Ch03View.swift
//  learnTest
//
//  Created by on 2024/1/31.
//

import SwiftUI



/**
 1.SF Symbols，apple以字形的方式作成的一套iCon庫，亦可當作image使用。
 這套是有獨立的應用程式，可以單獨下載使用。
 同時也被當成系統圖庫。
 使用方式：Image(systemName: "cloud.heavyrain")
 2.能夠做出如同Text的修飾詞.frame(width: 300)
 3.要顯示自己的圖片，要先將圖片放在「Assets」中，再以語法Image("paris")呼叫
 4.重新調整大小，預設為在安全區域裡面：.resizable()
 5.忽略安全區域：.ignoresSafeArea(.container, edges: .bottom)
 6.保持原來的長寬比：.scaledToFit()或.aspectRatio(contentMode: .fit)
 7.長寬比保持一樣，但儘可能地延伸：.aspectRatio(contentMode: .fill)
 8.限制圖片的大小：.frame(width: 300)
 9.裁切視圖：.clipped()
 10.圓形圖片：.clipShape(Circle())
 11.不透明度的調整：opacity
 10.圖片重疊：.overlay(
 Image(systemName: "heart.fill")
     .font(.system(size: 50))
     .foregroundColor(.black)
     .opacity(0.5)
)
 11.overlay可以疊任何視圖(View)
 12.重疊來使圖片變暗：
 .overlay(
         Rectangle()
             .foregroundColor(.black)
             .opacity(0.4)
     )
 或
 .overlay(
         Color.black
             .opacity(0.4)
     )
 13.SF Symbols 的自定義顏色：
 Image(systemName: "cloud.sun.rain")
     .symbolRenderingMode(.palette)
     .foregroundStyle(.indigo, .yellow, .gray)
 */
struct Ch03View: View {
    var body: some View {
        Image("paris")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 300)
            .overlay(
                Color.black
                    .opacity(0.4)
                    .overlay(
                        Text("Paris")
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .foregroundColor(.white)
                            .frame(width: 200)
                    )
            )
        
        
    }
    
}

#Preview {
    Ch03View()
}

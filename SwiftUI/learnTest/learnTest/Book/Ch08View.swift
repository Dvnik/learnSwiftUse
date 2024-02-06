//
//  Ch08View.swift
//  learnTest
//
//  Created by 翊軒 on 2024/2/1.
//
// 實作路徑與形狀來繪製線條與圓餅圖

import SwiftUI

/**
 在 SwiftUI 中，你可使用 Path 繪製線條與形狀。如果你參考 Apple 的文件 (https://developer.apple.com/documentation/swiftui/path)
 
 基本上，線條與形狀是以路徑逐步描繪
 
 你不需要以顏色填滿整個區域，如果你只想繪製線條的話，則可以使用 .stroke 修飾器，並指定線條的寬度與顏色
 
 * 使用內建形狀
 SwiftUI其實有幾種內建形狀，如圓形（ Circle ）、矩形（ Rectangle ）、圓角矩形（ RoundedRectangle ）與橢圓（ Ellipse ）等
 
 */

struct Ch08View: View {
    
    private var purpleGradient = LinearGradient(gradient: Gradient(colors: [ Color(red: 207/255, green: 150/255, blue: 207/255), Color(red: 107/255, green: 116/255, blue: 179/255) ]), startPoint: .trailing, endPoint: .leading)
    
    var body: some View {
        /**
         Path的繪畫方式：
         1.移動至點( 20, 20)。
         2.從( 20, 20 )畫一條線至( 300, 20 )。
         3.從( 300, 20 畫一條線至 (300, 200 )。
         4.從( 300, 200 ) 畫一條線至( 20, 200 )。
         5.以綠色填滿整個區域。
         
         ex:要封閉路徑的話，你可以在 Path 閉包的結尾處呼叫 closeSubpath() 方法
         */
        //        Path() { path in
        //            path.move(to: CGPoint(x: 20, y: 20))
        //            path.addLine(to: CGPoint(x: 300, y: 20))
        //            path.addLine(to: CGPoint(x: 300, y: 200))
        //            path.addLine(to: CGPoint(x: 20, y: 200))
        //            path.closeSubpath()
        //        }
        ////        .fill(.green)
        //        .stroke(.green, lineWidth: 10)
        /**
         繪製曲線
         使用 addQuadCurve、addCurve 與 addArc 方法來繪製出曲線與圓弧。
         
         Fill 與 Stroke
         這邊的View一次只做一件事，所以要能夠填滿＋編匡就要用兩個View實踐。
         */
        //        ZStack {
        //            Path() { path in
        //                path.move(to: CGPoint(x: 20, y: 60))
        //                path.addLine(to: CGPoint(x: 40, y: 60))
        //                path.addQuadCurve(to: CGPoint(x: 210, y: 60), control: CGPoint(x: 125, y: 0))
        //                path.addLine(to: CGPoint(x: 230, y: 60))
        //                path.addLine(to: CGPoint(x: 230, y: 100))
        //                path.addLine(to: CGPoint(x: 20, y: 100))
        //            }
        //            .fill(Color.purple)
        //
        //            Path() { path in
        //                path.move(to: CGPoint(x: 20, y: 60))
        //                path.addLine(to: CGPoint(x: 40, y: 60))
        //                path.addQuadCurve(to: CGPoint(x: 210, y: 60), control: CGPoint(x: 125, y: 0))
        //                path.addLine(to: CGPoint(x: 230, y: 60))
        //                path.addLine(to: CGPoint(x: 230, y: 100))
        //                path.addLine(to: CGPoint(x: 20, y: 100))
        //                path.closeSubpath()
        //            }
        //            .stroke(Color.black, lineWidth: 5)
        //        }
        /**
         繪製圓弧與圓餅圖
         addArc 方法接受幾個參數：
         
         center - 圓的中心點。
         radius - 建立圓弧的圓半徑。
         startAngle - 圓弧的起點角度。
         endAngle - 圓弧的終點角度。
         clockwise - 畫圓弧的方向。
         */
        //        VStack {
        //            ZStack {
        //                Path { path in
        //                    path.move(to: CGPoint(x: 187, y: 187))
        //                    path.addArc(center: .init(x: 187, y: 187), radius: 150, startAngle: .degrees(0), endAngle: .degrees(190), clockwise: true)
        //                }
        //                .fill(.yellow)
        //
        //                Path { path in
        //                    path.move(to: CGPoint(x: 187, y: 187))
        //                    path.addArc(center: .init(x: 187, y: 187), radius: 150, startAngle: .degrees(190), endAngle: .degrees(110), clockwise: true)
        //                }
        //                .fill(.teal)
        //
        //                Path { path in
        //                    path.move(to: CGPoint(x: 187, y: 187))
        //                    path.addArc(center: .init(x: 187, y: 187), radius: 150, startAngle: .degrees(110), endAngle: .degrees(90), clockwise: true)
        //                }
        //                .fill(.blue)
        //
        //                /**
        //                 有時，你可能想從圓餅圖切分出來，以突顯特定的扇形。舉例而言，要以紫色突顯扇形時，你可以應用 offset 修飾器來改變扇形的位置：
        //                 */
        //                Path { path in
        //                    path.move(to: CGPoint(x: 187, y: 187))
        //                    path.addArc(center: .init(x: 187, y: 187), radius: 150, startAngle: .degrees(90), endAngle: .degrees(360), clockwise: true)
        //                }
        //                .fill(.purple)
        //                .offset(x: 20, y: 20)
        //                /**
        //                 或者，你可以疊加一個邊框來進一步吸引人們目光。如果你要在突顯的扇形上加入標籤，則可以疊上一個 Text 視圖，如下所示：
        //                 */
        //                .overlay(
        //                    Text("25%")
        //                        .font(.system(.largeTitle, design: .rounded))
        //                        .bold()
        //                        .foregroundColor(.white)
        //                        .offset(x: 80, y: -110)
        //                )
        //            }
        //
        //
        
        //
        //        }
        
        //        Button(action: {
        //            // 執行動作
        //        }) {
        //            Text("Test")
        //                .font(.system(.title, design: .rounded))
        //                .bold()
        //                .foregroundColor(.white)
        //                .frame(width: 250, height: 50)
        //                .background(Dome().fill(Color.red))
        //        }
        //
        
        
        
        /**
         使用 Shape 建立進度指示器
         
         建立一個開口圓環的技巧是加上一個 trim 修飾器。你可指定 from 值與 to 值，以指示要顯示圓環的哪一個部分，在這個範例中，我們想要顯示 85% 的進度，所以設定 from 的值為「0」、to 的值為「0.85」。
         */
        VStack {
            ZStack {
                Circle()
                    .stroke(Color(.systemGray6), lineWidth: 20)
                    .frame(width: 300, height: 300)
                Circle()
                    .trim(from: 0, to: 0.85)
                    .stroke(purpleGradient, lineWidth: 20)
                    .frame(width: 300, height: 300)
                    .overlay {
                        VStack {
                            Text("85%")
                                .font(.system(size: 80, weight: .bold, design: .rounded))
                                .foregroundColor(.gray)
                            Text("Complete")
                                .font(.system(.body, design: .rounded))
                                .bold()
                                .foregroundColor(.gray)
                        }
                    }
                
            }
            // trim 修飾器的活用
            ZStack {
                Circle()
                    .trim(from: 0, to: 0.4)
                    .stroke(Color(.systemBlue), lineWidth: 80)

                Circle()
                    .trim(from: 0.4, to: 0.6)
                    .stroke(Color(.systemTeal), lineWidth: 80)

                Circle()
                    .trim(from: 0.6, to: 0.75)
                    .stroke(Color(.systemPurple), lineWidth: 80)

                Circle()
                    .trim(from: 0.75, to: 1)
                    .stroke(Color(.systemYellow), lineWidth: 90)
                    .overlay(
                        Text("25%")
                            .font(.system(.title, design: .rounded))
                            .bold()
                            .foregroundColor(.white)
                            .offset(x: 80, y: -100)
                    )
            }
            .frame(width: 250, height: 250)
        }
        
    }
}

#Preview {
    Ch08View()
}


/**
 想要建立一個圓頂（Dome）形狀、大小彈性的按鈕，該如何實作呢？

 可以建立一個結構來採用 Shape 協定，並實作 path(in:) 函數。當 path(in:) 函數被框架呼叫時，你將獲得 rect 的大小，然後可在 rect 中繪製路徑。
 
 
 */
struct Dome: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: 0, y: 0))
        path.addQuadCurve(to: CGPoint(x: rect.size.width, y: 0), control: CGPoint(x: rect.size.width/2, y: -(rect.size.width * 0.1)))
        path.addRect(CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height))

        return path
    }
}

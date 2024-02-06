//
//  Ch09View.swift
//  learnTest
//
//  Created by 翊軒 on 2024/2/5.
//
// 基礎動畫與轉場

import SwiftUI

/**
 隱式動畫與顯式動畫
 SwiftUI 提供兩種動畫類型：隱式（ implicit ）與顯式（ explicit ）。
 
 延遲動畫
 SwiftUI 框架不只讓你可以控制動畫的持續時間，你可以透過 delay 函數來延遲動畫， 如下所示：

 Animation.default.delay(1.0)
 這會將動畫延遲1 秒後開始。delay 函數也適用其他動畫。
 
 了解轉場
 
 SwiftUI 讓開發者不只是做出前述的動畫，你可以定義如何從視圖層次中插入或移除視圖，而在 SwiftUI 中，這就是所謂的「轉場」（ transition ）。框架預設是使用淡入（ fade in ）與淡出（ fade out ）轉場。不過它內建了幾個現成的轉場效果，如滑動（ slide ）、移動（ move）、不透明度（opacity ）等。當然，你可以開發自己的轉場效果，也可以簡單的混合搭配各種類型的轉場，以建立所需的轉場效果。
 
 
 
 */
struct Ch09View: View {
    @State private var circleColorChanged = false
    @State private var heartColorChanged = false
    @State private var heartSizeChanged = false
    
    @State private var isLoading = false
    
    @State private var progress: CGFloat = 0.0
    
    @State private var recordBegin = false
    @State private var recording = false
    
    @State private var show = false
    
    var body: some View {
        
        VStack {
            //隱式動畫
            //            ImplicitAnimeView(circleColorChanged: $circleColorChanged, heartColorChanged: $heartColorChanged, heartSizeChanged: $heartSizeChanged)
            //顯式動畫
            //            ExplicitAnimeView(circleColorChanged: $circleColorChanged, heartColorChanged: $heartColorChanged, heartSizeChanged: $heartSizeChanged)
            //使用RotationEffect 建立下載指示器
            //            CircleLoadingView(isLoading: self.$isLoading)
            //下載指示器(橫向)
            //            FlatLoadingView(isLoading: self.$isLoading)
            //建立進度指示器
            //            ProgressLoadingView(progress: $progress)
            //圓點下載指示器
            PointLoadingView(isLoading: self.$isLoading)
            
            //將矩形變形為圓形
            //            RecoindButtonView(recordBegin: $recordBegin, recording: $recording)
            //轉場效果
            TwoTrctangleAnimeView(show: $show)
            
            
            
            //end
        }
    }
}

#Preview {
    Ch09View()
}
/**
 圓點下載指示器
 這個指示器由五個點組成，每個點皆有放大縮小動畫，不過各有不同的延遲時間。我們來看程式碼該如何實作：
 */
struct PointLoadingView: View {
    @Binding var isLoading: Bool
    
    
    var body: some View {
        HStack {
            ForEach(0...4, id: \.self) { index in
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(.green)
                    .scaleEffect(self.isLoading ? 0 : 1)
                    .animation(.linear(duration: 0.6).repeatForever().delay(0.2 * Double(index)), value: isLoading)
            }
        }
        .onAppear() {
            self.isLoading = true
        }
    }
}
/**
 建立進度指示器
 下載指示器向使用者提供一些回饋，其表示 App 正在處理某些事情。不過，它並沒有顯示實際進度
 
 建立進度指示器的方式與下載指示器非常相似。不過，你需要使用狀態變數來追蹤進度。
 */
struct ProgressLoadingView: View {
    @Binding var progress: CGFloat
    
    
    var body: some View {
        ZStack {
            Text("\(Int(progress * 100))%")
                .font(.system(.title, design: .rounded))
            .bold()
            
            Circle()
                .stroke(Color(.systemGray5), lineWidth: 10)
                .frame(width: 150, height: 150)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.green, lineWidth: 10)
                .frame(width: 150, height: 150)
                .rotationEffect(Angle(degrees: -90))
        }
        .onAppear() {
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                self.progress += 0.05
                print(self.progress)
                if self.progress >= 1.0 {
                    timer.invalidate()
                }
            }
        }
    }
}
/**
 下載指示器(橫向)
 你也可以使用 Rectangle 或 RoundedRectangle 來建立該指示器。不過，無需更改旋轉角度，你可以修改位移值（offset value）來建立
 */

struct FlatLoadingView: View {
    @Binding var isLoading: Bool
    
    var body: some View {
        ZStack {
            Text("Loading")
                .font(.system(.body, design: .rounded))
                .bold()
            .offset(x: 0, y: -25)
            
            RoundedRectangle(cornerRadius: 3)
                .stroke(Color(.systemGray5), lineWidth: 3)
                .frame(width: 250, height: 3)
            
            RoundedRectangle(cornerRadius: 3)
                .stroke(Color.green, lineWidth: 3)
                .frame(width: 30, height: 3)
                .offset(x: isLoading ? 110 : -110, y: 0)
                .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: isLoading)
        }
        .onAppear() {
            self.isLoading = true
        }
    }
}
/**
 使用RotationEffect 建立下載指示器
 如何使圓環連續旋轉呢？我們可以利用 rotationEffect 與 animation 修飾器。訣竅就是使圓環 360 度連續旋轉。以下為程式碼：
 */
struct CircleLoadingView: View {
    @Binding var isLoading: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(.systemGray5), lineWidth: 14)
            .frame(width: 100, height: 100)
            Circle()
                .trim(from: 0, to: 0.2)
                .stroke(Color.green, lineWidth: 7)
                .frame(width: 100, height: 100)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: isLoading)
                .onAppear() {
                    self.isLoading = true
                }
        }
    }
}
/**
 顯式動畫
 你需要將狀態變化包裹在 withAnimation 區塊內。要建立相同的動畫效果，你可撰寫下列程式碼：
 */
struct ExplicitAnimeView: View {
    @Binding var circleColorChanged: Bool
    @Binding var heartColorChanged: Bool
    @Binding var heartSizeChanged: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 200, height: 200)
            .foregroundColor(circleColorChanged ? Color(.systemGray5) : .red)
            
            Image(systemName: "heart.fill")
                .foregroundColor(heartColorChanged ? .red : .white)
                .font(.system(size: 100))
                .scaleEffect(heartSizeChanged ? 1.0 : 0.5)
        }
        .onTapGesture {
            /**
             使用顯式動畫，你可以輕鬆控制想加上動畫的狀態。舉例而言，如果你不想為心形圖示的大小變化設定動畫時，則可以從 withAnimation 排除該行程式碼，如下所示：
             */
            withAnimation(.default) {
                self.circleColorChanged.toggle()
                self.heartColorChanged.toggle()
            }
            self.heartSizeChanged.toggle()
        }
    }
}
/**
 隱式動畫
 當使用者點擊心形或圓形時，圓形的顏色會變成淡灰色，而心形則會變成紅色，同時心形圖示的大小也變得較大。因此，以下是其狀態變化：
 
 1.圓的顏色會從紅色變成淡灰色。
 2.心形圖示的顏色會從白色變成紅色。
 3.心形圖示會比原來的大小大兩倍。
 要讓這些變化顯示動畫效果，你只需將 animation 修飾器加到 Circle 與 Image 視圖，你可以將 animation 修飾器加到 ZStack。
 */
struct ImplicitAnimeView: View {
    @Binding var circleColorChanged: Bool
    @Binding var heartColorChanged: Bool
    @Binding var heartSizeChanged: Bool
    
    var body: some View {
        
        ZStack {
            Circle()
                .frame(width: 200, height: 200)
            .foregroundColor(circleColorChanged ? Color(.systemGray5) : .red)
            Image(systemName: "heart.fill")
                .foregroundColor(heartColorChanged ? .red : .white)
                .font(.system(size: 100))
                .scaleEffect(heartSizeChanged ? 1.0 : 0.5)
        }
        .animation(.default, value: circleColorChanged)
        .animation(.default, value: heartSizeChanged)
        .onTapGesture {
            circleColorChanged.toggle()
            heartColorChanged.toggle()
            heartSizeChanged.toggle()
        }
    }
}
/**
 將矩形變形為圓形
 
 將矩形變形為圓形的技巧是使用 RoundedRectangle 形狀，並為圓角半徑的變化設定動畫。假設矩形的寬度與高度相同，當圓角半徑設定為寬度的一半時，它會變為圓形。以下是變形按鈕的實作：
 */
struct RecoindButtonView: View {
    @Binding var recordBegin: Bool
    @Binding var recording: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: recordBegin ? 30 : 5)
                .frame(width: recordBegin ? 60 : 250, height: 60)
                .foregroundColor(recordBegin ? .red : .green)
                .overlay(
                    Image(systemName: "mic.fill")
                        .font(.system(.title))
                        .foregroundColor(.white)
                        .scaleEffect(recording ? 0.7 : 1)
                )
            RoundedRectangle(cornerRadius: recordBegin ? 35 : 10)
                .trim(from: 0, to: recordBegin ? 0.0001 : 1)
                .stroke(lineWidth: 5)
                .frame(width: recordBegin ? 70 : 260, height: 70)
                .foregroundColor(.green)
        }
        .onTapGesture {
            withAnimation(Animation.spring()) {
                self.recordBegin.toggle()
            }
            
            withAnimation(Animation.spring().repeatForever().delay(0.5)) {
                self.recording.toggle()
            }
        }
    }
}
/**
 
 在某些情況下，如果你需要定義一個可以重複利用的動畫，你可以在 AnyTransition 定義一個擴展（extension ），如下所示：

 */
extension AnyTransition {
    static var offsetScaleOpacity: AnyTransition {
        AnyTransition.offset(x: -600, y: 0).combined(with: .scale).combined(with: .opacity)
    }
    //重新使用不對稱轉場
    static var scaleAndOffset: AnyTransition {
           AnyTransition.asymmetric(
               insertion: .scale(scale: 0, anchor: .bottom),
               removal: .offset(x: -600, y: 00)
           )
       }
}

struct TwoTrctangleAnimeView: View {
    @Binding var show: Bool
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 300, height: 300)
                .foregroundColor(.green)
                .overlay(
                    Text("Show details")
                        .font(.system(.largeTitle, design: .rounded))
                        .bold()
                        .foregroundColor(.white)
                    
            )
            if show {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 300, height: 300)
                    .foregroundColor(.purple)
                    .overlay(
                        Text("Well, here is the details")
                            .font(.system(.largeTitle, design: .rounded))
                            .bold()
                            .foregroundColor(.white)
                        /**
                         如前所述，如果你沒有指定想使用的轉場效果，SwiftUI 將渲染淡入淡出轉場。要使用其他的轉場效果，則在紫色矩形中加入 transition 修飾器。
                         
                         .transition(.scale(scale: 0, anchor: .bottom))
                         
                         除了 .scale 之外，SwiftUI 框架還有多個內建的轉場效果，包括 .opaque、.offset、.move 與 .slide。試著以位移轉場（offset transition）取代縮放轉場（scale transition）。
                         */
                        //                                .transition(.offset(x: -600, y: 0))
                        /**
                         混合式轉場
                         你可以呼叫 combined(with:) 方法來將兩個或者更多個轉場效果結合在一起，以建立更流暢的轉場效果。舉例而言，如果要結合位移與縮放動畫，則可以撰寫程式碼如下：
                         */
                        //                                .transition(AnyTransition.offset(x: -600, y: 0).combined(with: .scale))
                        //如果需要混合三個轉場效果的話，則可以參考以下這行的範例程式碼：
                        //                                .transition(AnyTransition.offset(x: -600, y: 0).combined(with: .scale).combined(with: .opacity))
                        //在 transition 修飾器中使用 offsetScaleOpacity(自訂名稱) 動畫：
//                            .transition(.offsetScaleOpacity)
                        /**
                         不對稱轉場
                         若你想在插入視圖時使用縮放轉場以及移除視圖時使用位移轉場呢？這在 SwiftUI 中，即所謂的「不對稱轉場」（ Assymetric Transitions ）。要使用這種轉場效果非常簡單，你只需要呼叫 .assymetric 方法，來指定插入（ insertion ）及移除（removal ）的轉場即可。
                         */
                            .transition(.asymmetric(insertion: .scale(scale: 0, anchor: .bottom), removal: .offset(x: -600, y: 0)))
                        
                        
                    )//end overlay
            }
        }
        .onTapGesture {
            withAnimation(Animation.spring()) {
                self.show.toggle()
            }
        }
        //end
    }
}

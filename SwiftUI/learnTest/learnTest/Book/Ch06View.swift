//
//  Ch06View.swift
//  learnTest
//
//  Created by on 2024/2/1.
//
// 使用 SwiftUI 按鈕、標籤與漸層

import SwiftUI


/**
 Swift UI的按鈕最基本形式：
 Button {
     // 所需執行的內容
 } label: {
     // 按鈕的外觀設定
 }
 所需執行的內容 - 使用者點擊或選擇按鈕後執行的程式碼。
 按鈕的外觀設定 - 描述外觀的程式碼區塊。
 
 ＊ 修飾器順序的重要性
 因為修飾器是由前到後執行，所以先操作的行為會影響後面操作的結果。
 例如：
 Text("Hello World")
     .background(Color.purple) // 1. 將背景色更改為紫色
     .foregroundColor(.white)  // 2. 將前景色 / 字型顏色設定為白色
     .font(.title)             // 3. 變更字型樣式
     .padding()                // 4. 使用主色來加入間距（ 即白色）
 與
 Text("Hello World")
     .padding()                // 1. 加入間距
     .background(Color.purple) // 2. 將背景色更改為紫色（ 包含間距）
     .foregroundColor(.white)  // 3. 將前景色/ 字型顏色設定為白色
     .font(.title)             // 4. 變更字型樣式
 
 結果會不一樣
 
 ＊建立具有圖片與文字的按鈕
 在「按鈕的外觀設定」區域放上Image即可
 預設上只會有一個View，所以要多個View要記得Stack
 * Label在SwfitUI能夠放置文字與圖片
 
 ＊ 漸層背景
 用LinearGradient，範例如下：
 .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
 *如果想自定義顏色，又不想寫太長，可以在Assets建立顏色並直接調用
 
 * SwiftUI 提供了一個名為 ButtonStyle的協定，可以讓你建立自己的按鈕樣式。
 
 *rotationEffect 修飾器可以用來旋轉按鈕（或者其他視圖）。*
 */
struct Ch06View: View {
    var body: some View {
        //        Button {
        //            print("Hello World tapped!")
        //        } label: {
        //            Text("Hello World")
        //                .fontWeight(.bold)
        //                .font(.title)
        //                .padding()
        //                .background(Color.purple)
        //                .foregroundColor(.white)
        //                .padding(10)
        //                .border(Color.purple, width: 5)
        //                .overlay {
        //                        RoundedRectangle(cornerRadius: 40)
        //                            .stroke(.purple, lineWidth: 5)
        //                    }
        //        }
        //        Button {
        //            print("Delete button tapped")
        //        } label: {
        //            HStack {
        //                Image(systemName: "trash")
        //                    .font(.title)
        //                Text("Delete")
        //                    .fontWeight(.semibold)
        //                    .font(.title)
        //            }
        //            .padding()
        //            .foregroundColor(.white)
        //            .background(Color.red)
        //            .cornerRadius(40)
        //        }
        VStack {
            Button {
                print("Share button tapped")
            } label: {
                Label(
                    title: {
                        Text("Share")
                            .fontWeight(.semibold)
                            .font(.title)
                    },
                    icon: {
                        Image(systemName: "square.and.arrow.up")
                            .font(.title)
                    }
                )
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(40)
                .padding(.horizontal, 20)
            }
            
            Button {
                print("Edit button tapped")
            } label: {
                Label(
                    title: {
                        Text("Edit")
                            .fontWeight(.semibold)
                            .font(.title)
                    },
                    icon: {
                        Image(systemName: "square.and.pencil")
                            .font(.title)
                    }
                )
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(40)
                .padding(.horizontal, 20)
            }
            
           
            // SwiftUI 提供了一個名為 .buttonStyle的修飾器，讓你可以應用按鈕樣式，如下所示：
            Button {
                print("Delete button tapped")
            } label: {
                Label(
                    title: {
                        Text("Delete")
                            .fontWeight(.semibold)
                            .font(.title)
                    },
                    icon: {
                        Image(systemName: "trash")
                            .font(.title)
                    }
                )
            }
            .buttonStyle(GradientBackgroundStyle())
            /**
             在 iOS 15 中，Apple 為 Button 視圖引入了許多修飾符。
             tint 修飾器指定按鈕的顏色。
             .borderedProminent 樣式，iOS 將按鈕呈現為紫色背景並以白色顯示文字。
             .buttonBorderShape 修飾器可讓你設置按鈕的邊框形狀。
             .roundedRectangle 使按鈕變圓角。
             .controlSize 允許你更改按鈕的大小。 預設大小為 .regular。
             */
            Button {

            } label: {
                Text("Buy me a coffee")
            }
            .tint(.purple)
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.roundedRectangle(radius: 5))
            .controlSize(.large)
            //使用按鈕樣式，你可以輕鬆地將相同的樣式應用於一組按鈕。
            VStack {
                Button(action: {}) {
                    Text("Add to Cart")
                        .font(.headline)
                }

                Button(action: {}) {
                    Text("Discover")
                        .font(.headline)
                        .frame(maxWidth: 300)
                }

                Button(action: {}) {
                    Text("Check out")
                        .font(.headline)
                }
            }
            .tint(.purple)
            .buttonStyle(.bordered)
            .controlSize(.large)
            /**
             按鈕角色
             自 iOS 15 版本開始，SwiftUI 框架為Button引入了一個新的role選項。 此選項描述按鈕的語義角色。 根據指定的角色，iOS 會自動為按鈕呈現適當的外觀。
             
             將角色定義為 .destructive ：
             */
            Button("Delete", role: .destructive) {
                print("Delete")
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
    }
}

#Preview {
    Ch06View()
}

//* SwiftUI 提供了一個名為 ButtonStyle的協定，可以讓你建立自己的按鈕樣式。
struct GradientBackgroundStyle: ButtonStyle {

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(40)
            .padding(.horizontal, 20)
        //可以透過 configuration 的 isPressed 屬性，來判斷按鈕是否有被按下，這可以讓你在使用者按下它時改變按鈕的樣式。
        //scaleEffect 修飾器可以讓你縮放按鈕（或任何視圖）。
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

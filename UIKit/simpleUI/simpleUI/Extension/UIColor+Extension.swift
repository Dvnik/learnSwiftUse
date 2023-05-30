//
//  UIColor+Extension.swift
//  simpleUI
//
//  Created on 2023/5/30.
//

import UIKit

extension UIColor {
    // color init with hex alpha
    convenience init?(hex: String) {
        let formattedHex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        if formattedHex.count != 6 && formattedHex.count != 8 {
            return nil
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: formattedHex).scanHexInt64(&rgbValue)
        /**
         當我們使用位移操作和位遮罩來處理色碼值時，我們可以將整個過程簡化為以下幾個步驟：

         - 獲取紅色值（Red）：將 rgbValue 向右位移 16 位（如果有 alpha 則位移 24 位），然後使用位遮罩 0xFF 提取最低 8 位的值。
         - 獲取綠色值（Green）：將 rgbValue 向右位移 8 位（如果有 alpha 則位移 16 位），然後使用位遮罩 0xFF 提取最低 8 位的值。
         - 獲取藍色值（Blue）：將 rgbValue 向右位移 0 位（如果有 alpha 則位移 8 位），然後使用位遮罩 0xFF 提取最低 8 位的值。
         - 獲取透明度值（Alpha）：如果有 alpha（即 hasAlpha 為 true），則將 rgbValue 向右位移 24 位，然後使用位遮罩 0xFF 提取最低 8 位的值；否則，設置透明度為 1.0。
         這樣，我們就可以從 HEX 碼中提取出紅、綠、藍和透明度的值，並將它們轉換為 0.0 到 1.0 之間的浮點數，以便創建 UIColor 對象。

         使用位移操作和位遮罩的好處是，我們可以直接從整個 rgbValue 中提取需要的位元組，而不需要根據 hasAlpha 執行不同的位移和位遮罩操作。這種方法更加簡潔和有效。
         by ChatGPT
         */
        let hasAlpha = (formattedHex.count == 8)
        let red = CGFloat((rgbValue >> (hasAlpha ? 24 : 16)) & 0xFF) / 255.0
        let green = CGFloat((rgbValue >> (hasAlpha ? 16 : 8)) & 0xFF) / 255.0
        let blue = CGFloat((rgbValue >> (hasAlpha ? 8 : 0)) & 0xFF) / 255.0
        let alpha = hasAlpha ? CGFloat((rgbValue >> 0) & 0xFF) / 255.0 : 1.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    
    class func colorWithHex(rgbValue: UInt64, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor( red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                        alpha: alpha)
    }
    
    class func colorWithHexString(hexStr: String, alpha: CGFloat = 1.0) -> UIColor {
        var cString:String = hexStr.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (hexStr.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if (cString.isEmpty || (Substring(cString).count) != 6) {
            return colorWithHex(rgbValue: 0xFF5300);
        } else {
            var rgbValue:UInt64 = 0
            Scanner(string: cString).scanHexInt64(&rgbValue)
            
            return colorWithHex(rgbValue: rgbValue, alpha: alpha);
        }
    }
    
    class func randomColor() -> UIColor {
        let randomHex = String(format: "%06X", arc4random_uniform(0xFFFFFF))
        return UIColor(hex: randomHex)!
    }
}

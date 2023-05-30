//
//  CircleUIControl.swift
//
//  Created on 2023/5/29.
//
//  嘗試以view本身的大小來畫圓，僅自定義邊線和與內圓的間隔
//

import UIKit

@IBDesignable
class CircleUIControl: UIControl {
    //MARK: @IBInspectable
    // 邊線：指重畫邊線的部分
    @IBInspectable var borderColor:UIColor! = .lightGray {
        didSet{
            displayBorder()
        }
    }
    
    @IBInspectable var borderWidth:CGFloat = 0.0 {
        didSet{
            displayBorder()
        }
    }
    // 內圓與邊線間距：重畫內圓
    @IBInspectable var spacing:CGFloat = 0.0 {
        didSet{
            displayCircle()
        }
    }
    
    //MARK: values
    var innerCircle: UIView?
    var outerBorder: UIView?
    //MARK: override
    override func draw(_ rect: CGRect) {
        settingView()
    }
    // 內圓：重畫內圓，顏色吃tintColor，所以override方法tintColorDidChange()
    override func tintColorDidChange() {
        super.tintColorDidChange()
        
        displayCircle()
    }
    //MARK: functions
    private func settingView() {
        addViews()
        displayCircle()
        displayBorder()
    }
    /// 畫內圓
    private func displayCircle() {
        guard let innerView = innerCircle else { return }
        // 取得frame位置
        innerView.frame = getCircleRect(isInner: true)
        //顏色指定和view的tintColor一致
        innerView.backgroundColor = self.tintColor
        //設定為圓形的方法
        innerView.layer.cornerRadius = innerView.frame.height / 2
    }
    /// 畫邊線
    private func displayBorder() {
        guard let borderView = outerBorder else { return }
        // 取得frame位置
        borderView.frame = getCircleRect(isInner: false)
        //borderView的backgroundColor一定是透明的，不然就會蓋掉innerView
        borderView.backgroundColor = UIColor.clear
        //同上述設定
        borderView.layer.borderWidth = borderWidth
        borderView.layer.borderColor = borderColor.cgColor
        //設定為圓形的方法
        borderView.layer.cornerRadius = borderView.frame.height / 2
    }
    /// 取得畫圓範圍
    /// isInner = true 給內圓CGRect
    private func getCircleRect(isInner: Bool) -> CGRect {
        // 抓取view的長寬
        let frameWidth = self.frame.width
        let frameHeight = self.frame.height
        // 圓設定在中心點，且最大僅能貼齊長或寬，因此只能選擇最短的邊來畫
        let uiDiameter: CGFloat = frameWidth > frameHeight ? frameHeight : frameWidth
        /// isInner是判斷該CGRect是不是內圓
        /// 內圓：
        /// innerView.frame的繪畫位置和座標起始點有關，預設的0,0起始座標是位於左上角
        /// 因此計算位置的點就是移動到對應的中心位置開始畫
        /// 外圓(邊線)：
        /// 邊線不需要顧慮內圓空間，所以等同uiDiameter的設定就行了
        let setDiameter = isInner ? uiDiameter - (borderWidth * 2) - spacing : uiDiameter
        // 回傳結果
        return CGRect(x: (frameWidth - setDiameter) / 2,
               y: (frameHeight - setDiameter) / 2,
               width: setDiameter, height: setDiameter)
    }
    // 初始化元件
    private func addViews() {
        if innerCircle == nil {
            innerCircle = UIView()
            innerCircle?.isUserInteractionEnabled = false
            innerCircle?.clipsToBounds = true
            self.addSubview(innerCircle!)
        }
        
        if outerBorder == nil {
            outerBorder = UIView()
            outerBorder?.isUserInteractionEnabled = false
            outerBorder?.clipsToBounds = true
            self.addSubview(outerBorder!)
        }
    }
}

//
//  ShowGestureViewController.swift
//  simpleUI
//
//  Created on 2023/5/30.
//

import UIKit

class ShowGestureViewController: UIViewController {
    
    //MARK: @IBOutlet
    @IBOutlet weak var txvStatusInfo: UITextView!
    @IBOutlet weak var viewDisplay: UIView!
    //MARK: values
    var sgMaker = SimpleGestureMaker()
    
    var fullSize :CGSize!// 螢幕的尺寸
    
    var viewSwipe: UIView!
    var viewPan: UIView!
    var imgPinch: UIImageView!
    var imgRotation: UIImageView!
    // GestureRecognizer
    var doubleFinger: UITapGestureRecognizer?
    var singleFinger: UITapGestureRecognizer?
    
    var longPressFinger: UILongPressGestureRecognizer?
    var swipeActions: [UISwipeGestureRecognizer]?
    var panFinger: UIPanGestureRecognizer?
    var pinchFinger: UIPinchGestureRecognizer?
    var rotationFinger: UIRotationGestureRecognizer?
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        txvStatusInfo.text = ""
        txvStatusInfo.isScrollEnabled = true
        // 取得螢幕的尺寸
        fullSize = UIScreen.main.bounds.size
        // 初始化
        initGesture()
    }
    //MARK: private functions
    private func initGesture() {
        sgMaker.delegate = self
        sgMaker.settingVC = self
        //註冊手勢
        registerTap()
        registerLongPress()
    }
    //輕點
    private func registerTap() {
        // 雙指輕點 2根指頭觸發
        doubleFinger = sgMaker.addTapAction(touchesRequired: 2)
        // 單指輕點 點2下才觸發
        singleFinger = sgMaker.addTapAction(tapsRequired: 2)
        // 雙指輕點沒有觸發時 才會檢測此手勢 以免手勢被蓋過
        singleFinger?.require(toFail: doubleFinger!)
    }
    // 長按
    private func registerLongPress() {
        longPressFinger = sgMaker.addLongPressAction()
    }
    // 滑動
    private func registerSwipe() {
        // 一個可供Swipe的 UILabel
        if viewSwipe == nil {
            viewSwipe = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            viewSwipe.backgroundColor = UIColor.randomColor()
            viewDisplay.addSubview(viewSwipe)
        }
        // 滑動手勢
        swipeActions = sgMaker.addSwipeAction()
    }
    // 拖曳
    private func registerPan() {
        // 一個可供移動的 UILabel
        if viewPan == nil {
            viewPan = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            viewPan.backgroundColor = UIColor.randomColor()
            
            viewDisplay.addSubview(viewPan)
        }
        // 拖曳手勢
        let panGesture = sgMaker.addPanAction()
        // 為這個可移動的 UIView 加上監聽手勢
        viewPan.addGestureRecognizer(panGesture)
        panFinger = panGesture
    }
    // 縮放
    private func registerPinch() {
        // 建立一個用來縮放的圖片
        if imgPinch == nil {
            imgPinch = UIImageView(image: UIImage(systemName: "globe.americas"))
            imgPinch.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
            viewDisplay.addSubview(imgPinch)
        }
        pinchFinger = sgMaker.addPinchAction()
    }
    // 旋轉
    private func registerRotation() {
        // 建立一個用來旋轉的圖片
        if imgRotation == nil {
            imgRotation = UIImageView(image: UIImage(systemName: "triangle"))
            imgRotation.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
            viewDisplay.addSubview(imgRotation)
        }
        rotationFinger = sgMaker.addRotationAction()
    }
    // 印訊息
    private func newTextInfo(text: String) {
        // 添加新的文本
        txvStatusInfo.text.append(text)
        
        // 捲動到最下方
        let range = NSRange(location: txvStatusInfo.text.count - 1, length: 1)
        txvStatusInfo.scrollRangeToVisible(range)
    }
    // 刪除和Button有關的Gesture
    private func removeGestureActions() {
        swipeActions?.forEach({ item in
            sgMaker.removeGesture(item)
        })
        if let panFinger = panFinger {
            sgMaker.removeGesture(panFinger, view: viewSwipe)
        }
        if let pinchFinger = pinchFinger {
            sgMaker.removeGesture(pinchFinger)
        }
        if let rotationFinger = rotationFinger {
            sgMaker.removeGesture(rotationFinger)
        }
        viewSwipe?.removeFromSuperview()
        viewSwipe = nil
        viewPan?.removeFromSuperview()
        viewPan = nil
        imgPinch?.removeFromSuperview()
        imgPinch = nil
        imgRotation?.removeFromSuperview()
        imgRotation = nil
    }
    
    @IBAction func clickSwipe(_ sender: Any) {
        removeGestureActions()
        registerSwipe()
    }
    
    @IBAction func clickPan(_ sender: Any) {
        removeGestureActions()
        registerPan()
    }
    @IBAction func clickPinch(_ sender: Any) {
        removeGestureActions()
        registerPinch()
    }
    @IBAction func clickRotation(_ sender: Any) {
        removeGestureActions()
        registerRotation()
    }
    
}
//MARK: SimpleGestureMakerDelegate
/**
 會寫成Delegate的原因，應該看Model的那個程式碼可以知道，
 每個註冊的Gesture都帶著自己的#selector(@objc)方法。
 那麼寫起來就會很散。
 
 另外delegate做成非強至實作的模式則是依照需求來使用這些手勢，而非每次用這個Model就要實作一堆手勢方法
 */
extension ShowGestureViewController: SimpleGestureMakerDelegate {
    func onTapped(times: Int, points: [CGPoint]) {
        print(#function)
        
        var content = "Tapped times:\(times)\n"
        for i in 0 ..< points.count {
            content += ">>>>第 \(i + 1) 指的位置：\(String(reflecting: points[i]))\n"
        }
        print(content)
        newTextInfo(text: content)
    }
    
    func onLongPress(state: UIGestureRecognizer.State, point: CGPoint?) {
        print(#function)
        
        var content = "Long Press, status:\(state)\n"
        if state == .began {
            content += "長按開始"
        }
        else if state == .ended {
            content += "長按結束"
        }
        
        if let point = point {
            content += "\n位置：\(point)"
        }
        print(content)
        newTextInfo(text: content)
    }
    
    func onSwipe(direction: UISwipeGestureRecognizer.Direction) {
        print(#function)
        
        var content = "Swipe Go"
        let point = viewSwipe.center
        var newPoint = CGPoint()
        
        if direction == .up {
            content += " UP\n"
            
            newPoint = point.y >= 150 ? CGPoint(x: point.x, y: point.y - 100) : CGPoint(x: point.x, y: 50)
        }
        else if direction == .left {
            content += " Left\n"
            
            newPoint = point.x >= 150 ? CGPoint(x: point.x - 100, y: point.y) : CGPoint(x: 50, y: point.y)
        }
        else if direction == .down {
            content += " Down\n"
            
            newPoint = point.y <= fullSize.height - 150 ? CGPoint(x: point.x, y: point.y + 100) : CGPoint(x: point.x, y: fullSize.height - 50)
        }
        else if direction == .right {
            content += " Right\n"
            
            newPoint = point.x <= fullSize.width - 150 ? CGPoint(x: point.x + 100, y: point.y) : CGPoint(x: fullSize.width - 50, y: point.y)
        }
        
        viewSwipe.center = newPoint
        print(content)
        newTextInfo(text: content)
    }
    
    func onPan(superView: UIView?, superPoint: CGPoint) {
        print(#function)
        
        // 設置 UIView 新的位置
        viewPan.center = superPoint
        let content = "Pan>拖曳位置:\(superPoint)\n"
        print(content)
        newTextInfo(text: content)
    }
    
    func onPinch(state: UIGestureRecognizer.State, scale: CGFloat, velocity: CGFloat) {
        print(#function)
        
        var content = "Pinch, status:\(state)\n"
        if state == .began {
            content += "開始縮放"
        }
        else if state == .ended {
            content += "結束縮放"
        }
        else if state == .changed {
            // 圖片原尺寸
            let frm = imgPinch.frame
            
            // 目前圖片寬度
            let w = frm.width

            // 目前圖片高度
            let h = frm.height

            // 縮放比例的限制為 0.5 ~ 2 倍
            if w * scale > 100 && w * scale < 400 {
                imgPinch.frame = CGRect(x: frm.origin.x,
                                           y: frm.origin.y,
                                           width: w * scale,
                                           height: h * scale)
                content += "縮放中："
            }
            else {
                content += "不在縮放設定範圍："
            }
            content += "寬>\(w),高>\(h),倍率>\(scale),velocity>\(velocity)\n"
        }
        print(content)
        newTextInfo(text: content)
    }
    
    func onRotation(angle: CGFloat, radianTransform: CGAffineTransform) {
        print(#function)
        
        imgRotation.transform = radianTransform
        let content = "旋轉角度： \(angle)\n"
        print(content)
        newTextInfo(text: content)
    }
}

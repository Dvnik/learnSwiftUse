//
//  MoveTextWithGestureViewController.swift
//  simpleUI
//
//  Created on 2023/5/30.
//
//  MoveSlideLineViewController的延伸，增加手勢
//

import UIKit

class MoveTextWithGestureViewController: UIViewController {
    //MARK: @IBOutlet
    @IBOutlet weak var circleCenterXConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var btnCircle: CircleUIControl!
    @IBOutlet weak var stackItems: UIStackView!
    
    @IBOutlet weak var lblShowAction: UILabel!
    //MARK: values
    var gestureMaker = SimpleGestureMaker()
    var actionNum: Int = 1 {
        didSet {
            movieNameToCenter()
        }
    }
    var stackColors: [UIColor]?
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
    }
    //MARK: private functions
    private func initUI() {
        stackColors = [UIColor]()
        stackItems.subviews.forEach { view in
            stackColors?.append(UIColor.randomColor())
        }
        //移動文字
        movieNameToCenter()
        //設定delegate和設定手勢的ViewController
        gestureMaker.delegate = self
        // 建立Swipe手勢
        _ = gestureMaker.addSwipeAction(view: self.view)
        // 中心的文字設為隨機色
        lblShowAction.textColor = UIColor.randomColor()
        // 設定點擊事件
        btnCircle.addTarget(self, action: #selector(circleClick), for: .touchUpInside)
    }
    //移動文字的所有步驟
    private func movieNameToCenter() {
        // 循環取出stackItems.subviews.count的餘數，實現循環的效果。
        let index = abs(actionNum) % stackItems.subviews.count
        let movieView = stackItems.subviews[index]
        // 移動
        movieFunctionName(movieView)
        // 改變按鈕顏色(更改透明度)
        changeColor()
        // 設定文字
        lblShowAction.text = "\(actionNum)"
    }
    /**
     此頁面需要移動的Constraint比較少的原因是
     1.移動的是字本身，而要對準的是btnCircle，因此沒有TopConstraint
     2.WidthConstraint不需要添加是因為stackItems設定所有元素等寬，沒有長短不一的問題
     
     基本上就是畫面的Constraint如何設定，在實行移動動畫的時候改變關聯的Constraint就好。
     
     */
    private func movieFunctionName(_ newView: UIView) {
        //先關閉
        circleCenterXConstraint.isActive = false
        //改值
        circleCenterXConstraint = btnCircle.leadingAnchor.constraint(equalTo: newView.leadingAnchor)
        //再Active
        circleCenterXConstraint.isActive = true
        //展現動畫
        UIViewPropertyAnimator(duration: 0.2, curve: .easeInOut) {
            self.view.layoutIfNeeded()
        }.startAnimation()
    }
    //更改UI的顏色
    private func changeColor() {
        let index = abs(actionNum) % stackItems.subviews.count
        
        for (i, item) in stackItems.subviews.enumerated() {
            guard let lblItem = item as? UILabel else { continue }
            
            lblItem.textColor = i == index ? stackColors?[i].withAlphaComponent(1.0) : stackColors?[i].withAlphaComponent(0.5)
        }
        btnCircle.borderColor = stackColors?[index]
    }
    //MARK: @objc
    @objc private func circleClick(_ sender: UIControl) {
        lblShowAction.text = "SnapShot!!"
        lblShowAction.textColor = UIColor.randomColor()
    }
}
//MARK: SimpleGestureMakerDelegate
extension MoveTextWithGestureViewController: SimpleGestureMakerDelegate {
    func onSwipe(direction: UISwipeGestureRecognizer.Direction) {
        if direction == .left {
            actionNum += 1
        }
        else if direction == .right {
            actionNum -= 1
        }
    }
}

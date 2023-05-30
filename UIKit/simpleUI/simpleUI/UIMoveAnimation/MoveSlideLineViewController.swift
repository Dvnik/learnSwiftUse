//
//  MoveSlideLineViewController.swift
//  simpleUI
//
//  Created on 2023/5/30.
//
//  參考：https://medium.com/%E5%BD%BC%E5%BE%97%E6%BD%98%E7%9A%84-swift-ios-app-%E9%96%8B%E7%99%BC%E6%95%99%E5%AE%A4/ios-24-%E6%90%AD%E9%85%8D%E5%8B%95%E7%95%AB%E7%9A%84%E6%B0%B4%E5%B9%B3%E6%BB%91%E5%8B%95%E5%BA%95%E7%B7%9A%E6%8C%89%E9%88%95%E8%88%87%E9%A0%81%E9%9D%A2%E6%8E%A7%E5%88%B6-f9bd34d433e1
//

import UIKit

class MoveSlideLineViewController: UIViewController {
    //MARK: @IBOutlet
    @IBOutlet weak var stackViewButtons: UIStackView!
    
    @IBOutlet weak var viewUnderLine: UIView!
    
    @IBOutlet weak var underLineWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var underLineLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var underLineTopConstraint: NSLayoutConstraint!
    
    

    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        moveColor(nil)
        viewUnderLine.isHidden = true
    }
    //MARK: functions
    private func moveColor(_ sender: UIButton?) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
            self.stackViewButtons.subviews.forEach { button in
                if let sender = sender, button == sender {
                    button.tintColor = button.tintColor.withAlphaComponent(1)
                }
                else {
                    button.tintColor = button.tintColor.withAlphaComponent(0.5)
                }
            }
        }
    }
    
    //MARK: @IBAction
    @IBAction func clickToMoveLine(_ sender: UIButton) {
        viewUnderLine.isHidden = false
        //先關閉
        underLineWidthConstraint.isActive = false
        underLineLeadingConstraint.isActive = false
        underLineTopConstraint.isActive = false
        //改值
        underLineWidthConstraint = viewUnderLine.widthAnchor.constraint(equalTo: sender.widthAnchor)
        underLineLeadingConstraint = viewUnderLine.leadingAnchor.constraint(equalTo: sender.leadingAnchor)
        underLineTopConstraint = viewUnderLine.topAnchor.constraint(equalTo: sender.bottomAnchor)
        //再Active
        underLineWidthConstraint.isActive = true
        underLineLeadingConstraint.isActive = true
        underLineTopConstraint.isActive = true
        //展現動畫
        UIViewPropertyAnimator(duration: 0.2, curve: .easeInOut) {
            self.view.layoutIfNeeded()
        }.startAnimation()
        // 改變按鈕顏色(更改透明度)
        moveColor(sender)
    }
    

}

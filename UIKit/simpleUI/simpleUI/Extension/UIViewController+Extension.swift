//
//  UIViewController+Extension.swift
//
//  Created on 2023/1/30.
//

import UIKit

extension UIViewController {
    
    func addChild(childController: UIViewController, to view: UIView) {
        self.addChild(childController)
        childController.view.frame = view.bounds
        view.addSubview(childController.view)
        childController.didMove(toParent: self)
    }
    //隱藏鍵盤方法
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

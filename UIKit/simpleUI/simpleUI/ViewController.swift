//
//  ViewController.swift
//  simpleUI
//
//  Created on 2023/5/30.
//

import UIKit

class ViewController: UIViewController {

    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    //MARK: @IBAction
    @IBAction func toSimpleGesture(_ sender: UIButton) {
        let vc = ShowGestureViewController(nibName: "ShowGestureViewController", bundle: Bundle(for: Self.self))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


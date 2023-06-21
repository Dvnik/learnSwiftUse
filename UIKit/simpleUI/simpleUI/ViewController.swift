//
//  ViewController.swift
//  simpleUI
//
//  Created on 2023/5/30.
//

import UIKit

class ViewController: UIViewController {
    //MARK: @IBOutlet
    @IBOutlet weak var viewMoveLine: UIView!
    

    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let moveLineVC = MoveSlideLineViewController(nibName: "MoveSlideLineViewController", bundle: Bundle(for: Self.self))
        self.addChild(childController: moveLineVC, to: viewMoveLine)
    }


    //MARK: @IBAction
    @IBAction func toSimpleGesture(_ sender: UIButton) {
        let vc = ShowGestureViewController(nibName: "ShowGestureViewController", bundle: Bundle(for: Self.self))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func toMoveText(_ sender: Any) {
        let vc = MoveTextWithGestureViewController(nibName: "MoveTextWithGestureViewController", bundle: Bundle(for: Self.self))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func toCalcuateTime(_ sender: Any) {
        let vc = ShowCalcuateTimeViewController(nibName: "ShowCalcuateTimeViewController", bundle: Bundle(for: Self.self))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


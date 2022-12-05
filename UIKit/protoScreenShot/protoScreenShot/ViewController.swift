//
//  ViewController.swift
//  protoScreenShot
//
//  Created by Trixie Lulamoon on 2022/8/25.
//
/// 這個功能從兩個地方查到，
/// 首先將截圖到的畫面存到相簿中
/// https://www.796t.com/post/MWhyMHU=.html
/// 存到相簿需要在info.plist新增NSPhotoLibraryUsageDescription權限。
///
/// 其次是做成ScreenShot動作的程式碼
/// https://stackoverflow.com/questions/25448879/how-do-i-take-a-full-screen-screenshot-in-swift
/// 因為覺得上一篇查到的方法在swift5上有新的寫法，所以就查到了。
///

import UIKit

class ViewController: UIViewController {
    //MARK: - Outlet
    @IBOutlet weak var actionInfo: UILabel!
    

    //MARK: - Live Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //MARK: - Actions
    @IBAction func screenShot(_ sender: UIButton) {
        if let screenImage = UIApplication.shared.makeSnapshot() {
            UIImageWriteToSavedPhotosAlbum(screenImage, nil, nil, nil)
            actionInfo.text = "Screen Shot Success!"
        }
        else {
            actionInfo.text = "Screen Shot Fail!"
        }
    }
    
}


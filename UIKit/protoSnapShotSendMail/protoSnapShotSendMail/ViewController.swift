//
//  ViewController.swift
//  protoSnapShotSendMail
//
//  Created by Trixie Lulamoon on 2022/8/25.
//
/// 結合螢幕截圖，將擷取的圖片用iCloud郵件寄出
/// 來源是自己購買的appcoda 教材：iOS 15 App程式設計進階攻略(Swift+UIKit)，第 6 章 如何在App中整合Email與附加檔案
/// 是運用MessageUI的功能直接打開e-Mail的ViewController直接寄信
/// 但是沒提到的點是預設的寄件者是由「iCloud郵件」做為預設值
/// 且無法直接用iOS的預設元件修改寄件者
/// 推測是跟寄件伺服器(SMTP)有關係
///

import UIKit
import MessageUI

class ViewController: UIViewController {

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    //MARK: - Actions
    @IBAction func SnapShot(_ sender: Any) {
        guard let screenImage = UIApplication.shared.makeSnapshot(), let mailController = getMailController() else { return }
        
        if let jpgData = screenImage.jpegData(compressionQuality: 0.9), let mimeType = MIMEType(type: "jpg") {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMdd"
            let nowStr = formatter.string(from: Date())
            // Add attachment
            mailController.addAttachmentData(jpgData, mimeType: mimeType.rawValue, fileName: "screenShot\(nowStr)")
            // Present mail view controller on screen
            present(mailController, animated: true, completion: nil)
        }
    }
    
    func getMailController() -> MFMailComposeViewController? {
        // Check if the device is capable to send email
        guard MFMailComposeViewController.canSendMail() else {
            print("This device doesn't allow you to send mail.")
            alert(iTitle: "Error", iMsg: "iColud mail not set.", iBtnTitle: "OK")
            return nil
        }
        // set default messages
        let emailTitle = "Device Screen Shot"
        let messageBody = "Hey, check this out!"
        let toRecipients = ["test@abcd.com"]
        
        // Initialize the mail composer and populate the mail content
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setSubject(emailTitle)
        mailComposer.setMessageBody(messageBody, isHTML: false)
        mailComposer.setToRecipients(toRecipients)
        
        return mailComposer
    }
    
}

extension ViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        var resultMsg = ""
        
        switch result {
        case MFMailComposeResult.cancelled:
            print("Mail cancelled")
            resultMsg = "Mail cancelled"
        case MFMailComposeResult.saved:
            print("Mail saved")
            resultMsg = "Mail saved"
        case MFMailComposeResult.sent:
            print("Mail sent")
            resultMsg = "Mail sent"
        case MFMailComposeResult.failed:
            print("Failed to send: \(error?.localizedDescription ?? "")")
            resultMsg = "Failed to send: \(error?.localizedDescription ?? "")"
        @unknown default:
            print("Unknown error: \(error.debugDescription)")
            resultMsg = "Unknown error: \(error.debugDescription)"
        }
        
        dismiss(animated: true, completion: nil)
        alert(iTitle: "Mail Result", iMsg: resultMsg, iBtnTitle: "OK")
    }
}

extension ViewController {
    func alert(iTitle:String, iMsg: String, iBtnTitle:String, iCompletion:(() -> Void)? = nil)
    {
        // 初始化訊息是裝準備使用的按鈕
        let btnOK = UIAlertAction(title: iBtnTitle, style: .default, handler: nil)
        alert(iTitle: iTitle, iMsg: iMsg, iActions: [btnOK], iCompletion: iCompletion)
    }
    
    func alert(iTitle:String, iMsg: String, iActions:[UIAlertAction]?, iCompletion:(() -> Void)? = nil)
    {
        // 訊息視窗：尚未有加進資料庫功能
        let alert = UIAlertController(title: iTitle, message: iMsg, preferredStyle: .alert)
        // 處理UIAlertAction...警告視窗的按鈕
        if let actions = iActions
        {
            actions.forEach { (act) in
                // 將按鈕加入訊息視窗
                alert.addAction(act)
            }
        }
        else {
            let btnOK = UIAlertAction(title: "OK", style: .default, handler: nil)
            // 將按鈕加入訊息視窗
            alert.addAction(btnOK)
        }
        // 顯示訊息視窗
        self.present(alert, animated: true, completion: iCompletion)
    }
}

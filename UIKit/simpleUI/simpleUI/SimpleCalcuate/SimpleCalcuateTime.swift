//
//  SimpleCalcuateTime.swift
//  simpleUI
//
//  Created on 2023/6/21.
//
//  簡易的碼表/倒數器
//

import Foundation

protocol SimpleCalcuateTimeDelegate {
    func onCount(_ object: SimpleCalcuateTime, formatTime: String)
    func onLimit(_ object: SimpleCalcuateTime)
}
extension SimpleCalcuateTimeDelegate {
    func onCount(_ object: SimpleCalcuateTime, formatTime: String) { }
    func onLimit(_ object: SimpleCalcuateTime) { }
}
 

class SimpleCalcuateTime: NSObject {
    //MARK: values
    var type: eClockType = .stopWatch
    var millSeconds = 0
    var limitStatus = false
    
    var delegate: SimpleCalcuateTimeDelegate?
    //MARK: private values
    private var timer = Timer()
    private var limitMillSeconds = 0
    // 設定上限
    func setLimit(millSecs: Int) {
        guard millSecs > 0 else { return }
        /**
         倒數是直接對millSeconds做減法，所以設在millSeconds
         碼表則是反過來，要用另外的limitMillSeconds去儲存上限值
         */
        switch type {
        case .countDown:
            millSeconds = millSecs
        case .stopWatch:
            limitMillSeconds = millSecs
        }
        
        limitStatus = true
    }
    // 設定上限
    func setLimit(hour: Int = 0, min: Int = 0, sec: Int = 0) {
        let totalTime = (hour * 360000) + (min * 6000) + (sec * 100)
        
        setLimit(millSecs: totalTime)
    }
    // 將millSeconds轉成碼表格式(預設)
    // 因millSeconds非private所以想要的話可以自己取用
    func getTimeStr() -> String {
        
        let runTime = millSeconds
        
        let calcuHour = runTime/360000
        let calcuMin =  runTime/6000
        let calcuSec = (runTime/100)%60
        let calcuMilSec = runTime%100
        
        if calcuMin > 59 {
            return String(format: "%02d:%02d:%02d.%02d", arguments: [calcuHour, calcuMin, calcuSec, calcuMilSec])
        }
        else {
            return String(format: "%02d:%02d:%02d", arguments: [calcuMin, calcuSec, calcuMilSec])
        }
    }
    // 開始計數
    func Start() {
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(0.01), target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .common)
    }
    // 停止計數
    func Stop() {
        timer.invalidate()
    }
    // 重設狀態
    func ResetAll() {
        millSeconds = 0
        limitStatus = false
    }
    // 檢查上限值狀態
    private func checkLimitCount() {
        guard limitStatus else { return }
        
        var toStop = false
        switch type {
        case .countDown:
            toStop = millSeconds <= 0
        case .stopWatch:
            toStop = millSeconds >= limitMillSeconds
        }
        
        if toStop {
            Stop()
            delegate?.onLimit(self)
        }
    }
    //MARK: @objc
    @objc func countDown() {
        switch type {
        case .countDown:
            millSeconds -= 1
        case .stopWatch:
            millSeconds += 1
        }
        
        checkLimitCount()
        delegate?.onCount(self, formatTime: getTimeStr())
    }
    
    
    //MARK: enum
    enum eClockType {
        case stopWatch// 碼表
        case countDown// 倒數
    }
}

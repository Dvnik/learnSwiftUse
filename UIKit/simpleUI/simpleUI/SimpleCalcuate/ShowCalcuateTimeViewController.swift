//
//  ShowCalcuateTimeViewController.swift
//  simpleUI
//
//  Created by 翊軒 on 2023/6/21.
//

import UIKit

class ShowCalcuateTimeViewController: UIViewController {
    //MARK:  @IBOutlet
    // StopWatch
    @IBOutlet weak var lblSWTime: UILabel!
    @IBOutlet weak var btnSWStart: UIButton!
    @IBOutlet weak var btnSWLap: UIButton!
    @IBOutlet weak var txvSWContent: UITextView!
    // CountDown
    @IBOutlet weak var lblCDTime: UILabel!
    @IBOutlet weak var btnCDStart: UIButton!
    @IBOutlet weak var btnCDLap: UIButton!
    @IBOutlet weak var tfCDHour: UITextField!
    @IBOutlet weak var tfCDMin: UITextField!
    @IBOutlet weak var tfCDSec: UITextField!
    @IBOutlet weak var btnCDLimit: UIButton!
    @IBOutlet weak var txvCDContent: UITextView!
    //MARK: values
    // SW
    let swTime = SimpleCalcuateTime()
    var statusStartSW = true
    var statusCanLapSW = false
    // CD
    let cdTime = SimpleCalcuateTime()
    var statusStartCD = true
    var statusCanLapCD = false
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        swInit()
        cdInit()
    }
    //MARK: functions
    func swInit() {
        swTime.delegate = self
        swTime.type = .stopWatch
        txvSWContent.text = ""
        lblSWTime.text = swTime.getTimeStr()
    }
    
    func cdInit() {
        cdTime.delegate = self
        cdTime.type = .countDown
        txvCDContent.text = ""
        lblCDTime.text = swTime.getTimeStr()
    }
    
    //MARK: @IBAction
    @IBAction func startStopWatch(_ sender: Any) {
        if statusStartSW {
            statusStartSW = false
            statusCanLapSW = true
            
            btnSWStart.setTitle("Stop" ,for: .normal)
            btnSWStart.setTitleColor(.red, for: .normal)
            
            btnSWLap.setTitle("Lap" ,for: .normal)
            btnSWLap.setTitleColor(.white, for: .normal)
            btnSWLap.isEnabled = true
            
            swTime.Start()
        }
        else {
            statusStartSW = true
            statusCanLapSW = false
            btnSWStart.setTitle("Start" ,for: .normal)
            btnSWStart.setTitleColor(.white, for: .normal)
            
            btnSWLap.setTitle("Reset" ,for: .normal)
            btnSWStart.setTitleColor(.green, for: .normal)
            
            swTime.Stop()
        }
    }
    
    
    @IBAction func lapStopWatch(_ sender: Any) {
        if statusCanLapSW {
            txvSWContent.text.append("\(swTime.getTimeStr())\n")
            // 捲動到最下方
            let range = NSRange(location: txvSWContent.text.count - 1, length: 1)
            txvSWContent.scrollRangeToVisible(range)
        }
        else {
            swTime.ResetAll()
            lblSWTime.text = swTime.getTimeStr()
        }
    }
    
    
    @IBAction func startCountDown(_ sender: Any) {
        if statusStartCD {
            
        }
        else {
            
        }
    }
    
    @IBAction func lapCountDown(_ sender: Any) {
        if statusCanLapCD {
            
        }
        else {
            
        }
    }
    
    
    @IBAction func limitCountDown(_ sender: Any) {
        
        
    }
}

extension ShowCalcuateTimeViewController: SimpleCalcuateTimeDelegate {
    func onCount(_ object: SimpleCalcuateTime, formatTime: String) {
        if object == cdTime {
            lblCDTime.text = formatTime
        }
        else if object == swTime {
            lblSWTime.text = formatTime
        }
    }
    
    func onLimit(_ object: SimpleCalcuateTime) {
        if object == cdTime {
            startCountDown(UIButton())
        }
    }
}

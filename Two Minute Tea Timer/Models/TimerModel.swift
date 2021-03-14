//
//  TimerModel.swift
//  Two Minute Tea Timer
//
//  Created by Nico Bertsch on 14.03.21.
//

import Foundation
import UIKit

class TimerModel: ObservableObject {
    var timer = Timer()
    
    @Published var minutes = 2
    @Published var tenSeconds = 0
    @Published var seconds = 0
    
    func startTimer() {
        minutes = 1
        tenSeconds = 5
        seconds = 9
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if(minutes == 0 && tenSeconds == 0 && seconds == 0) {
            timer.invalidate()
            minutes = 2
            tenSeconds = 0
            seconds = 0
        } else {
            seconds -= 1
            if(seconds < 0) {
                seconds = 9
                tenSeconds -= 1
                if(tenSeconds < 0) {
                    tenSeconds = 5
                    minutes -= 1
                }
            }
        }
        
    }
    
     func getTime() -> String {
        return "\(minutes):\(tenSeconds)\(seconds)"
    }
}

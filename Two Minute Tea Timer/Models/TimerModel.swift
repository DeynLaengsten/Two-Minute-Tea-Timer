//
//  TimerModel.swift
//  Two Minute Tea Timer
//
//  Created by Nico Bertsch on 14.03.21.
//

import Foundation
import UIKit
import AVFoundation

class TimerModel: ObservableObject {
    var timer = Timer()
    @Published var duration: Int
    let initTime: Int
    
    init(startTime: Int) {
        duration = startTime
        initTime = startTime
    }
    
    func startTimer() {
        timer.invalidate()
        duration = initTime - 1
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    func startTimer(with seconds: Int) {
        timer.invalidate()
        duration = seconds - 1
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
 
    @objc func updateTimer() {
        if(duration == 0) {
            timer.invalidate()
            duration = initTime

            let systemSoundID: SystemSoundID = 1005
            
            AudioServicesPlaySystemSound(systemSoundID)
            
        } else {
            duration -= 1
        }
        
    }
    
    func getTime() -> String {
        return String(format: "%02d:%02d", duration / 60, duration % 60)
    }
    
    func getPercentage() -> CGFloat {
        return (CGFloat(duration) / CGFloat(initTime)) * CGFloat(100.0)
    }
    
    func getTimerIsRunning() -> Bool {
        print(duration < initTime)
        return (duration < initTime ? true : false)
        
    }
}

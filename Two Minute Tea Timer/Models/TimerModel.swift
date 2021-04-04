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
    @Published var duration: Int = 0
    var startTime: Date
    let initDuration: Int
    var timePassed: TimeInterval = 0
    var runningAnimation: Bool = true
    
    init(startDuration: Int) {
        initDuration = startDuration
        startTime = Date()
    }
    
    func startTimer() {
        timer.invalidate()
        startTime = Date()
        duration = initDuration
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
 
    @objc func updateTimer() {
        let aktDate = Date()
        timePassed = aktDate.timeIntervalSince(startTime)
        let secondsPassed = Int(timePassed)

        if(secondsPassed > initDuration) {
            timer.invalidate()
            duration = initDuration
        } else if(secondsPassed == initDuration) {
            duration = 0
            let systemSoundID: SystemSoundID = 1005
            AudioServicesPlaySystemSound(systemSoundID)
        } else {
            duration = initDuration - secondsPassed
        }
        
    }
    
    func getTime() -> String {
        return String(format: "%02d:%02d", duration / 60, duration % 60)
//        return
    }
    
    func round(input: Double) -> Int {
        let temp = input * 1000.0
        let out = Int(temp) / 1000
        return out
    }
    
    func getPercentage() -> CGFloat {
        return (CGFloat(duration) / CGFloat(initDuration)) * CGFloat(100.0)
    }
    
    func getTimerIsRunning() -> Bool {

        
        if timer.isValid {
            runningAnimation.toggle()
        }
//        return (duration < initDuration ? true : false)
        print(runningAnimation)

        return runningAnimation
    }
}

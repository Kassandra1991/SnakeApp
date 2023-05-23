//
//  TimerModel.swift
//  SnakeApp
//
//  Created by Aleksandra Asichka on 2023-05-23.
//

import Foundation

protocol TimerProtocol: AnyObject {
    func timerAction()
}

class TimerModel {
    
    weak var delegate: TimerProtocol?
    
    private var timer = Timer()
    
    private var timerInterval = 0.7
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: timerInterval, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc private func timerAction() {
        delegate?.timerAction()
    }
    
    func stopTimer() {
        timer.invalidate()
    }
}

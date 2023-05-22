//
//  ViewController.swift
//  SnakeApp
//
//  Created by Aleksandra Asichka on 2023-03-12.
//

import UIKit

class MainViewController: UIViewController {

    private var mainView: MainView {
        view as! MainView
    }
    
    private var gameModel = GameModel()
    private let snakeModel = SnakeModel()
    private let addPointModel = AddPointModel()
    private let controlModel = ControlModel()
    
    private var timer = Timer()
 
    // MARK: - LifeCycle
    
    override func loadView() {
        view = MainView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameModel = GameModel(snake: snakeModel, addPoint: addPointModel)
        setDelegates()
        startTimer()
    }

    private func setDelegates() {
        mainView.joystikView.delegate = self
        mainView.boardView.delegate = self
    }
    
    // MARK: - MovingSnake
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    // MARK: - TimerAction
    
    @objc private func timerAction() {
        gameModel.checkEating()
        snakeModel.checkDirection(controlModel.direction)
        snakeModel.moveSnake()
        if !gameModel.snakeIsOnBoard() || !gameModel.crushTest() {
            timer.invalidate()
        }
        updateUI()
    }
    
    private func updateUI() {
        mainView.boardView.snake = snakeModel.snake
        mainView.boardView.addPoint = CGPoint(x: addPointModel.coordinate.col, y: addPointModel.coordinate.row)
        mainView.boardView.setNeedsDisplay()
    }
}

// MARK: - JoustikProtocol

extension MainViewController: JoustikProtocol {
    func changePointLocation(_ point: CGPoint) {
        controlModel.changeDirection(point)
    }
}

// MARK: - BoardProtocol

extension MainViewController: BoardProtocol {
    func swipeGesture(direction: UISwipeGestureRecognizer.Direction) {
        switch direction {
        case .down:
            controlModel.direction = .down
        case .right:
            controlModel.direction = .right
        case .left:
            controlModel.direction = .left
        case .up:
            controlModel.direction = .up
        default:
            break
        }
    }
}

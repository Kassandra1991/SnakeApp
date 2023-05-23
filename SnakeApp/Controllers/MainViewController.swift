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
    
    private let timer = TimerModel()
 
    // MARK: - LifeCycle
    
    override func loadView() {
        view = MainView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameModel = GameModel(snake: snakeModel, addPoint: addPointModel)
        setDelegates()
        timer.startTimer()
    }

    private func setDelegates() {
        mainView.joystikView.delegate = self
        mainView.boardView.delegate = self
        timer.delegate = self
        
    }

    private func updateUI() {
        mainView.boardView.snake = snakeModel.snake
        mainView.boardView.addPoint = CGPoint(x: addPointModel.coordinate.col,
                                              y: addPointModel.coordinate.row)
        mainView.scoreLabel.text = gameModel.gameScore.score
        mainView.nextLevelLabel.text = gameModel.gameScore.level
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

// MARK: - TimerProtocol

extension MainViewController: TimerProtocol {
    func timerAction() {
        snakeModel.checkDirection(controlModel.direction)
        snakeModel.moveSnake()
        if gameModel.checkNextLevel() {
            timer.speedIncrease()
        }
        if !gameModel.snakeIsOnBoard() || !gameModel.crushTest() {
            timer.stopTimer()
        }
        updateUI()
    }
}

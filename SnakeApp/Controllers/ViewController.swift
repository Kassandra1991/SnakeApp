//
//  ViewController.swift
//  SnakeApp
//
//  Created by Aleksandra Asichka on 2023-03-12.
//

import UIKit

class ViewController: UIViewController {

    private let boardView = BoardView()
    private var gameModel = GameModel()
    private let joystikView = JoystikView()
    private let snakeModel = SnakeModel()
    private let addPointModel = AddPointModel()
    private let controlModel = ControlModel()
    private var timer = Timer()
    //private var direction: MovingDirection = .left
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        addSwipe()
        startTimer()
    }

    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(boardView)
        view.addSubview(joystikView)
        gameModel = GameModel(snake: snakeModel, addPoint: addPointModel)
        joystikView.delegate = self
    }
    
    // MARK: - UISwipeGestureRecognizer
    
    private func addSwipe() {
        
        let directions: [UISwipeGestureRecognizer.Direction] = [.left, .up, .right, .down]
        directions.forEach {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender: )))
            swipe.direction = $0
            boardView.addGestureRecognizer(swipe)
        }
    }
    
    @objc private func handleSwipe(sender: UISwipeGestureRecognizer) {
        switch sender.direction {
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
    
    // MARK: - MovingSnake
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
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
        boardView.snake = snakeModel.snake
        boardView.addPoint = CGPoint(x: addPointModel.coordinate.col, y: addPointModel.coordinate.row)
        boardView.setNeedsDisplay()
    }
    
}

// MARK: - JoustikProtocol

extension ViewController: JoustikProtocol {
    func changePointLocation(_ point: CGPoint) {
        guard let direction = controlModel.changeDirection(point) else {return}
        snakeModel.checkDirection(direction)
    }
}


// MARK: - Constraints

extension ViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            boardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            boardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            boardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            boardView.heightAnchor.constraint(equalTo: boardView.widthAnchor, multiplier: 1.0),
            
            joystikView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200.0),
            joystikView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            joystikView.heightAnchor.constraint(equalToConstant: 100.0),
            joystikView.widthAnchor.constraint(equalToConstant: 100.0)
        ])
    }
}

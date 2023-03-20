//
//  ViewController.swift
//  SnakeApp
//
//  Created by Aleksandra Asichka on 2023-03-12.
//

import UIKit

class ViewController: UIViewController {

    private let boardView = BoardView()
    private let gameModel = GameModel()
    private var movingDirection: MovingDirection = .left
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        addSwipe()
        movingSnake()
    }

    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(boardView)
    }
    
    // MARK: - UISwipeGestureRecognizer
    
    private func addSwipe() {
        
        let directions: [UISwipeGestureRecognizer.Direction] = [.left, .up, .right, .down]
        directions.forEach {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender: )))
            swipe.direction = $0
            view.addGestureRecognizer(swipe)
        }
    }
    
    @objc private func handleSwipe(sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .left:
            movingDirection = .left
        case .right:
            movingDirection = .right
        case .up:
            movingDirection = .up
        case .down:
            movingDirection = .down
        default:
            break
        }
    }
    
    // MARK: - MovingSnake
    
    private func movingSnake() {
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { [weak self] _ in
            guard let self = self else {
                return
            }
            
            switch self.movingDirection {
                
            case .left:
                self.gameModel.moveLeft()
            case .right:
                self.gameModel.moveRight()
            case .up:
                self.gameModel.moveUp()
            case .down:
                self.gameModel.moveDown()
            }
            self.updateUI()
        }
    }
    
    private func updateUI() {
        boardView.snake = gameModel.getSnake()
        boardView.addPointRow = gameModel.getAddPoint().row
        boardView.addPointCol = gameModel.getAddPoint().col
        boardView.setNeedsDisplay()
    }
    
}

// MARK: - Constraints

extension ViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            boardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            boardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            boardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            boardView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}

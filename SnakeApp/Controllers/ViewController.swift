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
    }

    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(boardView)
    }
    
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
            print("влево")
        case .right:
            movingDirection = .right
            print("вправо")
        case .up:
            movingDirection = .up
            print("вверх")
        case .down:
            movingDirection = .down
            print("вниз")
        default:
            break
        }
    }
}

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

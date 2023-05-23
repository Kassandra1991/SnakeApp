//
//  MainView.swift
//  SnakeApp
//
//  Created by Aleksandra Asichka on 2023-05-22.
//

import UIKit

class MainView: UIView {
    
    let boardView = BoardView()
    let joystikView = JoystikView()
    let scoreLabel = UILabel()
    let nextLevelLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        configureBoardView()
        configureJoystikView()
        configureScoreLabel()
        configureNextLevelLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureBoardView() {
        addSubview(boardView)
        NSLayoutConstraint.activate([
            boardView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            boardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            boardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            boardView.heightAnchor.constraint(equalTo: boardView.widthAnchor, multiplier: 1.0)
        ])
    }
    
    private func configureJoystikView() {
        addSubview(joystikView)
        NSLayoutConstraint.activate([
            joystikView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -200.0),
            joystikView.centerXAnchor.constraint(equalTo: centerXAnchor),
            joystikView.heightAnchor.constraint(equalToConstant: 100.0),
            joystikView.widthAnchor.constraint(equalToConstant: 100.0)
        ])
    }
    private func configureScoreLabel() {
        addSubview(scoreLabel)
        scoreLabel.text = "Score: 10"
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: boardView.bottomAnchor, constant: 10.0),
            scoreLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0)
        ])
    }
    private func configureNextLevelLabel() {
        addSubview(nextLevelLabel)
        nextLevelLabel.text = "Level: 3"
        nextLevelLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextLevelLabel.topAnchor.constraint(equalTo: boardView.bottomAnchor, constant: 10.0),
            nextLevelLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0)
        ])
    }
}

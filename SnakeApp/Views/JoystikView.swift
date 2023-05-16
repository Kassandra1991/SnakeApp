//
//  JoystikView.swift
//  SnakeApp
//
//  Created by Aleksandra Asichka on 2023-05-16.
//

import UIKit

class JoystikView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = SnakeColor.snakeHead
        layer.cornerRadius = 50.0
        translatesAutoresizingMaskIntoConstraints = false
    }
}

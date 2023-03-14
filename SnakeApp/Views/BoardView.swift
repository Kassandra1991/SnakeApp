//
//  BoardView.swift
//  SnakeApp
//
//  Created by Aleksandra Asichka on 2023-03-14.
//

import UIKit

class BoardView: UIView {
    
    private let originX: CGFloat = 0.0
    private let originY: CGFloat = 0.0
    private var cellSide: CGFloat = 0.0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cellSide = frame.width / 20
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
        backgroundColor = .darkGray
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

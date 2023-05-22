//
//  BoardView.swift
//  SnakeApp
//
//  Created by Aleksandra Asichka on 2023-03-14.
//

import UIKit

protocol BoardProtocol: AnyObject {
    func swipeGesture(direction: UISwipeGestureRecognizer.Direction)
}

class BoardView: UIView {
    
    weak var delegate: BoardProtocol?
    
    private let originX: CGFloat = 0.0
    private let originY: CGFloat = 0.0
    private var cellSide: CGFloat = 0.0
    
    var snake: [SnakeCell]?
    var addPoint: CGPoint?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cellSide = frame.width / CGFloat(GameModel.cols)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        drawGrid()
        drawAddPoint()
        drawSnake()
        addSwipe()
    }
    
    // MARK: - UISwipeGestureRecognizer
    
    private func addSwipe() {
        
        let directions: [UISwipeGestureRecognizer.Direction] = [.left, .up, .right, .down]
        directions.forEach {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender: )))
            swipe.direction = $0
            addGestureRecognizer(swipe)
        }
    }
    
    @objc private func handleSwipe(sender: UISwipeGestureRecognizer) {
        delegate?.swipeGesture(direction: sender.direction)
    }
    
    // MARK: - drawGrid
    
    private func drawGrid() {
        let gridPath = UIBezierPath()
        
        for i in 0...GameModel.rows {
            gridPath.move(to: CGPoint(x: originX,
                                      y: originY + CGFloat(i) * cellSide))
            gridPath.addLine(to: CGPoint(x: originX + cellSide * CGFloat(GameModel.cols), y: originY + CGFloat(i) * cellSide))
        }
        
        for i in 0...GameModel.cols {
            gridPath.move(to: CGPoint(x: originX + CGFloat(i) * cellSide,
                                      y: originY ))
            gridPath.addLine(to: CGPoint(x: originX + CGFloat(i) * cellSide, y: originY + cellSide * CGFloat(GameModel.rows)))
        }
        SnakeColor.grid.setStroke()
        gridPath.stroke()
    }
    
    private func drawSnake() {
        guard let snake, !snake.isEmpty, let snakeHead = snake.first else {
            return
        }
        SnakeColor.snakeHead.setFill()
        UIBezierPath(roundedRect: CGRect(x: originX + cellSide * CGFloat(snakeHead.col), y: originY + cellSide * CGFloat(snakeHead.row), width: cellSide, height: cellSide), cornerRadius: 3).fill()
        
        SnakeColor.snakeBody.setFill()
        for i in 1..<snake.count {
            let cell = snake[i]
            
            UIBezierPath(roundedRect: CGRect(x: originX + cellSide * CGFloat(cell.col), y: originY + cellSide * CGFloat(cell.row), width: cellSide, height: cellSide), cornerRadius: 3).fill()
        }
    }
    
    private func drawAddPoint() {
        guard let addPoint else { return }
        SnakeColor.addPoint.setFill()
        UIBezierPath(roundedRect: CGRect(x: originX + cellSide * addPoint.x, y: originY + cellSide * addPoint.y, width: cellSide, height: cellSide), cornerRadius: 3).fill()
    }
}

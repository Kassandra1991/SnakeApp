//
//  SnakeModel.swift
//  SnakeApp
//
//  Created by Aleksandra Asichka on 2023-03-21.
//

import Foundation

class SnakeModel {
    
    private var snakeArray: [SnakeCell]
    
    var movingDirection: MovingDirection = .left
    
    var snake: [SnakeCell] {
        return snakeArray
    }
    
    init() {
        snakeArray = [SnakeCell(col: GameModel.cols-2, row: 1),
                      SnakeCell(col: GameModel.cols-1, row: 1),
                      SnakeCell(col: GameModel.cols, row: 1)
        ]
    }
    
    private func updateSnake(newHead: SnakeCell) {
        var newSnake: [SnakeCell] = []
        newSnake.append(newHead)
        for i in 0..<snakeArray.count - 1 {
            newSnake.append(snakeArray[i])
        }
        snakeArray = newSnake
    }
    
    // MARK: - Update moving snake
    
    func moveSnake() {
        switch movingDirection {
        case .left:
            updateSnake(newHead: SnakeCell(col: snakeArray[0].col - 1, row: snakeArray[0].row))
        case .right:
            updateSnake(newHead: SnakeCell(col: snakeArray[0].col + 1, row: snakeArray[0].row))
        case .up:
            updateSnake(newHead: SnakeCell(col: snakeArray[0].col, row: snakeArray[0].row - 1))
        case .down:
            updateSnake(newHead: SnakeCell(col: snakeArray[0].col, row: snakeArray[0].row + 1))
        }
    }
    
    func snakeEatAddPoint() {
        let oldTail = snakeArray[snakeArray.count - 1]
        snakeArray.append(oldTail)
    }
}

//
//  SnakeBoard.swift
//  SnakeApp
//
//  Created by Aleksandra Asichka on 2023-03-14.
//

import Foundation

class GameModel {
    static let cols = 10
    static let rows = 20
    
    private var addPointCol = 1
    private var addPointRow = 4
    
    var snake: [SnakeCell] = []
    
    init() {
        snake.append(SnakeCell(col: GameModel.cols-1, row: 1))
        snake.append(SnakeCell(col: GameModel.cols, row: 1))
    }
    
    private func isOnSnake(col: Int, row: Int) -> Bool {
        for cell in snake {
            if cell.col == col && cell.row == row {
                return true
            }
        }
        return false
    }
// MARK: - Randomize snake and Add Point
    private func randomizeAddPoint() {
        addPointCol = Int.random(in: 1..<GameModel.cols)
        addPointRow = Int.random(in: 1..<GameModel.rows)
        
        while isOnSnake(col: addPointCol, row: addPointRow) {
            addPointCol = Int.random(in: 1..<GameModel.cols)
            addPointRow = Int.random(in: 1..<GameModel.rows)
        }
    }
    
    func updateSnakeAndAddPoint(newHead: SnakeCell) {
        var newSnake: [SnakeCell] = []
        newSnake.append(newHead)
        for i in 0..<snake.count - 1 {
            newSnake.append(snake[i])
        }
        let oldTail = snake[snake.count-1]
        if snake[0].col == addPointCol && snake[0].row == addPointRow {
            newSnake.append(oldTail)
            randomizeAddPoint()
        }
        snake = newSnake
    }
    
    // MARK: - Update moving snake
    
    func moveLeft() {
        updateSnakeAndAddPoint(newHead: SnakeCell(col: snake[0].col - 1, row: snake[0].row))
    }
    
    func moveRight() {
        updateSnakeAndAddPoint(newHead: SnakeCell(col: snake[0].col + 1, row: snake[0].row))
    }
    
    func moveUp() {
        updateSnakeAndAddPoint(newHead: SnakeCell(col: snake[0].col, row: snake[0].row + 1))
    }
    
    func moveDown() {
        updateSnakeAndAddPoint(newHead: SnakeCell(col: snake[0].col, row: snake[0].row - 1))
    }
}

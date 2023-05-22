//
//  ControlModel.swift
//  SnakeApp
//
//  Created by Aleksandra Asichka on 2023-05-18.
//

import UIKit

class ControlModel {
    
    private let triangleDown =
    [CGPoint(x: -50.0, y: -50.0),CGPoint(x: 0.0, y: 0.0), CGPoint(x: 50.0, y: -50.0)]
    private let triangleLeft =
    [CGPoint(x: -50.0, y: 50.0), CGPoint(x: 0.0, y: 0.0), CGPoint(x: -50.0, y: -50.0)]
    private let triangleRight =
    [CGPoint(x: 50.0, y: 50.0), CGPoint(x: 0.0, y: 0.0), CGPoint(x: 50.0, y: -50.0)]
    private let triangleUp =
    [CGPoint(x: -50.0, y: 50.0), CGPoint(x: 0.0, y: 0.0), CGPoint(x: 50.0, y: 50.0)]
    
    var direction: MovingDirection = .left
    
    private func defineDirection(point: CGPoint) -> MovingDirection {
        if isPointInsideTriangle(point, triangleDown) {
            return .down
        }
        if isPointInsideTriangle(point, triangleUp) {
            return .up
        }
        if isPointInsideTriangle(point, triangleLeft) {
            return .left
        }
        if isPointInsideTriangle(point, triangleRight) {
            return .right
        }
        return direction
    }
    
    private func isPointInsideTriangle(_ point: CGPoint, _ triangle: [CGPoint]) -> Bool {
        let x1 = triangle[0].x
        let y1 = triangle[0].y
        let x2 = triangle[1].x
        let y2 = triangle[1].y
        let x3 = triangle[2].x
        let y3 = triangle[2].y
        let x = point.x
        let y = point.y
        
        let areaTriangle = abs((x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2)) / 2)
        let areaTringleFirst = abs((x1 * (y2 - y) + x2 * (y - y1) + x * (y1 - y2)) / 2)
        let areaTringleSecond = abs((x * (y2 - y3) + x2 * (y3 - y) + x3 * (y - y2)) / 2)
        let areaTringleThird = abs((x1 * (y - y3) + x * (y3 - y1) + x3 * (y1 - y)) / 2)
        return areaTriangle == areaTringleFirst + areaTringleSecond + areaTringleThird
    }
    
    func changeDirection(_ point: CGPoint) {
        let directionJoystik = defineDirection(point: point)
        
        if directionJoystik != direction {
            direction = directionJoystik
        }
    }
}



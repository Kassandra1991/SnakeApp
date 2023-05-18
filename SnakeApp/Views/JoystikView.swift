//
//  JoystikView.swift
//  SnakeApp
//
//  Created by Aleksandra Asichka on 2023-05-16.
//

import UIKit

class JoystikView: UIView {
    private var centerView = UIView()
    
    private let triangleDown = [(x: -50.0, y: -50.0),(x: 0.0, y: 0.0), (x: 50.0, y: -50.0)]
    private let triangleLeft = [(x: -50.0, y: 50.0),(x: 0.0, y: 0.0), (x: -50.0, y: -50.0)]
    private let triangleRight = [(x: 50.0, y: 50.0),(x: 0.0, y: 0.0), (x: 50.0, y: -50.0)]
    private let triangleUp = [(x: -50.0, y: 50.0),(x: 0.0, y: 0.0), (x: 50.0, y: 50.0)]
    
    private var direction: MovingDirection = .left
    
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
        
        centerView.layer.cornerRadius = 50
        centerView.backgroundColor = .black
        centerView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        addSubview(centerView)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            if bounds.contains(location) {
                centerView.center = location
            }
            
            let point = (x: Double(location.x - 50), y: Double(50 - location.y))
            let directionJoystik = defineDirection(point: point)
            
            if directionJoystik != direction {
                direction = directionJoystik
                print(direction)
            }
        }
    }
    
    private func defineDirection(point: (x: Double, y: Double)) -> MovingDirection {
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
    
    private func isPointInsideTriangle(_ point: (x: Double, y: Double), _ triangle: [(x: Double, y: Double)]) -> Bool {
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
}
//
//  JoystikView.swift
//  SnakeApp
//
//  Created by Aleksandra Asichka on 2023-05-16.
//

import UIKit

protocol JoustikProtocol: AnyObject {
    func changePointLocation(_ point: CGPoint)
}

class JoystikView: UIView {
    
    weak var delegate: JoustikProtocol?
    
    private var centerView = UIView()

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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            if bounds.contains(location) {
                centerView.center = location
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            if bounds.contains(location) {
                centerView.center = location
            }
            
            let point = CGPoint(x: location.x - 50, y: 50 - location.y)
            delegate?.changePointLocation(point)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        centerView.frame.origin = CGPoint(x: 0, y: 0)
    }
}

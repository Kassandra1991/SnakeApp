//
//  ControlModel.swift
//  SnakeApp
//
//  Created by Aleksandra Asichka on 2023-05-18.
//

import UIKit

class ControlModel {
    private let triangleDown = [(x: -50.0, y: -50.0),(x: 0.0, y: 0.0), (x: 50.0, y: -50.0)]
    private let triangleLeft = [(x: -50.0, y: 50.0),(x: 0.0, y: 0.0), (x: -50.0, y: -50.0)]
    private let triangleRight = [(x: 50.0, y: 50.0),(x: 0.0, y: 0.0), (x: 50.0, y: -50.0)]
    private let triangleUp = [(x: -50.0, y: 50.0),(x: 0.0, y: 0.0), (x: 50.0, y: 50.0)]
}

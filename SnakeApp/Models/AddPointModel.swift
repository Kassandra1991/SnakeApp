//
//  AddPointModel.swift
//  SnakeApp
//
//  Created by Aleksandra Asichka on 2023-03-21.
//

import Foundation

class AddPointModel {
    private var addPointCol = 1
    private var addPointRow = 4
    
    var coordinate: (col: Int, row: Int) {
        (addPointCol, addPointRow)
    }
    
    func randomizeAddPoint() {
        addPointCol = Int.random(in: 1..<GameModel.cols)
        addPointRow = Int.random(in: 1..<GameModel.rows)
    }
}

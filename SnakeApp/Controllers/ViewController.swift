//
//  ViewController.swift
//  SnakeApp
//
//  Created by Aleksandra Asichka on 2023-03-12.
//

import UIKit

class ViewController: UIViewController {

    private let boardView = BoardView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        view.backgroundColor = .red
        view.addSubview(boardView)
    }
}


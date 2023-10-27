//
//  ViewController.swift
//  Hackaton_bmstu2023
//
//  Created by Grigoriy on 26.10.2023.
//

import UIKit
import PinLayout

class MainViewController: CustomViewController {
    
}

//MARK: - Life cicle
extension MainViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
}

//MARK: - private methods
private extension MainViewController {
    func setup() {
        view.backgroundColor = .Background.customBackground
    }
}



//
//  CicleView.swift
//  Hackaton_bmstu2023
//
//  Created by Grigoriy on 27.10.2023.
//

import UIKit
import PinLayout

final class CicleView: UIView {
    
    private let backgroundView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        addSubview(backgroundView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundView.pin
            .all()
    }
    
    private func setup() {
        backgroundView.backgroundColor = .CirlceView.customBlueGray
        backgroundView.layer.cornerRadius = 200
    }
}

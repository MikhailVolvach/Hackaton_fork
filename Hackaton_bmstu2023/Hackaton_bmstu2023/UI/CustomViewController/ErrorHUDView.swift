//
//  ErrorHUDView.swift
//  Hackaton_bmstu2023
//
//  Created by Grigoriy on 27.10.2023.
//
import UIKit
import PinLayout

final class ErrorHUDView: UIView {
    private let cointeinerView = UIView()
    private let errorHUDLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func configure(with errorText: String) {
        errorHUDLabel.text = errorText
    }
    
    private func setupUI() {
        errorHUDLabel.textColor = .systemGray5
        errorHUDLabel.textAlignment = .center
        errorHUDLabel.numberOfLines = 0 // Устанавливаем количество строк как 0, чтобы текст переносился на несколько строк при необходимости
        
        cointeinerView.backgroundColor = .systemGray
        cointeinerView.layer.cornerRadius = 8
        cointeinerView.layer.masksToBounds = true
        
        addSubview(cointeinerView)
        cointeinerView.addSubview(errorHUDLabel)
        
        setupConstraints()
    }
    

    private func setupConstraints() {
        cointeinerView.translatesAutoresizingMaskIntoConstraints = false
        errorHUDLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cointeinerView.topAnchor.constraint(equalTo: topAnchor),
            cointeinerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cointeinerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            errorHUDLabel.topAnchor.constraint(equalTo: cointeinerView.topAnchor, constant: 15),
            errorHUDLabel.leadingAnchor.constraint(equalTo: cointeinerView.leadingAnchor, constant: 15),
            errorHUDLabel.trailingAnchor.constraint(equalTo: cointeinerView.trailingAnchor, constant: -15),
            errorHUDLabel.bottomAnchor.constraint(equalTo: cointeinerView.bottomAnchor, constant: -15)
        ])
    }
    
    override var intrinsicContentSize: CGSize {
        let labelSize = errorHUDLabel.sizeThatFits(CGSize(width: bounds.width - 30, height: .greatestFiniteMagnitude))
        return CGSize(width: bounds.width, height: labelSize.height + 30)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

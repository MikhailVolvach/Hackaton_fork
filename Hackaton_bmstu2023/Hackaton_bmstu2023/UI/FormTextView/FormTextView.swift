//
//  FormTextView.swift
//  Hackaton_bmstu2023
//
//  Created by Grigoriy on 27.10.2023.
//
import UIKit
import PinLayout

final class FormTextView: UIView {
    
    let backgroundView = UIView()
    let enterimageView = UIImageView()
    let enterTextField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        backgroundView.addSubviews(enterimageView, enterTextField)
        addSubviews(backgroundView)
        
    }
    
    @objc private func dismissKeyboard() {
        enterTextField.resignFirstResponder()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundView.pin
            .all()
        
        enterimageView.pin
            .left(15)
            .top(8)
            .size(CGSize(width: 20, height: 20))
        
        enterTextField.pin
            .right(of: enterimageView)
            .marginLeft(8)
            .right()
            .top()
            .bottom()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .СontainerView.customBackground
        enterimageView.contentMode = .scaleAspectFit
        enterimageView.clipsToBounds = true
        backgroundView.layer.cornerRadius = 20
        backgroundView.layer.borderWidth = 1.0
        backgroundView.layer.borderColor = UIColor.Font.customSecondGrayWhite.cgColor
    }
    
    func configFormTextView(with image: UIImage, title: String) {
        enterimageView.image = image
        enterTextField.placeholder = title
        
        if title == "Пароль" || title == "Подтвердите пароль" {
            enterTextField.textContentType = .password
            enterTextField.isSecureTextEntry = true
        }
    }
}


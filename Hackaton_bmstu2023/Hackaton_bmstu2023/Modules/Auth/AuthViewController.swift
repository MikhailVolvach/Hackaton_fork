//
//  AuthViewController.swift
//  Hackaton_bmstu2023
//
//  Created by Grigoriy on 27.10.2023.
//

import UIKit

final class AuthViewController: CustomViewController {
    
    private let topCicrleView = CicleView()
    private var bottomCicrleView = CicleView(frame: CGRect(x: -81, y: 347, width: 348, height: 348))
    private let registrationView = UIView()
    private let registrationLabel = UILabel()
    private let helloLabel = UILabel()
    
    private let userNameFormTextView = FormTextView()
    private let passwordFormTextView = FormTextView()
    private let registerButton = UIButton()
    private let adviceLabel = UILabel()
    private let         enterButton = UIButton()
}


//MARK: - life circle
extension AuthViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        registrationView.addSubviews(userNameFormTextView, passwordFormTextView,         enterButton, adviceLabel, registerButton)
        
        view.addSubviews(topCicrleView, bottomCicrleView, registrationView, helloLabel, registrationLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        topCicrleView.pin
            .top(-100)
            .right(50)
            .size(CGSize(width: 400, height: 400))
        
        registrationLabel.pin
            .top(100)
            .horizontally(62)
            .height(36)
        
        registrationView.pin
            .vCenter()
            .horizontally(32)
            .height(350)
        
        bottomCicrleView.pin
            .bottom(-60)
            .left(45)
            .size(CGSize(width: 400, height: 400))
        
        helloLabel.pin
            .bottom(30)
            .horizontally(103)
            .height(16)
        
        userNameFormTextView.pin
            .top(26)
            .horizontally(6)
            .height(36)
        
        passwordFormTextView.pin
            .below(of: userNameFormTextView)
            .marginTop(8)
            .horizontally(6)
            .height(36)
        
        enterButton.pin
            .below(of: passwordFormTextView)
            .marginTop(8)
            .horizontally(6)
            .height(36)
        
        adviceLabel.pin
            .below(of:         enterButton)
            .marginTop(8)
            .left(40)
            .width(110)
            .sizeToFit(.width)
        
        registerButton.pin
            .below(of:         enterButton)
            .marginTop(8)
            .right(40)
            .size(CGSize(width: 150, height: 15))
    }
}

//MARK: - private methods
private extension AuthViewController {
    func setup() {
        registrationView.backgroundColor = .СontainerView.customBackground
        registrationView.layer.cornerRadius = 40
        
        [registrationLabel,helloLabel].forEach {
            $0.textAlignment = .center
            $0.textColor = .Font.customMainWhite
        }
        
        registrationLabel.text = "Вход"
        helloLabel.text = "Добро пожаловать!"
        adviceLabel.text = "Нет аккаунта?"
        adviceLabel.textColor = .Font.customSecondGrayWhite
        
        
        enterButton.backgroundColor = .Button.customBlue
        enterButton.setTitle("Войти", for: .normal)
        enterButton.setTitleColor(.Font.customMainWhite, for: .normal)
        enterButton.layer.cornerRadius = 20
        
        userNameFormTextView.configFormTextView(with: UIImage(named: "person")!, title: "Имя пользователя")
        passwordFormTextView.configFormTextView(with: UIImage(named: "key")!, title: "Пароль")
        
        registerButton.setTitle("зарегистрироваться", for: .normal)
        registerButton.setTitleColor(.Button.customBlue, for: .normal)
        registerButton.titleLabel?.textAlignment = .center
        
        //dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        enterButton.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    @objc private func enterButtonTapped() {
        let username = userNameFormTextView.enterTextField.text
        let password = passwordFormTextView.enterTextField.text
        
        if password != "" && username != "" {
            navigationController?.pushViewController(TabBarController(), animated: true)
        } else {
            print("введите логин и пароль")
        }
    }
    
    @objc private func registerButtonTapped() {
        navigationController?.pushViewController(RegistationViewController(), animated: true)
    }
}

extension AuthViewController {
    struct Consts {
        static let cirleWidth: Double = 348
    }
}

extension AuthViewController: UITextFieldDelegate {
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

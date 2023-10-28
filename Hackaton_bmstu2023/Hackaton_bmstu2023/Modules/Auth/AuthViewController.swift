//
//  AuthViewController.swift
//  Hackaton_bmstu2023
//
//  Created by Grigoriy on 27.10.2023.
//

import UIKit

final class AuthViewController: CustomViewController {
    
    private let topCicrleView = CicleView()
    private var bottomCicrleView = CicleView()
    private let conteinerView = UIView()
    private let enterLabel = UILabel()
    private let helloLabel = UILabel()
    private let userNameFormTextView = FormTextView()
    private let passwordFormTextView = FormTextView()
    private let registerButton = UIButton()
    private let adviceLabel = UILabel()
    private let enterButton = UIButton()
}


//MARK: - life circle
extension AuthViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        conteinerView.addSubviews(userNameFormTextView, passwordFormTextView, enterButton, adviceLabel, registerButton)
        
        view.addSubviews(topCicrleView, bottomCicrleView, conteinerView, helloLabel, enterLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        topCicrleView.pin
            .top(-100)
            .right(50)
            .size(CGSize(width: 400, height: 400))

        conteinerView.pin
            .vCenter()
            .horizontally(32)
            .height(250)
        
        enterLabel.pin
            .above(of: conteinerView)
            .marginBottom(30)
            .horizontally(62)
            .height(36)
        
        bottomCicrleView.pin
            .bottom(-60)
            .left(45)
            .size(CGSize(width: 400, height: 400))
        
        helloLabel.pin
            .bottom(30)
            .horizontally(103)
            .height(16)
        
        userNameFormTextView.pin
            .top(36)
            .horizontally(6)
            .height(45)
        
        passwordFormTextView.pin
            .below(of: userNameFormTextView)
            .marginTop(12)
            .horizontally(6)
            .height(45)
        
        enterButton.pin
            .below(of: passwordFormTextView)
            .marginTop(12)
            .horizontally(6)
            .height(45)
        
        adviceLabel.pin
            .below(of: enterButton)
            .marginTop(12)
            .left(20)
            .width(110)
            .sizeToFit(.width)
        
        registerButton.pin
            .below(of: enterButton)
            .marginTop(12)
            .right(45)
            .size(CGSize(width: 150, height: 17))
    }
}

//MARK: - private methods
private extension AuthViewController {
    func setup() {
        conteinerView.alpha = 0.8
        conteinerView.backgroundColor = .СontainerView.customBackground
        conteinerView.layer.cornerRadius = 40
        
        [enterLabel,helloLabel].forEach {
            $0.textAlignment = .center
            $0.textColor = .Font.customMainWhite
        }
        
        let headerFont = TextStyle.header.font
        let bodySmallFont = TextStyle.bodySmall.font
        let bodyBigFont = TextStyle.bodyBig.font
        
        enterLabel.font = headerFont
        helloLabel.font = bodySmallFont
        adviceLabel.font = bodyBigFont
        registerButton.titleLabel?.font = bodyBigFont
        
        enterLabel.text = "Вход"
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
            let newViewController = TabBarController()
            newViewController.modalPresentationStyle = .fullScreen
            self.present(newViewController, animated: true, completion: nil)
        } else {
            self.showErrorHUDView(with: "введите логин и пароль")
        }
    }
    
    @objc private func registerButtonTapped() {
        let newViewController = RegistationViewController()
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.modalTransitionStyle = .flipHorizontal
        self.present(newViewController, animated: true, completion: nil)
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

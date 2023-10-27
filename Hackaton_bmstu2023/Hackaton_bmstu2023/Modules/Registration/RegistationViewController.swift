//
//  RegistationViewController.swift
//  Hackaton_bmstu2023
//
//  Created by Grigoriy on 27.10.2023.
//

import UIKit

final class RegistationViewController: CustomViewController {
    
    private let topCicrleView = CicleView()
    private var bottomCicrleView = CicleView(frame: CGRect(x: -81, y: 347, width: 348, height: 348))
    private let registrationView = UIView()
    private let registrationLabel = UILabel()
    private let helloLabel = UILabel()
    
    private let userNameFormTextView = FormTextView()
    private let passwordFormTextView = FormTextView()
    private let againstPasswordFormTextView = FormTextView()
    private let registerButton = UIButton()
    private let adviceLabel = UILabel()
    private let enterButton = UIButton()
}


//MARK: - life circle
extension RegistationViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        registrationView.addSubviews(userNameFormTextView, passwordFormTextView, againstPasswordFormTextView, registerButton, adviceLabel, enterButton)
        
        view.addSubviews(topCicrleView, bottomCicrleView, registrationView, helloLabel, registrationLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        topCicrleView.pin
            .top(-115)
            .left(50)
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
            .bottom(-50)
            .right(45)
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
        
        againstPasswordFormTextView.pin
            .below(of: passwordFormTextView)
            .marginTop(8)
            .horizontally(6)
            .height(36)
        
        registerButton.pin
            .below(of: againstPasswordFormTextView)
            .marginTop(8)
            .horizontally(6)
            .height(36)
        
        adviceLabel.pin
            .below(of: registerButton)
            .marginTop(8)
            .left(40)
            .width(110)
            .sizeToFit(.width)
        
        enterButton.pin
            .below(of: registerButton)
            .marginTop(8)
            .right(40)
            .size(CGSize(width: 39, height: 15))
    }
}

//MARK: - private methods
private extension RegistationViewController {
    func setup() {
        registrationView.backgroundColor = .СontainerView.customBackground
        registrationView.layer.cornerRadius = 40
        
        [registrationLabel,helloLabel].forEach {
            $0.textAlignment = .center
            $0.textColor = .Font.customMainWhite
        }
        
        registrationLabel.text = "Регистрация"
        helloLabel.text = "Добро пожаловать!"
        adviceLabel.text = "Уже есть аккаунт?"
        adviceLabel.textColor = .Font.customSecondGrayWhite
        
        
        registerButton.backgroundColor = .Button.customBlue
        registerButton.setTitle("Зарегистрироваться", for: .normal)
        registerButton.setTitleColor(.Font.customMainWhite, for: .normal)
        registerButton.layer.cornerRadius = 20
        
        userNameFormTextView.configFormTextView(with: UIImage(named: "person")!, title: "Имя пользователя")
        passwordFormTextView.configFormTextView(with: UIImage(named: "key")!, title: "Пароль")
        againstPasswordFormTextView.configFormTextView(with: UIImage(named: "key")!, title: "Подтвердите пароль")
        
        enterButton.setTitle("Войти!", for: .normal)
        enterButton.setTitleColor(.Button.customBlue, for: .normal)
        enterButton.titleLabel?.textAlignment = .center
        
        //dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        enterButton.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)
    }
    
    @objc private func enterButtonTapped() {
        navigationController?.pushViewController(AuthViewController(), animated: true)
    }
    
    @objc private func registerButtonTapped() {
        let username = userNameFormTextView.enterTextField.text
        let password = passwordFormTextView.enterTextField.text
        let confirmPassword = againstPasswordFormTextView.enterTextField.text

        if password == confirmPassword && username != "" {
            navigationController?.pushViewController(TabBarController(), animated: true)
        } else {
            if password != confirmPassword {
                print("пароли не совпадают!")
            } else if username == "" {
                print("введите имя пользователя!")
            }
        }
    }
}

extension RegistationViewController {
    struct Consts {
        static let cirleWidth: Double = 348
    }
}

extension RegistationViewController: UITextFieldDelegate {
    
    @objc private func dismissKeyboard() {
         view.endEditing(true)
     }
}

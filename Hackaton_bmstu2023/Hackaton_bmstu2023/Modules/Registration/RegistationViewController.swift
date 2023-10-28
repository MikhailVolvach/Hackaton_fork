//
//  RegistationViewController.swift
//  Hackaton_bmstu2023
//
//  Created by Grigoriy on 27.10.2023.
//

import UIKit

final class RegistationViewController: CustomViewController {
    
    private let topCicrleView = CicleView()
    private var bottomCicrleView = CicleView()
    private let conteinerView = UIView()
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
        
        conteinerView.addSubviews(userNameFormTextView, passwordFormTextView, againstPasswordFormTextView, registerButton, adviceLabel, enterButton)
        
        view.addSubviews(topCicrleView, bottomCicrleView, conteinerView, helloLabel, registrationLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        topCicrleView.pin
            .top(-115)
            .left(40)
            .size(CGSize(width: 400, height: 400))
        
        conteinerView.pin
            .vCenter()
            .horizontally(32)
            .height(300)
        
        registrationLabel.pin
            .above(of: conteinerView)
            .marginBottom(30)
            .horizontally(62)
            .height(36)
        
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
            .height(45)
        
        passwordFormTextView.pin
            .below(of: userNameFormTextView)
            .marginTop(12)
            .horizontally(6)
            .height(45)
        
        againstPasswordFormTextView.pin
            .below(of: passwordFormTextView)
            .marginTop(12)
            .horizontally(6)
            .height(45)
        
        registerButton.pin
            .below(of: againstPasswordFormTextView)
            .marginTop(12)
            .horizontally(6)
            .height(45)
        
        adviceLabel.pin
            .below(of: registerButton)
            .marginTop(12)
            .left(30)
            .width(140)
            .sizeToFit(.width)
        
        enterButton.pin
            .below(of: registerButton)
            .marginTop(12)
            .right(20)
            .size(CGSize(width: 110, height: 20))
    }
}

//MARK: - private methods
private extension RegistationViewController {
    func setup() {
        conteinerView.backgroundColor = .СontainerView.customBackground
        conteinerView.alpha = 0.8
        conteinerView.layer.cornerRadius = 40
        
        [registrationLabel,helloLabel].forEach {
            $0.textAlignment = .center
            $0.textColor = .Font.customMainWhite
        }
        
        let headerFont = TextStyle.header.font
        let bodySmallFont = TextStyle.bodySmall.font
        let bodyBigFont = TextStyle.bodyBig.font
        
        registrationLabel.font = headerFont
        helloLabel.font = bodySmallFont
        adviceLabel.font = bodyBigFont
        enterButton.titleLabel?.font = bodyBigFont
        
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
        
        enterButton.setTitle("войти", for: .normal)
        enterButton.setTitleColor(.Button.customBlue, for: .normal)
        enterButton.titleLabel?.textAlignment = .center
        
        //dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        enterButton.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)
    }
    
    @objc func enterButtonTapped() {
        let newViewController = AuthViewController()
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.modalTransitionStyle = .flipHorizontal
        self.present(newViewController, animated: true, completion: nil)
        //        navigationController?.pushViewController(AuthViewController(), animated: true)
    }
    
    @objc func registerButtonTapped() {
        let username = userNameFormTextView.enterTextField.text
        let password = passwordFormTextView.enterTextField.text
        let confirmPassword = againstPasswordFormTextView.enterTextField.text
        
        if password == confirmPassword && username != "" {
            let newViewController = TabBarController()
            newViewController.modalPresentationStyle = .fullScreen
            self.present(newViewController, animated: true, completion: nil)
            //            navigationController?.pushViewController(TabBarController(), animated: true)
        } else {
            if password != confirmPassword {
                self.showErrorHUDView(with: "пароли не совпадают!")
            } else if username == "" {
                self.showErrorHUDView(with: "введите имя пользователя!")
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

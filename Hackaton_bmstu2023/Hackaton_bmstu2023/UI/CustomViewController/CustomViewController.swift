//
//  ViewController.swift
//  Hackaton_bmstu2023
//
//  Created by Grigoriy on 27.10.2023.
//

import UIKit
import PinLayout

class CustomViewController: UIViewController {
    
    private let activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    private let errorHUDView = ErrorHUDView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .Background.customBackground
        setupactivityIndicatorView()
        setupErrorHUDView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        activityIndicatorView.pin.all()
        
        errorHUDView.pin
            .top(50)
            .horizontally(30)
    }
    
    private func setupactivityIndicatorView() {
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
        
        view.addSubview(activityIndicatorView)
    }
    
    func showActivityIndicator() {
        activityIndicatorView.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicatorView.stopAnimating()
    }
    
    private func setupErrorHUDView() {
        errorHUDView.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
        errorHUDView.isHidden = true
        errorHUDView.alpha = .zero
        view.addSubview(errorHUDView)
    }
    
    func showErrorHUDView(with error: String) {
        errorHUDView.configure(with: error)
        errorHUDView.isHidden = false
        animateShowErrorHUDView()
    }
    
    private func animateShowErrorHUDView() {
        UIView.animate(withDuration: 0.9, animations: { [weak self] in
            self?.errorHUDView.alpha = 1
        }) { [weak self] _ in // попадаем, когда вышли из блока animate
            self?.animateHideErrorHUDView()
        }
    }
    
    private func animateHideErrorHUDView() {
        UIView.animate(withDuration: 0.9, delay: 1.0, animations: { [weak self] in
            self?.errorHUDView.alpha = 0
        }) { [weak self] _ in
            self?.errorHUDView.isHidden = true
        }
    }
}


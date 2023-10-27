//
//  View.swift
//  Hackaton_bmstu2023
//
//  Created by Grigoriy on 26.10.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        for subview in subviews {
            addSubview(subview)
        }
    }
}

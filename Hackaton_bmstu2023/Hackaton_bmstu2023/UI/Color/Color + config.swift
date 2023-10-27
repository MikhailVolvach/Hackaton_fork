//
//  Color + config.swift
//  Hackaton_bmstu2023
//
//  Created by Grigoriy on 26.10.2023.
//


import UIKit

extension UIColor {
    struct Views {
        static let customPink: UIColor = Color(lightMode: prilPinkE3A8BE).currentColor
        static let customYellow: UIColor = Color(lightMode: prilYellowF8DDA8).currentColor
        static let customBlue: UIColor = Color(lightMode: prilBlueADC0DB).currentColor
    }
    
    struct ProgressView {
        static let customGray: UIColor = Color(lightMode: prilGrayD9D9D9).currentColor
        static let customGreen: UIColor = Color(lightMode: prilGreen6CDC72).currentColor
    }
    
    struct Fonts {
        static let customPink: UIColor = Color(lightMode: prilDarkPink713D4F).currentColor
        static let customYellow: UIColor = Color(lightMode: prilDarkYellow8C6D2E).currentColor
        static let customBlue: UIColor = Color(lightMode: prilDarkBlue1D3D69).currentColor
    }
    
    struct Background {
        static let customBackground: UIColor = Color(lightMode: prilGrayLightF6F6F6).currentColor
    }
    
    struct Button {
        static let customBlue: UIColor = Color(lightMode: prilBlue1890FF).currentColor
    }
}

private extension UIColor {
    static let prilGreen506C4B = UIColor(hex: "#506C4B") ??  Default.color
    //MARK: - LightMode
    //View
    
    // Cell
    static let prilPinkE3A8BE = UIColor(hex: "E3A8BE") ?? Default.color
    static let prilYellowF8DDA8 = UIColor(hex: "F8DDA8") ?? Default.color
    static let prilBlueADC0DB = UIColor(hex: "ADC0DB") ?? Default.color
    
    // ProgressView
    static let prilGrayD9D9D9 = UIColor(hex: "D9D9D9") ?? Default.color
    static let prilGreen6CDC72 = UIColor(hex: "6CDC72") ?? Default.color
    
    //Font
    static let prilDarkPink713D4F = UIColor(hex: "713D4F") ?? Default.color
    static let prilDarkYellow8C6D2E = UIColor(hex: "8C6D2E") ?? Default.color
    static let prilDarkBlue1D3D69 = UIColor(hex: "1D3D69") ?? Default.color
    
    //Background
    static let prilGrayLightF6F6F6 = UIColor(hex: "F6F6F6") ?? Default.color
    
    //Button
    static let prilBlue1890FF = UIColor(hex: "1890FF") ?? Default.color
    
    //MARK: - DarkMode
}

private extension UIColor {
    struct Default {
        static let color = UIColor.white
    }
}


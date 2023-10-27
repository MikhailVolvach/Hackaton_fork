//
//  Color + config.swift
//  Hackaton_bmstu2023
//
//  Created by Grigoriy on 26.10.2023.
//


import UIKit

extension UIColor {
    
    struct Font {
        static let customMainWhite: UIColor = Color(lightMode: prilWhiteFFFFFF).currentColor
        static let customSecondGrayWhite: UIColor = Color(lightMode: PrilGrayD6D6D6, darkMode: prilWhiteFFFFFF).currentColor
    }
    
    struct Background {
        static let customBackground: UIColor = Color(lightMode: prilGrayLightF6F6F6, darkMode: prilDarkBlack).currentColor
    }
    
    struct CirlceView {
        static let customBlueGray: UIColor = Color(lightMode: prilBlueB7DAF9, darkMode: prilGray404040).currentColor
    }
    
    struct Button {
        static let customBlue: UIColor = Color(lightMode: prilBlue1890FF, darkMode: prilBlue3B82F7).currentColor
    }
    
    struct СontainerView {
        static let customBackground: UIColor = Color(lightMode: prilWhiteFFFFFF, darkMode: prilGray26282B).currentColor
        
    }

}

private extension UIColor {
    
    static let prilWhiteFFFFFF = UIColor(hex: "FFFFFF") ?? Default.color
    
    //MARK: - LightMode
    //Background
    static let prilGrayLightF6F6F6 = UIColor(hex: "F6F6F6") ?? Default.color
    
    //CirlceView
    static let prilBlueB7DAF9 = UIColor(hex: "B7DAF9") ?? Default.color
    
    //Button
    static let prilBlue1890FF = UIColor(hex: "1890FF") ?? Default.color
    
    //Font
    static let PrilGrayD6D6D6 = UIColor(hex: "D6D6D6") ?? Default.color
    //MARK: - DarkMode
    //Background
    static let prilDarkBlack = UIColor(hex: "000000") ?? Default.color
    
    //CirlceView
    static let prilGray404040 = UIColor(hex: "404040") ?? Default.color
    
    //Button
    static let prilBlue3B82F7 = UIColor(hex: "3B82F7") ?? Default.color
    
    //Container
    static let prilGray26282B = UIColor(hex: "26282B") ?? Default.color
    
}

private extension UIColor {
    struct Default {
        static let color = UIColor.white
    }
}


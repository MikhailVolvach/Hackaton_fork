//
//  Font.swift
//  Hackaton_bmstu2023
//
//  Created by Grigoriy on 26.10.2023.
//

import UIKit

enum TextStyle {
    case header
    case titleBig
    case titleSmall
    case bodyBig
    case bodySmall
    
}

extension TextStyle {
    var font: UIFont {
        switch self {
        case .header:
            return UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        case .titleBig:
            return UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        case .titleSmall:
            return UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        case .bodyBig:
            return UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        case .bodySmall:
            return UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        }
    }
    
    private var fontSize: CGFloat {
        switch self {
        case .header:
            return 20
        case .titleBig:
            return 14
        case .titleSmall:
            return 12
        case .bodyBig:
            return 15
        case .bodySmall:
            return 12

        }
    }
    
    private var fontWeight: UIFont.Weight {
        switch self {
        case .header:
            return .bold
        case .titleBig, .titleSmall:
            return .semibold
        case .bodyBig, .bodySmall:
            return .regular
        }
    }
}

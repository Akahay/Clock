//
//  TickerType.swift
//  Clock
//
//  Created by Wysa on 16/02/21.
//

import UIKit

enum TickerType: Int {
    case hour
    case minute
    case second
}

extension TickerType {
    
    var radius: CGFloat {
        get {
            let radius = UIScreenSize.width/2
            switch self {
            case .hour:
                return radius - 80
            case .minute:
                return radius - 60
            case .second:
                return radius - 50
            }
        }
    }
    
    var color: UIColor {
        get {
            switch self {
            case .hour:
                return .black
            case .minute:
                return .blue
            case .second:
                return .red
            }
        }
    }
    
    var width: CGFloat {
        get {
            switch self {
            case .hour:
                return 2
            case .minute:
                return 1.5
            case .second:
                return 0.3
            }
        }
    }
    
    var degree: CGFloat {
        get {
            let degree: CGFloat = 30
            switch self {
            case .hour:
                return degree
            case .minute:
                return 2 * degree
            case .second:
                return 3 * degree
            }
        }
    }
}

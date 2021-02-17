//
//  LineTypes.swift
//  Clock
//
//  Created by Wysa on 16/02/21.
//

import UIKit

enum LineTypes: Int {
    case minuteIndicator
    case hourIndicator
}
 
extension LineTypes {
    
    var width: CGFloat {
        get {
            switch self {
            case .hourIndicator:
                return 2
            case .minuteIndicator:
                return 1
            }
        }
    }
    
    var numberOfSticks: Int {
        get {
            let indicator = 12
            switch self {
            case .hourIndicator:
                return indicator
            case .minuteIndicator:
                return indicator * 5
            }
        }
    }
    
    var degree: CGFloat {
        get {
            return Math.fullCircle/CGFloat(numberOfSticks)
        }
    }
    
    var color: UIColor {
        get {
            switch self {
            case .hourIndicator:
                return .black
            case .minuteIndicator:
                return .lightGray
            }
        }
    }
    
    var startingPoint: CGFloat {
        get {
            switch self {
            case .hourIndicator:
                return UIScreenSize.width/2 - 25
            case .minuteIndicator:
                return UIScreenSize.width/2 - 20
            }
        }
    }
    
    var endPoint: CGFloat {
        get {
            return UIScreenSize.width/2 - 15
        }
    }
}

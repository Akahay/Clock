//
//  CircleType.swift
//  Clock
//
//  Created by Wysa on 16/02/21.
//

import UIKit

enum CircleTypes: Int {
    case outerLayer
    case innerLayer
    case centerLayer
}

extension CircleTypes {
    
    var radius: CGFloat {
        get {
            let radius = UIScreenSize.width/2
            switch self {
            case .outerLayer:
                return radius - 10
            case .centerLayer:
                return radius - 15
            case .innerLayer:
                return 5
            }
        }
    }
    
    var color: UIColor {
        get {
            switch self {
            case .outerLayer:
                return .black
            case .centerLayer:
                return .darkGray
            case .innerLayer:
                return .lightGray
            }
        }
    }
    
    var width: CGFloat {
        get {
            switch self {
            case .outerLayer:
                return 1.5
            case .centerLayer:
                return 1
            case .innerLayer:
                return 1
            }
        }
    }
    
    var fillColor: UIColor {
        get {
            switch self {
            case .outerLayer:
                return .clear
            case .centerLayer:
                return .clear
            case .innerLayer:
                return .black
            }
        }
    }
}


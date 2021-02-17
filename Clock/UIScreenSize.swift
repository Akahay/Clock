//
//  UIScreenSize.swift
//  Clock
//
//  Created by Wysa on 16/02/21.
//

import UIKit

class UIScreenSize {
    
    static var center: CGPoint {
        get {
            return CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
        }
    }
    
    static var bounds: CGRect {
        get {
            return UIScreen.main.bounds
        }
    }
    
    static var width: CGFloat {
        get {
            return UIScreen.main.bounds.width
        }
    }
    
    static var height: CGFloat {
        get {
            return UIScreen.main.bounds.height
        }
    }
}

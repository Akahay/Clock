//
//  Math.swift
//  Clock
//
//  Created by Wysa on 16/02/21.
//

import UIKit

class Math {
    
    static var fullCircle: CGFloat {
        get {
            return 360
        }
    }
    
    static func sindeg(degrees: CGFloat) -> CGFloat {
        return sin(degrees * CGFloat.pi / 180.0)
    }
    
    static func cosdeg(degrees: CGFloat) -> CGFloat {
        return cos(degrees * CGFloat.pi / 180.0)
    }
    
    static func secondsToHoursMinutesSeconds(seconds : Int) -> (Int, Int, Int) {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    static func getDistance(pointA: CGPoint, pointB: CGPoint) -> CGFloat {
        let diffX = pointA.x - pointB.x
        let diffY = pointA.y - pointB.y
        return sqrt(diffX*diffX + diffY+diffY)
    }
    
    static func getPoints(radius: CGFloat, degree: CGFloat) -> CGPoint {
        let centerX = UIScreenSize.width/2
        let centerY = UIScreenSize.height/2
        
        let x = centerX + radius * Math.cosdeg(degrees: degree)
        let y = centerY + radius * Math.sindeg(degrees: degree)
        
        return CGPoint(x: x, y: y)
    }
}

//
//  ViewController.swift
//  Clock
//
//  Created by Wysa on 16/02/21.
//

import UIKit

class AnalogClockViewController: UIViewController {
    
    @IBOutlet weak var hourTextField: UITextField!
    @IBOutlet weak var minuteTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    
    private var timer: Timer?
    private var currentTimeStamp: Int64 = 0
    private var layerDictionary: [String: CALayer?] = [:]
    private let circleTypes: [CircleTypes] = [.outerLayer, .centerLayer, .innerLayer]
    private let lineTypes: [LineTypes] = [.minuteIndicator, .hourIndicator]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        lineTypes.forEach { lineType in
            drawLines(lineType: lineType)
        }
        circleTypes.forEach { circleTypes in
            drawCircle(circleType: circleTypes)
        }
        addTimeLabel()
        currentTimeStamp = Int64(Date().timeIntervalSince1970 * 1000)

        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)

    }
    
    @objc func runTimedCode(sender: Timer) {
        let date = Date()
        let calendar = Calendar.current

        let hours = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        
        setHands(hours: hours, minutes: minutes, seconds: seconds)
    }
    
    @IBAction func setClockHands(_ sender: UIButton) {
        
        var hoursValue: Int?
        var minutesValue: Int?
        var secondValue: Int?
        if let hoursText = hourTextField.text,
           let hours = Int(hoursText) {
            hoursValue = hours
        }
        if let minutesText = minuteTextField.text,
           let minutesInt = Int(minutesText) {
            minutesValue = minutesInt
        }
        if let secondText = secondTextField.text,
           let secondsInt = Int(secondText) {
            secondValue = secondsInt
        }
        if let hours = hoursValue,
           let minutes = minutesValue,
           let seconds = secondValue {
            setHands(hours: hours, minutes: minutes, seconds: seconds)
        }
    }
    
    private func setHands(hours: Int, minutes: Int, seconds: Int) {
        
        let offsetDegree: CGFloat = 270
        let hourHand = getHourHand(hour: hours, minute: minutes)
        let minuteHand = getMinuteHand(minute: minutes)
        let secondHand = getSecondHand(second: seconds)
        
        drawHands(handType: .hour, value: hourHand + offsetDegree)
        drawHands(handType: .minute, value: minuteHand + offsetDegree)
        drawHands(handType: .second, value: secondHand + offsetDegree)
        
        title = "\(hours):\(minutes):\(seconds)"
        drawCircle(circleType: .centerLayer)
    }
    
    private func getHourHand(hour: Int, minute: Int) -> CGFloat {
        return (CGFloat(hour) + CGFloat(minute)/CGFloat(60)) * CGFloat(30)
    }
    
    private func getMinuteHand(minute: Int) -> CGFloat {
        return CGFloat(minute) * CGFloat(6)
    }
    
    private func getSecondHand(second: Int) -> CGFloat {
        return CGFloat(second) * CGFloat(6)
    }
    
    private func addTimeLabel() {
        
        let numberOfTimeLabel = 12
        var currentDegree: CGFloat = 270
        let degree = Math.fullCircle/CGFloat(numberOfTimeLabel)
        let radius: CGFloat = UIScreenSize.width/2 - 40
        for time in 0..<numberOfTimeLabel {
            currentDegree = currentDegree + degree
            let point = Math.getPoints(radius: radius, degree: currentDegree)
            let timeLabel = UILabel(frame: CGRect(x: point.x - 10, y: point.y-10, width: 20, height: 20))
            timeLabel.text = "\(time+1) "
            timeLabel.textAlignment = .center
            view.addSubview(timeLabel)
        }
    }
    
    private func drawLines(lineType: LineTypes) {
        
        var currentDegree: CGFloat = 0
        for index in 0..<lineType.numberOfSticks {
            currentDegree = (CGFloat(index) * lineType.degree)
            let pointA = Math.getPoints(radius: lineType.startingPoint, degree: currentDegree)
            let pointB = Math.getPoints(radius: lineType.endPoint, degree: currentDegree)
            drawCustomLine(startPoint: pointA, endPoint: pointB, width: lineType.width, color: lineType.color)
        }
    }
    
    private func drawHands(handType: TickerType, value: CGFloat) {
        
        let point = Math.getPoints(radius: handType.radius, degree: value)
        drawCustomLine(startPoint: UIScreenSize.center, endPoint: point, width: handType.width, color: handType.color, key: "\(handType)")
    }
    
    private func drawCustomLine(startPoint: CGPoint, endPoint: CGPoint, width: CGFloat, color: UIColor, key: String? = nil) {
        
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        addShape(path: path, width: width, color: color, key: key)
    }
    
    private func drawCircle(circleType: CircleTypes) {
        
        let path = UIBezierPath(arcCenter: UIScreenSize.center, radius: circleType.radius, startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        addShape(path: path, width: circleType.width, color: circleType.color, fillColor: circleType.fillColor)
    }
    
    private func addShape(path: UIBezierPath, width: CGFloat, color: UIColor, fillColor: UIColor? = nil, key: String? = nil) {
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = fillColor?.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        shapeLayer.lineCap = .round
        view.layer.addSublayer(shapeLayer)
        if let key = key {
            if let oldShapeLayer = layerDictionary[key],
               let oldShape = oldShapeLayer {
                view.layer.replaceSublayer(oldShape, with: shapeLayer)
            }
            layerDictionary[key] = shapeLayer
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
    }
    
    deinit {
        print("ViewController flushed")
    }
}


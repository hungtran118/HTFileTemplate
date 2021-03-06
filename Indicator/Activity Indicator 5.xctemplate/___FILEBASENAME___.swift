//___FILEHEADER___

import UIKit

class ___FILEBASENAMEASIDENTIFIER___: UIView {
    
    //MARK:- SUPPORT VARIABLES
    private var isAnimate: Bool = true
    
    private var circleLayer = CAShapeLayer()
    private var circlePath = UIBezierPath()
    private var containerView = UIView()
    
    private let groupAnimation = CAAnimationGroup()
    private let animationFull = CABasicAnimation(keyPath: "strokeEnd")
    private let animationEmpty = CABasicAnimation(keyPath: "strokeEnd")
    private let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
    
    private var isClockwise: Bool = false
    private var timer = Timer()
    
    //MARK:- Custom color
    @IBInspectable var indicatorColor: UIColor {
        get {
            return self.color
        }
        set {
            self.color = newValue
        }
    }
    
    var color = UIColor.white {
        didSet {
            circleLayer.strokeColor = self.color.cgColor
        }
    }
    
    //MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        setToBaseState()
        self.addSubview(containerView)
        self.containerView.layer.addSublayer(self.circleLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        isAnimate = false
    }
    
    func startAnimate() {
        isAnimate = true
        animateRotate()
        animateCircle()
    }
    
    //MARK: - Config
    
    private func setToBaseState() {
        configContainer()
        configCircle()
    }
    
    private func configContainer() {
        
        containerView = UIView(frame: self.bounds)
        containerView.layoutIfNeeded()
    }
    
    private func configCircle() {
        
        circleLayer.path = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 10)/2, startAngle: 0, endAngle: 7, clockwise: true).cgPath
        
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = color.cgColor
        circleLayer.lineWidth = frame.width / 20
        circleLayer.strokeEnd = 0.8
        circleLayer.layoutIfNeeded()
    }
    
    private func animateRotate() {
        
        if isAnimate {
            rotateAnimation.fromValue = 0
            rotateAnimation.toValue = CGFloat.pi * 2
            rotateAnimation.duration = 1.2
            rotateAnimation.repeatCount = HUGE
            rotateAnimation.isRemovedOnCompletion = false
            
            containerView.layer.removeAllAnimations()
            containerView.layer.add(rotateAnimation, forKey: nil)
        }
    }
    
    private func animateCircle() {
        
        if isAnimate {
            
            circleLayer.removeAllAnimations()
            timer.invalidate()
            
            animationFull.duration = 0.5
            animationFull.fromValue = 0
            animationFull.toValue = 0.8
            animationFull.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            animationFull.fillMode = kCAFillModeForwards
            animationFull.isRemovedOnCompletion = false
            
            animationEmpty.duration = 0.5
            animationEmpty.beginTime = 0.9
            animationEmpty.fromValue = 0.8
            animationEmpty.toValue = 0
            animationEmpty.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            animationEmpty.fillMode = kCAFillModeForwards
            animationEmpty.isRemovedOnCompletion = false
            
            groupAnimation.animations = [animationFull, animationEmpty]
            groupAnimation.duration = 1.8
            groupAnimation.repeatCount = HUGE
            groupAnimation.fillMode = kCAFillModeForwards
            groupAnimation.isRemovedOnCompletion = false
            
            circleLayer.add(groupAnimation, forKey: "animateCircle")
            
            timer = Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(changeLayerPath), userInfo: nil, repeats: true)
            RunLoop.main.add(timer, forMode: .commonModes)
        }
    }
    
    @objc private func changeLayerPath() {
        
        if isClockwise {
            circleLayer.path = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 10)/2, startAngle: 0, endAngle: 7, clockwise: true).cgPath
        } else {
            circleLayer.path = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 10)/2, startAngle: -0.69, endAngle: -7.7, clockwise: false).cgPath
        }
        
        isClockwise = !isClockwise
    }
}

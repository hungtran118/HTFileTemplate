//___FILEHEADER___

import UIKit

class ___FILEBASENAMEASIDENTIFIER___: UIView {
    
    //MARK:- SUPPORT VARIABLES
    private var isAnimate: Bool = true
    private var dot1 = UIView()
    private var dot2 = UIView()
    private var dot3 = UIView()
    private var dot4 = UIView()
    private var dot5 = UIView()
    
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
            dot1.backgroundColor = self.color
            dot2.backgroundColor = self.color
            dot3.backgroundColor = self.color
            dot4.backgroundColor = self.color
            dot5.backgroundColor = self.color
        }
    }
    
    //MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        setToBaseState()
        self.addSubview(dot1)
        self.addSubview(dot2)
        self.addSubview(dot3)
        self.addSubview(dot4)
        self.addSubview(dot5)
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
        animate(dot: dot1, index: 0)
        animate(dot: dot2, index: 1)
        animate(dot: dot3, index: 2)
        animate(dot: dot4, index: 3)
        animate(dot: dot5, index: 4)
    }
    
    //MARK: - Config
    
    private func setToBaseState() {
        configDot(dot1, index: 0)
        configDot(dot2, index: 1)
        configDot(dot3, index: 2)
        configDot(dot4, index: 3)
        configDot(dot5, index: 4)
    }
    
    private func configDot(_ dot: UIView, index: Int) {
        
        let dotSize = self.frame.width / 5
        let size = dotSize - (CGFloat(4 - index) * (dotSize / 4))
        
        dot.frame = CGRect(x: (frame.size.width - size) / 2, y: (dotSize - size) / 2, width: size, height: size)
        dot.layer.cornerRadius = size / 2
        dot.layoutIfNeeded()
    }
    
    private func animate(dot: UIView, index: CGFloat) {
        if isAnimate {
            
            dot.layer.removeAllAnimations()
            
            let dotSize = self.frame.width / 5
            let size = dotSize - (CGFloat(index) * (dotSize / 4))
            let delay = Double(index + 1) / 20
            
            let groupAnimation = CAAnimationGroup()
            let sizeAnimation = CABasicAnimation(keyPath: "bounds.size")
            let cornerRadiusAnimation = CABasicAnimation(keyPath: "cornerRadius")
            let clockwiseAnimation = CAKeyframeAnimation(keyPath: "position")
            
            groupAnimation.duration = 1.3
            groupAnimation.repeatCount = HUGE
            
            sizeAnimation.fromValue = NSValue(cgSize: dot.frame.size)
            sizeAnimation.toValue = NSValue(cgSize: CGSize(width: size, height: size))
            sizeAnimation.fillMode = kCAFillModeForwards
            sizeAnimation.isRemovedOnCompletion = false
            sizeAnimation.duration = 1
            sizeAnimation.beginTime = delay
            
            cornerRadiusAnimation.fromValue = dot.frame.width / 2
            cornerRadiusAnimation.toValue = size / 2
            cornerRadiusAnimation.fillMode = kCAFillModeForwards
            cornerRadiusAnimation.isRemovedOnCompletion = false
            cornerRadiusAnimation.duration = 1
            cornerRadiusAnimation.beginTime = delay
            
            clockwiseAnimation.path = UIBezierPath(arcCenter: CGPoint(x: self.bounds.width / 2, y: self.bounds.width / 2), radius: (self.bounds.width - dotSize) / 2, startAngle: -0.5 * .pi, endAngle: 1.5 * .pi, clockwise: true).cgPath
            clockwiseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            clockwiseAnimation.duration = 1
            clockwiseAnimation.beginTime = delay
            
            groupAnimation.animations = [sizeAnimation, cornerRadiusAnimation, clockwiseAnimation]
            groupAnimation.isRemovedOnCompletion = false
            
            dot.layer.add(groupAnimation, forKey: dot.description)
        }
    }
}

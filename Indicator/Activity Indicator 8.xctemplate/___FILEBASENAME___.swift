//___FILEHEADER___

import UIKit

class ___FILEBASENAMEASIDENTIFIER___: UIView {
    
    //MARK:- SUPPORT VARIABLES
    private var isAnimate: Bool = true
    private var dot1 = UIView()
    private var dot2 = UIView()
    private var dot3 = UIView()
    
    private let groupAnimation = CAAnimationGroup()
    private let yPosAnimation = CABasicAnimation(keyPath: "position.y")
    
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
        animate(dot: dot1, delay: 0)
        animate(dot: dot2, delay: 0.1)
        animate(dot: dot3, delay: 0.2)
    }
    
    //MARK: - Config
    
    private func setToBaseState() {
        configDot(dot1, index: 0)
        configDot(dot2, index: 1)
        configDot(dot3, index: 2)
    }
    
    private func configDot(_ dot: UIView, index: Int){
        
        let dotSize = self.frame.width * 0.3
        let dotSpace = self.frame.width * 0.05
        
        dot.frame = CGRect(x: CGFloat(index) * (dotSize + dotSpace), y: (self.frame.width - dotSize) / 2, width: dotSize, height: dotSize)
        dot.backgroundColor = self.color
        dot.layer.cornerRadius = dotSize / 2
        dot.layoutIfNeeded()
        
    }
    
    private func animate(dot: UIView, delay: Double) {
        if isAnimate {
            
            dot.layer.removeAllAnimations()
            
            let dotSize = self.frame.width * 0.3
            
            groupAnimation.duration = 1
            groupAnimation.beginTime = round(10*CACurrentMediaTime())/10 + delay
            groupAnimation.repeatCount = HUGE
            
            yPosAnimation.fromValue = dot.frame.origin.y + (dotSize / 2)
            yPosAnimation.toValue = dot.frame.origin.y - (dotSize / 2)
            yPosAnimation.duration = 0.3
            yPosAnimation.autoreverses = true
            yPosAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            
            groupAnimation.animations = [yPosAnimation]
            groupAnimation.isRemovedOnCompletion = false
            
            dot.layer.add(groupAnimation, forKey: nil)
        }
    }
}

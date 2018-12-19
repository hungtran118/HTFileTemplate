//___FILEHEADER___

import UIKit

class ___FILEBASENAMEASIDENTIFIER___: UIView {
    
    //MARK:- SUPPORT VARIABLES
    private var isAnimate: Bool = true
    private var circle1 = UIView()
    private var circle2 = UIView()
    private var circle3 = UIView()
    
    private let groupAnimation = CAAnimationGroup()
    private let sizeAnimation = CABasicAnimation(keyPath: "bounds.size")
    private let cornerRadiusAnimation = CABasicAnimation(keyPath: "cornerRadius")
    private let fadeAnimation = CABasicAnimation(keyPath: "opacity")
    
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
            circle1.backgroundColor = self.color
            circle2.backgroundColor = self.color
            circle3.backgroundColor = self.color
        }
    }
    
    //MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        setToBaseState()
        self.addSubview(circle1)
        self.addSubview(circle2)
        self.addSubview(circle3)
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
        animate(circle: circle1, delay: 0)
        animate(circle: circle2, delay: 0.2)
        animate(circle: circle3, delay: 0.4)
    }
    
    //MARK: - Config
    
    private func setToBaseState() {
        configCircle(circle1, index: 0)
        configCircle(circle2, index: 1)
        configCircle(circle3, index: 2)
    }
    
    private func configCircle(_ circle: UIView, index: Int) {
        
        circle.frame = CGRect(x: self.frame.width / 2, y: self.frame.height / 2, width: 0, height: 0)
        circle.backgroundColor = self.color
        circle.alpha = 0.8
        circle.layoutIfNeeded()
    }
    
    private func animate(circle: UIView, delay: TimeInterval) {
        if isAnimate {
            
            circle.layer.removeAllAnimations()
            
            groupAnimation.beginTime = CACurrentMediaTime() + delay
            groupAnimation.duration = 1
            groupAnimation.repeatCount = HUGE
            
            sizeAnimation.fromValue = NSValue(cgSize: CGSize(width: 0, height: 0))
            sizeAnimation.toValue = NSValue(cgSize: CGSize(width: self.frame.width, height: self.frame.height))
            
            cornerRadiusAnimation.fromValue = 0
            cornerRadiusAnimation.toValue = self.frame.width / 2
            
            fadeAnimation.fromValue = 0.8
            fadeAnimation.toValue = 0
            
            groupAnimation.animations = [sizeAnimation, cornerRadiusAnimation, fadeAnimation]
            groupAnimation.isRemovedOnCompletion = false
            
            circle.layer.add(groupAnimation, forKey: nil)
        }
    }
}

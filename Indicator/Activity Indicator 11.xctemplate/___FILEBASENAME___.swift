//___FILEHEADER___

import UIKit

class ___FILEBASENAMEASIDENTIFIER___: UIView {
    
    //MARK:- SUPPORT VARIABLES
    private var isAnimate: Bool = true
    private var stick1 = UIView()
    private var stick2 = UIView()
    private var stick3 = UIView()
    private var stick4 = UIView()
    private var stick5 = UIView()
    private let heightAnimation1 = CABasicAnimation(keyPath: "bounds.size.height")
    private let heightAnimation2 = CABasicAnimation(keyPath: "bounds.size.height")
    
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
            stick1.backgroundColor = self.color
            stick2.backgroundColor = self.color
            stick3.backgroundColor = self.color
            stick4.backgroundColor = self.color
            stick5.backgroundColor = self.color
        }
    }
    
    //MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        setToBaseState()
        self.addSubview(stick1)
        self.addSubview(stick2)
        self.addSubview(stick3)
        self.addSubview(stick4)
        self.addSubview(stick5)
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
        animate(stick: stick1, duration: 0)
        animate(stick: stick2, duration: 0.25)
        animate(stick: stick3, duration: 0.5)
        animate(stick: stick4, duration: 0.25)
        animate(stick: stick5, duration: 0)
    }
    
    //MARK: - Config
    
    private func setToBaseState() {
        configStick(stick1, index: 0)
        configStick(stick2, index: 1)
        configStick(stick3, index: 2)
        configStick(stick4, index: 3)
        configStick(stick5, index: 4)
    }
    
    private func configStick(_ stick: UIView, index: Int) {
        
        if index == 0 || index == 4 {
            stick.frame.size = CGSize(width: frame.width / 9, height: frame.height)
        } else if index == 2 {
            stick.frame.size = CGSize(width: frame.width / 9, height: frame.height / 3)
        } else {
            stick.frame.size = CGSize(width: frame.width / 9, height: frame.height * 2 / 3)
        }
        
        stick.frame.origin.x = CGFloat(index*2) / 9 * self.frame.height
        stick.center.y = self.frame.height / 2
        stick.layer.cornerRadius = stick.frame.width / 2
        stick.layoutIfNeeded()
    }
    
    private func animate(stick: UIView, duration: Double) {
        if isAnimate {
            
            stick.layer.removeAllAnimations()
            
            //Beginning animate
            CATransaction.begin()
            CATransaction.setAnimationDuration(duration)
            
            CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
            
            heightAnimation1.fromValue = stick.frame.size.height
            heightAnimation1.toValue = self.frame.size.height
            heightAnimation1.isRemovedOnCompletion = true
            
            CATransaction.setCompletionBlock {
                
                //Comming animate
                CATransaction.begin()
                CATransaction.setAnimationDuration(0.5)
                CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
                
                self.heightAnimation2.fromValue = self.frame.size.height
                self.heightAnimation2.toValue = self.frame.size.height / 3
                self.heightAnimation2.autoreverses = true
                self.heightAnimation2.repeatCount = HUGE
                self.heightAnimation2.isRemovedOnCompletion = false
                stick.layer.add(self.heightAnimation2, forKey: stick.description)
                
                CATransaction.commit()
            }
            
            stick.layer.add(heightAnimation1, forKey: nil)
            
            CATransaction.commit()
        }
    }
}

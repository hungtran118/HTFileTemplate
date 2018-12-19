//___FILEHEADER___

import UIKit

class ___FILEBASENAMEASIDENTIFIER___: UIView {
    
    //MARK:- SUPPORT VARIABLES
    private var isAnimate: Bool = true
    private let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
    private var radial: RadialCircleView?
    
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
            radial?.removeFromSuperview()
            setToBaseState()
            self.addSubview(radial!)
            animate()
        }
    }
    
    //MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        setToBaseState()
        self.addSubview(radial!)
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
        animate()
    }
    
    //MARK: - Config
    
    private func setToBaseState() {
        radial = RadialCircleView(frame: self.bounds, strokeColor: self.color)
        radial?.backgroundColor = .clear
    }
    
    private func configCircle(_ circle: UIView, index: Int) {
        
        circle.frame = CGRect(x: self.frame.width / 2, y: self.frame.height / 2, width: 0, height: 0)
        circle.backgroundColor = self.color
        circle.alpha = 0.8
        circle.layoutIfNeeded()
    }
    
    private func animate() {
        
        if isAnimate {
            rotateAnimation.fromValue = 0
            rotateAnimation.toValue = CGFloat.pi * 2
            rotateAnimation.duration = 1
            rotateAnimation.repeatCount = HUGE
            rotateAnimation.isRemovedOnCompletion = false
            
            radial?.layer.removeAllAnimations()
            radial?.layer.add(rotateAnimation, forKey: nil)
        }
    }
}

class RadialCircleView: UIView {
    
    var strokeColor = UIColor.clear
    
    init(frame: CGRect, strokeColor: UIColor) {
        super.init(frame: frame)
        
        self.strokeColor = strokeColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let colorComponents = strokeColor.cgColor.components else { return }
        
        let thickness: CGFloat = rect.width / 10
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2 - thickness / 2
        var last: CGFloat = 0
        
        for i in 1...360 {
            
            let ang = CGFloat(i) / 180 * .pi
            let arc = UIBezierPath(arcCenter: center, radius: radius, startAngle: last, endAngle: ang, clockwise: true)
            arc.lineWidth = thickness
            last = ang
            
            if colorComponents.count == 4 {
                UIColor(red: colorComponents[0], green: colorComponents[1], blue: colorComponents[2], alpha: colorComponents[3] * CGFloat(i) / 360).set()
            } else {
                UIColor(white: colorComponents[0], alpha: colorComponents[1] * CGFloat(i) / 360).set()
            }
            
            arc.stroke()
        }
    }
}

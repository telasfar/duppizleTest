//
//  ExtenstionUIView.swift
//  DuppizleTest
//
//  Created by Tariq Maged on 13/11/2021.
//

import UIKit

import UIKit

extension UIView {
 
    
    public func fillSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
            rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
            topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        }
    }
    
    public func anchor(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        _ = anchorWithReturnAnchors(top, left: left, bottom: bottom, right: right, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant, widthConstant: widthConstant, heightConstant: heightConstant)
    }
    
    public func anchorWithReturnAnchors(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
    
    public func anchorCenterXToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    public func anchorCenterYToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    public func anchorCenterSuperview() {
        anchorCenterXToSuperview()
        anchorCenterYToSuperview()
    }
    
   
        func fadeTo(alphaValue: CGFloat, withDuration duration: TimeInterval) {
            UIView.animate(withDuration: duration) {
                self.alpha = alphaValue
            }
        }
        
        func roundCorners(corners: UIRectCorner, radius: CGFloat) {
              let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
              let mask = CAShapeLayer()
              mask.path = path.cgPath
              layer.mask = mask
          }
        
        func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
            let animation = CABasicAnimation(keyPath: "transform.rotation")
            animation.toValue = toValue
            animation.duration = duration
            animation.isRemovedOnCompletion = false
            animation.fillMode = CAMediaTimingFillMode.forwards
            self.layer.add(animation, forKey: nil)
            
        }
        
        func bindToKeyboard(){
            //nedeef observer yetabe3 el keyboard we ba3d keda ye3mel action eno yerfa3 el send key le foo2z
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        }
        
        func roundedCornerWithBorder(_ roundedBy:CGFloat,colour:UIColor = UIColor.clear){
            self.layer.cornerRadius = roundedBy
            self.layer.borderWidth = 1.0
            self.layer.borderColor = colour.cgColor
        }
        
        @objc  func keyboardWillChange (notification : NSNotification){
            let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
            let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
            let beginningFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
            let endFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let deltaY = endFrame.origin.y - beginningFrame.origin.y
            
            UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue: curve), animations: {
                self.frame.origin.y += deltaY*0.5 
            }, completion: nil)
        }
        

        
        func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.locations = [0, 1]
            gradientLayer.frame = bounds
            layer.insertSublayer(gradientLayer, at: 0)
        }
        
        func addDarkTint(target: Any?, action: Selector) {
            guard self.viewWithTag(1001001) == nil else {
                return
            }
            let tintTag = 1001001
            let tintView = UIButton(frame: frame)
            tintView.backgroundColor = .black
            tintView.translatesAutoresizingMaskIntoConstraints = false
            tintView.alpha = 0
            tintView.tag = tintTag
            
            addSubview(tintView)
            NSLayoutConstraint.activate([
                tintView.topAnchor.constraint(equalTo: topAnchor),
                tintView.leadingAnchor.constraint(equalTo: leadingAnchor),
                tintView.trailingAnchor.constraint(equalTo: trailingAnchor),
                tintView.bottomAnchor.constraint(equalTo: bottomAnchor)
                ])
            
            UIView.animate(withDuration: 0.2) {
                tintView.alpha = 0.6
            }
            
            tintView.addTarget(target, action: action, for: .touchUpInside)
        }
        
        @objc func removeDarkTint() {
            let tintTag = 1001001
            guard let tintView = viewWithTag(tintTag) else { return }
            UIView.animate(withDuration: 0.2, animations: {
                tintView.alpha = 0
            }) { _ in
                tintView.removeFromSuperview()
            }
        }
        

        
        func dismissAsActionSheet() {
            UIView.animate(
                withDuration: 0.3, delay: 0,
                usingSpringWithDamping: 0.9,
                initialSpringVelocity: 0.2,
                options: .curveLinear,
                animations: {
                    self.transform = CGAffineTransform(translationX: 0, y: self.bounds.height)
            }) { completed in
                if completed {
                    self.removeFromSuperview()
                }
            }
        }
        
        func fadeViewOnView(presentingView: UIView){
            
             presentingView.addDarkTint(target: self, action: #selector(fadeOutView))
            translatesAutoresizingMaskIntoConstraints = false

            presentingView.addSubview(self)
            alpha = 0
            
            anchor(presentingView.topAnchor, left: presentingView.leftAnchor, bottom: presentingView.bottomAnchor, right: presentingView.rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 16, rightConstant: 16, widthConstant: 0, heightConstant: 0)
            
            presentingView.endEditing(true)
            UIView.animate(
                withDuration: 0.7, delay: 0,
                usingSpringWithDamping: 0.85,
                initialSpringVelocity: 0,
                options: .curveLinear,
                animations: {

                    self.alpha = 1

            }, completion: nil)
            
        }
        
        @objc func fadeOutView(presentingView: UIView){
            presentingView.removeDarkTint()
                   
                   UIView.animate(
                       withDuration: 0.7, delay: 0,
                       usingSpringWithDamping: 0.85,
                       initialSpringVelocity: 0,
                       options: .curveLinear,
                       animations: {
                           
                               self.alpha = 0
                           

                   }) { completed in
                       if completed {
                           self.removeFromSuperview()
                       }
                   }
            
        }
        
        func slideIn(width: CGFloat, presentingView: UIView,constant:CGFloat = 0.0) {

            presentingView.addDarkTint(target: self, action: #selector(slideOut))
            translatesAutoresizingMaskIntoConstraints = false

            presentingView.addSubview(self)

                transform = CGAffineTransform(translationX: -width, y: 0)
            //}
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: presentingView.topAnchor,constant: constant),
                leadingAnchor.constraint(equalTo: presentingView.leadingAnchor),
                bottomAnchor.constraint(equalTo: presentingView.bottomAnchor),
                widthAnchor.constraint(equalToConstant: width)
                
                ])

            presentingView.endEditing(true)

            
            UIView.animate(
                withDuration: 0.35, delay: 0,
                usingSpringWithDamping: 0.85,
                initialSpringVelocity: 0,
                options: .curveLinear,
                animations: {

                    self.transform = CGAffineTransform.identity

            }, completion: nil)

        }
        
        @objc func slideOut(presentingView: UIView) {
            
            presentingView.removeDarkTint()
            
            UIView.animate(
                withDuration: 0.35, delay: 0,
                usingSpringWithDamping: 0.85,
                initialSpringVelocity: 0,
                options: .curveLinear,
                animations: {
                    
                        self.transform = CGAffineTransform(translationX: -self.bounds.width, y: 0)
                    

            }) { completed in
                if completed {
                    self.removeFromSuperview()
                }
            }
        }
        
        func dismissFromSuperView() {
            UIView.animate(withDuration: 0.2, animations: {
                self.alpha = 0
            }) { completed in
                if completed {
                    self.removeFromSuperview()
                }
            }
        }
        
    }



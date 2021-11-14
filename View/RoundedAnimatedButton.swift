//
//  RoundedAnimatedButton.swift
//  Arkan
//
//  Created by BinaryCase on 1/2/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit

class RoundedAnimatedButton: UIButton {
    
    //mat7otesh el button ely hayet3amlo animation fo2 el mapview 3ala tol 7ot fo2eha view clear we elbutton fe el view el clear..we 3emoman law el animation mashta3'alestsh 7otaha fo2 view 3ady
    
    //var
    
    var originalSize: CGRect?
    var originalButtonText: String?
    var activityIndicator: UIActivityIndicatorView!
    
    func setupView() {
        originalSize = self.frame
        self.layer.cornerRadius = self.frame.height / 4
        self.layer.shadowRadius = 10.0
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize.zero
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        
    }
    
    func animateButton(shouldLoad: Bool, withMessage message: String?) {
        let spinner = UIActivityIndicatorView()
        spinner.style = .large
        spinner.color = UIColor.white
        spinner.alpha = 0.0
        spinner.hidesWhenStopped = true
        spinner.tag = 21
        
        if shouldLoad {
            self.addSubview(spinner)
            
            self.setTitle("", for: .normal)
            UIView.animate(withDuration: 0.2, animations: {
                self.layer.cornerRadius = self.bounds.height / 2
                self.frame = CGRect(x: self.bounds.midX - (self.bounds.height / 2), y: self.bounds.origin.y, width: self.bounds.height, height: self.bounds.height)
            }, completion: { (finished) in
                if finished == true {
                    spinner.startAnimating()
                    spinner.center = CGPoint(x: self.frame.width / 2 + 1, y: self.frame.width / 2 + 1)
                    spinner.fadeTo(alphaValue: 1.0, withDuration: 0.2)
                }
            })
            self.isUserInteractionEnabled = false
        } else {
            self.isUserInteractionEnabled = true
            
            for subview in self.subviews {
                if subview.tag == 21 {
                    subview.removeFromSuperview()
                }
            }
            
            UIView.animate(withDuration: 0.2, animations: {
                self.frame = self.originalSize!
                self.layer.cornerRadius = self.frame.height / 2
                self.setTitle(message, for: .normal)
              
//  _ = self.anchor(self.superview?.topAnchor, left: self.superview?.leftAnchor, bottom: self.superview?.bottomAnchor, right: self.superview?.rightAnchor, topConstant: 2, leftConstant: 2, bottomConstant: 2, rightConstant: 2, widthConstant: (self.originalSize?.width)! , heightConstant: (self.originalSize?.height)!)
            })
         
        }
    }
    

    
    func showLoading() {
        originalButtonText = self.titleLabel?.text
        self.setTitle("", for: UIControl.State.normal)
        
        if (activityIndicator == nil) {
            activityIndicator = createActivityIndicator()
        }
        
        showSpinning()
    }
    
    func hideLoading() {
        self.setTitle(originalButtonText, for: UIControl.State.normal)
        activityIndicator.stopAnimating()
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .whiteLarge
        activityIndicator.color = UIColor.white
        return activityIndicator
    }
    
    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }
    
    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }

    
}

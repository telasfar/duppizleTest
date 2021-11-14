//
//  ExtensionUIViewControllers.swift
//  DuppizleTest
//
//  Created by Tariq Maged on 13/11/2021.
//

import UIKit

extension UIViewController {
    
    func executeAfterDelay(_ seconds: Double, completion: @escaping ()->Void) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(Int(seconds * 1000.0))) {
            completion()
        }
    }
    
    func dipressDarkMode(){
        //UIUserInterfaceStyle in your app info.plist and set its value to Light or Dark.
        if #available(iOS 13.0, *) {
             // Always adopt a light interface style.
             overrideUserInterfaceStyle = .light
         }
    }
    
    func presentDetail(_ viewControl : UIViewController,_ direction:CATransitionSubtype = .fromRight){
        let transtion = CATransition()
        transtion.duration = 0.3
        transtion.type = CATransitionType.push
        transtion.subtype = direction
        self.view.window?.layer.add(transtion, forKey: kCATransition)
        viewControl.modalPresentationStyle = .fullScreen
        present(viewControl, animated: false, completion: nil)
        
    }
    
    func dissmissToVc(_ viewControl : UIViewController){
        let transtion = CATransition() //CA 2e7'tesar Core Animation ..lazem ne3mel create lel transtion
        transtion.duration = 0.3
        transtion.type = CATransitionType.reveal
        transtion.subtype = CATransitionSubtype.fromRight  //hato men el yemen
        self.view.window?.layer.add(transtion, forKey: kCATransition)    //hane3mel add lel transion
        viewControl.modalPresentationStyle = .fullScreen
        present(viewControl, animated: false, completion: nil)
    }
    
   
    
    func addFadeBackground(_ status:Bool,color:UIColor?){
        var fadeView:UIView
        if status{
            fadeView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
            fadeView.backgroundColor = color
            fadeView.alpha = 0.0
            fadeView.tag = 98
            view.addSubview(fadeView)
            fadeView.fadeTo(alphaValue: 0.7, withDuration: 0.3)

        }else {
            for subview in view.subviews {
                if subview.tag == 98 {
                    UIView.animate(withDuration: 0.3, animations: {
                        subview.alpha = 0.0
                    }) { (finish) in
                         subview.removeFromSuperview()
                    }
                }
            }
        }
    }
    

    
    struct Holder {
        static var _myComputedProperty:Bool = true
    }
    
    func dissmissDetail (_ direction:CATransitionSubtype = .fromLeft){
        let transtion = CATransition() //CA 2e7'tesar Core Animation ..lazem ne3mel create lel transtion
        transtion.duration = 0.3
        transtion.type = CATransitionType.push
        transtion.subtype = direction  //hato men el yemen
        self.view.window?.layer.add(transtion, forKey: kCATransition)    //hane3mel add lel transion
        dismiss(animated: false, completion: nil)
    }
    
    
    func alertUser (message:String){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
      
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func shouldPresentLoadingView(_ status:Bool){
        var fadeView:UIView
        if status {
            if Holder._myComputedProperty{
            fadeView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
            fadeView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            fadeView.alpha = 0.0
            fadeView.tag = 991
            let spinner = UIActivityIndicatorView() //spinner
            spinner.color = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                spinner.style = .large
            spinner.center = view.center
            view.addSubview(fadeView)//7atenah el 2awel fa hyro7 lel backGround
            fadeView.addSubview(spinner) //hayet7at fo2 el fadeView
            fadeView.fadeTo(alphaValue: 0.7, withDuration: 0.3)
            spinner.startAnimating()
            Holder._myComputedProperty = false
            }
        }else {
            Holder._myComputedProperty = true
            for subview in view.subviews {
                if subview.tag == 991 {
                    UIView.animate(withDuration: 0.3, animations: {
                        subview.alpha = 0.0
                        
                    }, completion: { (finish) in
                        subview.removeFromSuperview() //elspinner hayetshal ma3a el fadeview
                    })
                }
            }
        }
    }
}

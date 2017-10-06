//
//  helper.swift
//  Salaty
//
//  Created by ahmed on 9/13/17.
//  Copyright © 2017 ahmedRabie. All rights reserved.
//

import Foundation

import UIKit

class helper: NSObject {
    
    class func restertApp (){
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        let sb = UIStoryboard(name: "Main", bundle: nil)
        var vc : UIViewController
        if getToken(Key: "code") == nil
        {
            vc = sb.instantiateInitialViewController()!
        }
        else {
            vc = sb.instantiateViewController(withIdentifier: "main")
        }
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
    }
    class func saveToken(Token : String)
    {
        // save  code or user id
        let def = UserDefaults.standard
        def.setValue(Token, forKey: "country")
        def.synchronize()
       // restertApp()
    }
    class func getToken(Key :String)  -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: Key ) as? String
        
    }
    class func shadow(view : UIView){
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.7
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 4
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
    }
    class func rightAndTopshadow(view : UIView){
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 4
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
    }
    
}

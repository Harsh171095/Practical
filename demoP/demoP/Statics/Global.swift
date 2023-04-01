//
//  Global.swift
//  demoP
//
//  Created by 200OK-IOS5 on 31/03/23.
//

import Foundation
import UIKit

typealias Json = [String:Any]

func showAlert(_ controller: UIViewController, title: String, message: String, buttons: [String] = ["Okay"], actions: ((UIAlertAction)->Void)? = nil) {
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    buttons.forEach { str in
        alert.addAction(UIAlertAction(title: str, style: .default, handler: actions))
    }
    controller.present(alert, animated: true, completion: nil)
}


func showLoader(_ controller: UIViewController) {
    DispatchQueue.main.async {
    let view = UIView()
    view.frame = controller.view.bounds
    view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    view.tag = 1001
    
    let activityView = UIView()
    activityView.frame = CGRect(origin: CGPoint(x: controller.view.frame.midX - 55, y: controller.view.frame.midY - 55), size: CGSize(width: 55, height: 55))
    activityView.backgroundColor = UIColor.white
    activityView.layer.cornerRadius = 5
    
    let activityIndicator = UIActivityIndicatorView()
    activityIndicator.frame = activityView.bounds
    activityIndicator.startAnimating()
    
    controller.view.addSubview(view)
    view.addSubview(activityView)
    activityView.addSubview(activityIndicator)
    }
}

func hideLoader(_ controller: UIViewController) {
    DispatchQueue.main.async {
        if let view = controller.view.viewWithTag(1001) {
            view.removeFromSuperview()
        }
    }
    
}

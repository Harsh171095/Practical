//
//  ViewController.swift
//  demoP
//
//  Created by 200OK-IOS5 on 30/03/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            authUser = AuthUser()
            if let _ = authUser?.userEmail{
                // User is already logedin
                self.navigationController?.pushViewController(ProductVC(), animated: true)
            } else {
                // User is not logedin
                self.navigationController?.pushViewController(SigninVC(), animated: true)
            }
        }
    }

    
    
}


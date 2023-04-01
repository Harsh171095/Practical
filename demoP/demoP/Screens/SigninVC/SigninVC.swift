//
//  SigninVC.swift
//  demoP
//
//  Created by 200OK-IOS5 on 31/03/23.
//

import UIKit
import GoogleSignIn
import AuthenticationServices

class SigninVC: UIViewController {
    
    @IBOutlet weak private var viewTop:UIView!
    @IBOutlet weak private var viewBottom:UIView!
    
    @IBOutlet weak private var btnAppleSignIn:UIButton!
    @IBOutlet weak private var btnGoogleSigIn:UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        viewTop.clipsToBounds = true
        viewTop.layer.cornerRadius = 30
        viewTop.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        btnAppleSignIn.layer.cornerRadius = 10
        btnGoogleSigIn.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Button Actions
    /// click on Apple Sign in button
    @IBAction private func btnAppleSignIN_click() {
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
    /// click on Google Sign in button
    @IBAction private func btnGoogleSignIN_click() {
        GIDSignIn.sharedInstance.signOut()
        GIDSignIn.sharedInstance.signIn(
            withPresenting: self) { signInResult, error in
                if let result = signInResult {
                    print("Success")
                    authUser = AuthUser(userName: result.user.profile?.name ?? "", userEmail: result.user.profile?.email ?? "")
                } else {
                    print("error \(String(describing: error))")
                    showAlert(self, title: "Google Sigin", message: error?.localizedDescription ?? "")
                }
                
               
                // If sign in succeeded, display the app's main content View.
            }
    }
}
extension SigninVC: ASAuthorizationControllerDelegate {

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
    let userID = appleIDCredential.user
//    let fullName = appleIDCredential.fullName
//    let email = appleIDCredential.email
//    print("User id is \(userIdentifier) \n Full Name is \(String(describing: fullName)) \n Email id is \(String(describing: email))") }
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: userID) {  (credentialState, error) in
             switch credentialState {
                case .authorized:
                    // The Apple ID credential is valid.
                 print("Success")
                 authUser = AuthUser(userName: appleIDCredential.fullName?.givenName ?? "", userEmail: appleIDCredential.email ?? "")
                    break
                case .revoked:
                    // The Apple ID credential is revoked.
                 print("error Apple ID credential is revoked")
                 showAlert(self, title: "Apple Sigin", message: "Apple ID credential is revoked")
                    break
             case .notFound:
                    // No credential was found, so show the sign-in UI.
                 print("error No credential was found")
                 showAlert(self, title: "Apple Sigin", message: "No credential was found")
                 break
                default:
                    break
             }
        }
        
    }
    }
    
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        showAlert(self, title: "Apple Sigin", message: error.localizedDescription)
        print("error\(String(describing: error))")
    }
}

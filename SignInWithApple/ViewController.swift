//
//  ViewController.swift
//  SignInWithApple
//
//  Created by iSal on 05/04/20.
//  Copyright © 2020 iSal. All rights reserved.
//

import UIKit
import AuthenticationServices

class ViewController: UIViewController, ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupAppleSignInButton()
        performExistingAccountSetupFlows()
    }

    private func setupAppleSignInButton() {
        let button = ASAuthorizationAppleIDButton()
        button.addTarget(self, action: #selector(appleIDHandler), for: .touchUpInside)
        self.stackView.addArrangedSubview(button)
    }

    @objc private func appleIDHandler(){
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
            
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    private func performExistingAccountSetupFlows() {
        let requests = [ASAuthorizationAppleIDProvider().createRequest()]
//        requests[0].requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension ViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleCredentialID as ASAuthorizationAppleIDCredential:
            self.performSegue(withIdentifier: "goToDetail", sender: nil)
            self.passDetailInformation(credential: appleCredentialID)
        default:
            print(authorization.credential)
            break
        }
    }
    
    private func passDetailInformation(credential: ASAuthorizationAppleIDCredential){
        guard let vc = self.presentedViewController as? DetailViewController else { return  }
        DispatchQueue.main.async {
            vc.setupView(credentialApple: credential)
        }
    }
}

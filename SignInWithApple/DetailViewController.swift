//
//  DetailViewController.swift
//  SignInWithApple
//
//  Created by iSal on 05/04/20.
//  Copyright © 2020 iSal. All rights reserved.
//

import UIKit
import AuthenticationServices

class DetailViewController: UITableViewController {

    @IBOutlet weak var identifierDetail: UILabel!
    @IBOutlet weak var fullnameDetail: UILabel!
    @IBOutlet weak var emailDetail: UILabel!
    @IBOutlet weak var tokenDetail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupView(credentialApple: ASAuthorizationAppleIDCredential){
        self.identifierDetail.text = credentialApple.user
        self.fullnameDetail.text = (credentialApple.fullName?.givenName ?? "") + " " + (credentialApple.fullName?.familyName ?? "")
        self.emailDetail.text = credentialApple.email
        self.tokenDetail.text = credentialApple.identityToken?.base64EncodedString()
    }
}

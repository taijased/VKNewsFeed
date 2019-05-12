//
//  AuthViewController.swift
//  VKNewsFeed
//
//  Created by Maxim Spiridonov on 12/05/2019.
//  Copyright © 2019 Maxim Spiridonov. All rights reserved.
//

import UIKit



class AuthViewController: UIViewController {

    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        authService = AuthService()
        authService = AppDelegate.shared().authService
    }

    @IBAction func signInTouch() {
        authService.wakeUpSession()
    }
}

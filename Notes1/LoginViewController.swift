//
//  LoginViewController.swift
//  Notes1
//
//  Created by Gev Darbinyan on 27/06/2019.
//  Copyright © 2019 com.inYerevan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 6.0
    }
    
    @IBAction private func loginAction() {
        guard let notesViewController = self.storyboard?.instantiateViewController(withIdentifier: "NotesListViewController") as? NotesListViewController else { return }
        let navVC = UINavigationController(rootViewController: notesViewController)
        present(navVC, animated: true, completion: nil)
    }
}

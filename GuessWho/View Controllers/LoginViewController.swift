//
//  LoginViewController.swift
//  GuessWho
//
//  Created by Steven Leyva on 7/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else { return }
        
        HTTPClient.shared.login(withUsername: email, password: password) { (error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "ShowDashboardSegue", sender: self)
                //self.present(DashboardViewController(), animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else { return }
        
        HTTPClient.shared.register(withUsername: email, password: password) { (error) in
            if let error = error {
                print("Error with registering: \(error)")
                return
            }
            print("Register success")
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

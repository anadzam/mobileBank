//
//  LoginViewController.swift
//  AMC
//
//  Created by Ana Dzamelashvili on 1/11/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        //scrollView.backgroundColor = UIColor(hexString: "012a4a")
        //        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        //2b2d42
        
        scrollView.clipsToBounds = true
        return scrollView
        
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "back")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let emailField: UITextField = {
        let emailField = UITextField()
        emailField.autocapitalizationType = .none
        emailField.autocorrectionType = .no
        emailField.returnKeyType = .continue
        emailField.layer.cornerRadius = 25
        emailField.textColor = .white
        emailField.layer.borderWidth = 1
        emailField.layer.borderColor = UIColor.lightGray.cgColor
        //        emailField.placeholder = "Email Adress"
        let myTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        
        emailField.attributedPlaceholder = NSAttributedString(
            string: "Email Address",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        
        emailField.leftView = UIView(frame: CGRect(x: 0,
                                                   y: 0,
                                                   width: 12,
                                                   height: 0))
        emailField.leftViewMode = .always
        //emailField.backgroundColor = .white
        return emailField
    }()
    
    private let passwordField: UITextField = {
        let passwordField = UITextField()
        passwordField.autocapitalizationType = .none
        passwordField.autocorrectionType = .no
        passwordField.returnKeyType = .done
        passwordField.textColor = .white
        passwordField.layer.cornerRadius = 25
        passwordField.layer.borderWidth = 1
        passwordField.layer.borderColor = UIColor.lightGray.cgColor
        //        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        passwordField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        
        passwordField.leftView = UIView(frame: CGRect(x: 0,
                                                      y: 0,
                                                      width: 12,
                                                      height: 0))
        passwordField.leftViewMode = .always
        //emailField.backgroundColor = .white
        return passwordField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        return button
    }()
    
//    private let registerButton: UIButton = {
//        let registerButton = UIButton()
//        registerButton.setTitle("Register", for: .normal)
//        //        registerButton.backgroundColor = .white
//        registerButton.setTitleColor(.link, for: .normal)
//        registerButton.layer.cornerRadius = 25
//        registerButton.layer.masksToBounds = true
//        registerButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
//        return registerButton
//    }()
    
    
    private var loginObserver: NSObjectProtocol?
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background1")!)
        
//        loginObserver = NotificationCenter.default.addObserver(forName: .didLoginNotification,
//                                               object: nil,
//                                               queue: .main,
//                                               using: { [weak self] _ in
//            guard let strongSelf = self else {
//                return
//            }
//            strongSelf.navigationController?.dismiss(animated: true, completion: nil)
//
//        })
        
        
        //        view.backgroundColor = .white
//        title = "Welcome"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.link]
        
        
                navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                                    style: .done,
                                                                    target: self,
                                                                    action: #selector(didTapRegister))
        
        
        
       

        
        loginButton.addTarget(self,
                              action: #selector(loginButtonTapped),
                              for: .touchUpInside)
        
        emailField.delegate = self
        passwordField.delegate = self
        
        
        //add here subviews
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginButton)
//        scrollView.addSubview(registerButton)
        
    }
//    
//    deinit {
//        if let observer = loginObserver {
//            NotificationCenter.default.removeObserver(observer)
//        }
//    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        
        imageView.frame = CGRect(x: (scrollView.width-size)/2,
                                 y: 20,
                                 width: size,
                                 height: size)
        
        emailField.frame = CGRect(x: 30,
                                  y: imageView.bottom + 5,
                                  width: scrollView.width - 60,
                                  height: 50)
        
        passwordField.frame = CGRect(x: 30,
                                     y: emailField.bottom + 12,
                                     width: scrollView.width - 60,
                                     height: 50)
        
        loginButton.frame = CGRect(x: 30,
                                   y: passwordField.bottom + 18,
                                   width: scrollView.width - 60,
                                   height: 52)
        
//        registerButton.frame = CGRect(x: 30,
//                                      y: loginButton.bottom + 20,
//                                      width: scrollView.width - 60,
//                                      height: 52)
    }
    
    
    @objc private func loginButtonTapped() {
        
        emailField.becomeFirstResponder()
        passwordField.becomeFirstResponder()
        
        guard let email = emailField.text, let password = passwordField.text,
              !email.isEmpty, !password.isEmpty,  password.count >= 6  else {
                  alertLoginError()
                  return
              }
        
        //Firebase login add
        FirebaseAuth.Auth.auth().signIn(withEmail: email,
                                        password: password,
                                        completion: { [weak self] authResult, error in
            guard let strongSelf = self else {
                return
            }
            guard let result = authResult, error == nil else {
                print("Failed to log in with user: \(email)")
                return
                
            }
            let user = result.user
            print("Successfully logged in: \(user)")
            strongSelf.navigationController?.dismiss(animated: true, completion: nil)
        })
        
        
        
   
    }
    
    func alertLoginError() {
        let alert = UIAlertController(title: "Login Error",
                                      message: "Please fill all fields to log in",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .cancel,
                                      handler: nil))
        
        present(alert, animated: true)
        
    }
    
    
    @objc private func didTapRegister() {
        let vc = RegisterViewController()
        vc.title = "Create Accpunt"
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            loginButtonTapped()
        }
        return true
    }
    
   
}


//
//  RegisterViewController.swift
//  AMC
//
//  Created by Ana Dzamelashvili on 1/11/22.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
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
    
    private let firstNameField: UITextField = {
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
            string: "First Name",
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
    
    
    private let lastNameField: UITextField = {
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
            string: "Last Name",
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
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        return button
    }()
    
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background1")!)
        
        
        
        //        view.backgroundColor = .white
        title = "Welcome"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.link]
        
        
        //        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
        //                                                            style: .done,
        //                                                            target: self,
        //                                                            action: #selector(didTapRegister))
        
        
        //
        
        
        registerButton.addTarget(self,
                                 action: #selector(registerButtonTapped),
                                 for: .touchUpInside)
        
        emailField.delegate = self
        passwordField.delegate = self
        
        //add here subviews
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(registerButton)
        
        
        
    }
   
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        
        imageView.frame = CGRect(x: (scrollView.width-size)/2,
                                 y: 20,
                                 width: size,
                                 height: size)
        
        firstNameField.frame = CGRect(x: 30,
                                      y: imageView.bottom + 5,
                                      width: scrollView.width - 60,
                                      height: 50)
        
        lastNameField.frame = CGRect(x: 30,
                                     y: firstNameField.bottom + 5,
                                     width: scrollView.width - 60,
                                     height: 50)
        
        emailField.frame = CGRect(x: 30,
                                  y: lastNameField.bottom + 5,
                                  width: scrollView.width - 60,
                                  height: 50)
        
        passwordField.frame = CGRect(x: 30,
                                     y: emailField.bottom + 12,
                                     width: scrollView.width - 60,
                                     height: 50)
        
        registerButton.frame = CGRect(x: 30,
                                      y: passwordField.bottom + 18,
                                      width: scrollView.width - 60,
                                      height: 52)
        
        //        Copied from login screen
        //        registerButton.frame = CGRect(x: 30,
        //                                      y: registerButton.bottom + 20,
        //                                      width: scrollView.width - 60,
        //                                      height: 52)
    }
    
   
    @objc private func registerButtonTapped() {
        
        emailField.becomeFirstResponder()
        passwordField.becomeFirstResponder()
        firstNameField.becomeFirstResponder()
        lastNameField.becomeFirstResponder()
        
      
             
        guard let firstName = firstNameField.text,
              let lastName = lastNameField.text,
              let email = emailField.text,
              let password = passwordField.text,
              !email.isEmpty,
              !password.isEmpty,
              !firstName.isEmpty,
              !lastName.isEmpty,
              password.count >= 6  else {
                  alertLoginError()
                  return
              }
        
        //Firebase login add
        DatabaseManager.shared.userExists(with: email, completion: { [weak self] exists in
            guard let strongSelf = self else {
                
                return
            }
            guard !exists else {
                //user already exists
                strongSelf.alertLoginError(message: "User with this email address already exists.")
                return
            }
            
            FirebaseAuth.Auth.auth().createUser(withEmail: email,
                                                password: password,
                                                completion: { authResult, error in
               
                guard authResult != nil, error == nil else {
                    print("Error occured during creating the user")
                    return
                    
                }
                
                DatabaseManager.shared.insertUser(with: bankUser(firstName: firstName,
                                                                 lastName: lastName,
                                                                 emailAddress: email))
                strongSelf.navigationController?.dismiss(animated: true, completion: nil)
            })
        })
        
        
    }
    
    func alertLoginError(message: String = "Invalid Credentials for registration") {
        let alert = UIAlertController(title: "Registration Error",
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .cancel,
                                      handler: nil))
        
        present(alert, animated: true)
        
    }
    
    
    @objc private func didTapRegister() {
        let vc = RegisterViewController()
        vc.title = "Create Accpunt"
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            registerButtonTapped()
        }
        return true
    }
}

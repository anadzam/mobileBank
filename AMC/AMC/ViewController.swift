//
//  ViewController.swift
//  AMC
//
//  Created by Ana Dzamelashvili on 1/11/22.
//

import UIKit
import FirebaseAuth

import SideMenu

class ViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate {
    
    var menu: SideMenuNavigationController?
    
    @IBOutlet weak var balanceLable: UILabel!
    
    
    @IBOutlet weak var depositField: UITextField!
    
    
    let userDefaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        depositField.delegate = self
      
//        self.tabBarController?.tabBar.backgroundColor = .white
        
        if let value = userDefaults.value(forKey: "balance") as? String {
            
            balanceLable.text = value
            
            
        }
        
        
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
        
      
    }
    
    @IBAction func depositButton(_ sender: UIButton) {
        
        
        let deposit = Float(depositField.text!)
        var balanceValue = Float(balanceLable.text!) ?? 0    // Get the label value content expected
        
        balanceValue += deposit ?? 0            // add the specified value
        balanceLable.text = "\(balanceValue)"
        
        
        //        balanceLable.text = deposit
        depositField.endEditing(true)
        
        let alert = UIAlertController(title: "Transaction Completed", message: "Has been successfully deposited", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Done", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"Done\" alert occured.")
            
        }))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    @IBAction func withdrawButton(_ sender: UIButton) {
        let withdraw = Float(depositField.text!)
        var balanceValue = Float(balanceLable.text!) ?? 0
        balanceValue -= withdraw ?? 0            // add the specified value
        balanceLable.text = "\(balanceValue)"
        
        //        balanceLable.text = deposit
        depositField.endEditing(true)
        
        let alert = UIAlertController(title: "Transaction Completed", message: "Has been successfully withdrawn", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Done", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
        
        
        
    }
    
    
    @IBAction func didTapMenu() {
        present(menu!, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        validateAuth()
        
    }
    func textField(_ depositField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {userDefaults.setValue(depositField.text, forKey: "balance")
        
        let isNumber = CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string))
        let withDecimal = (
            string == NumberFormatter().decimalSeparator &&
            depositField.text?.contains(string) == false
        )
        return isNumber || withDecimal
    }
    
    func textFieldShouldReturn (_ depositField: UITextField) -> Bool {
        
        userDefaults.setValue(depositField.text, forKey: "balance")
        depositField.endEditing(true)
        depositField.resignFirstResponder()
        
        return true
    }
    func textFieldShouldEndEditing(_ depositField: UITextField) -> Bool {
        if depositField.text != "" {
            return true
        } else {
            
            return false
        }
    }
    func textFieldDidEndEditing(_ depositField: UITextField) {
        userDefaults.setValue(depositField.text, forKey: "balance")
        depositField.text = ""
        
    }
    
    
    
    
    private func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
            
        }
    }
    
    
    class MenuListController: UITableViewController {
        
        
        let data = ["Log Out"]
        //    let darkColor = UIColor(hexString: "012A4A")
        
        override func viewDidLoad() {
            super.viewDidLoad()
            //        tableView.backgroundColor = darkColor
            //        tableView.backgroundColor = UIColor(hexString: "012a4a")
            tableView.register(UITableViewCell.self,
                               forCellReuseIdentifier: "cell")
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return data.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = data[indexPath.row]
            cell.textLabel?.textColor = .red
            
            return cell
            
        }
        
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            
            let actionSheet = UIAlertController(title: "",
                                                message: "",
                                                preferredStyle: .actionSheet)
            
            actionSheet.addAction(UIAlertAction(title: "Log out",
                                                style: .destructive,
                                                handler: { [weak self] _ in
                guard let strongSelf = self else {
                    return
                }
                
                do {
                    try FirebaseAuth.Auth.auth().signOut()
                    let vc = LoginViewController()
                    let nav = UINavigationController(rootViewController: vc)
                    nav.modalPresentationStyle = .fullScreen
                    strongSelf.present(nav, animated: false)
                }
                catch {
                    print("Failed to log out")
                }
                
            }))
            
            actionSheet.addAction(UIAlertAction(title: "Cancel",
                                                style: .cancel,
                                                handler: nil))
            
            present(actionSheet, animated: true)
            
            
            
        }
        
    }
    
}


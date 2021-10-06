//
//  ViewController.swift
//  Project28
//
//  Created by Vishrut Vatsa on 23/05/21.
//

import UIKit
import LocalAuthentication


//MARK: - BASICS

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Nothing to see here"
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustforkeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustforkeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
//         another notification that will tell us when the application will stop being active – i.e., when our app has been backgrounded or the user has switched to multitasking mode //
        
        notificationCenter.addObserver(self, selector: #selector(saveSecretMessage), name: UIApplication.willResignActiveNotification, object: nil)
    }

    //MARK: - FUNCTIONS
    
    @objc func adjustforkeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification{
            secret.contentInset = .zero
            
        } else {
            secret.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
            
        }
        secret.scrollIndicatorInsets = secret.contentInset
        
        let selectedRange = secret.selectedRange
        secret.scrollRangeToVisible(selectedRange)
        
        
    }
    
    //MARK: - OUTLET
    
    @IBOutlet var secret: UITextView!
    
    @IBAction func authenticateTapped(_ sender: Any) {
        
       let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify Yourself"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                
                [weak self] success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self?.unlockSecretMessage()
                    } else {
                        let ac = UIAlertController(title: "Authentication Failed", message: "You couldn't be verified", preferredStyle: .alert)
                        
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        
                        self?.present(ac, animated: true)
                        
                    }
                }
            }
        } else {
            let ac = UIAlertController(title: "Biometry unavailable", message: "The required h/w isnt avilable om this idevie", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            
        }
    }
    
    //MARK: - FUNCTIONS
    
    func unlockSecretMessage() {
        
        secret.isHidden = false
        title = "Secret Stuff"
        if KeychainWrapper.standard.string(forKey: "Secret Message") != nil {
            secret.text = KeychainWrapper.standard.string(forKey: "Secret Message") ?? ""
        }
    }
    
    @objc func saveSecretMessage() {
        
        guard secret.isHidden == false else {return}
        KeychainWrapper.standard.set(secret.text, forKey: "SecretMessage")
        secret.resignFirstResponder()
        secret.isHidden = true
        title = "Nothing to see here"
        
    }
}

//MARK: - END

//
//  SignupWithLoyaltyVC.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 5/21/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import UIKit

class SignupWithLoyaltyVC: UIViewController {

    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var lblSignup: UILabel!
    
    @IBOutlet weak var txtLoyaltyNumber: UITextField!
    @IBOutlet weak var txtRegisterNumber: UITextField!
    
    let progressBar = ProgressHUD(text: Constant.WAIT_MESSAGE_TEXT)
    var isCardUser = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //Called when the user click on the view (outside the UITextField).
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setupView()  {
        
        btnSignup.layer.cornerRadius = 12
        
        txtLoyaltyNumber.setLeftPaddingPoints(20)
        txtRegisterNumber.setLeftPaddingPoints(20)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SignupWithLoyaltyVC.signUpLblTapFunction))
        lblSignup.isUserInteractionEnabled = true
        lblSignup.addGestureRecognizer(tap)
        
        self.view.addSubview(progressBar)
        progressBar.hide()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signWithoutLoyalty" {
            if let vc = segue.destination as? SignupWithoutLoyaltyVC {
                let registerNumber    = txtRegisterNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines)
                let loyaltyNmuber     = txtLoyaltyNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines)
                
                vc.regNumber  = registerNumber!
                vc.cardNumber = loyaltyNmuber!
                vc.isCardUser = self.isCardUser
            }
        }
    }
    
    @objc func signUpLblTapFunction(sender:UITapGestureRecognizer) {
        self.isCardUser = false
        self.performSegue(withIdentifier: "signWithoutLoyalty", sender: nil)
    }
 
    @IBAction func backBtnTap(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signBtnTap(_ sender: UIButton) {
        
        //Validate user inputs
        if validationInputFields() {
            
            let registerNumber    = txtRegisterNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let loyaltyNmuber     = txtLoyaltyNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines)
          
            progressBar.show()
            
            //Make api call
            validateCard(regNo: registerNumber!, printedCardNumber: loyaltyNmuber!)
        }
    }
    
    func validateCard (regNo: String, printedCardNumber: String)  {
    
        SignupWithLoyaltyAPI.validateCardNumber(printedCardNumber: printedCardNumber, regCode: regNo) { result, error, status in
            
            self.progressBar.hide()
            
            if status == 200 && result != nil {
                
                if result?.result == "success" {
                    
                    if result?.registrationStatus == "Unregistered"{
                        self.isCardUser = true
                        self.performSegue(withIdentifier: "signWithoutLoyalty", sender: nil)

                    }else {
                        Alert.showInvalidCardAlert(on: self)
                    }
                    
                }else {
                    
                    Alert.showInvalidCardAlert(on: self)
                }
                
            }else if status == 401 {
                Alert.showInvalidCardAlert(on: self)
            }else {
                //Server error
                _ = APIErrorHandling(error: error!, vc: self)
            }
        }
    }
}

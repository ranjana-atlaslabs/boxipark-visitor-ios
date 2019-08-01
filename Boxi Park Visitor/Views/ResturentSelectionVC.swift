//
//  ViewController.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 5/16/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import UIKit

class ResturentSelectionVC: UIViewController {
    
    //Mark @IBoutlets
    @IBOutlet weak var scrollViw: UIScrollView!
    @IBOutlet weak var btnOffer: UIButton!
    @IBOutlet weak var tblProfileData: UITableView!
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var leadingConstrianSidebar: NSLayoutConstraint!
    @IBOutlet weak var tralingConstrianSearch: NSLayoutConstraint!
    @IBOutlet weak var lblEditProfile: UILabel!
    @IBOutlet weak var lblViewEditProfile: UIView!
    @IBOutlet weak var viwSearch: UIView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var viwWeather: UIView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblNoData: UILabel!
    @IBOutlet weak var viewOffer: UIView!
    @IBOutlet weak var qrImage: UIImageView!
    
    //Mark Varialbles
    //should be let data type and must goes to constant file
    var itemCount          = 5
    var tagId              = 0
    let colorArray         = [#colorLiteral(red: 0.9520129561, green: 0.9357979894, blue: 0.893722713, alpha: 1), #colorLiteral(red: 0.7740916014, green: 0.3885799944, blue: 0.2412629426, alpha: 1), #colorLiteral(red: 0.9653725028, green: 0.835703373, blue: 0.556709826, alpha: 1), #colorLiteral(red: 0.7598508, green: 0.2347533405, blue: 0.190864265, alpha: 1), #colorLiteral(red: 0.2463579476, green: 0.3117541969, blue: 0.3831449151, alpha: 1), #colorLiteral(red: 0.9520129561, green: 0.9357979894, blue: 0.893722713, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.4114020467, green: 0.6439546347, blue: 0.5185563564, alpha: 1),#colorLiteral(red: 0.133510083, green: 0.1185990497, blue: 0.1235295162, alpha: 1), #colorLiteral(red: 0.1140215024, green: 0.3539430797, blue: 0.4238928854, alpha: 1)]
    let imagesArray        = [ #imageLiteral(resourceName: "barnonalogon"), #imageLiteral(resourceName: "canoli_logo"), #imageLiteral(resourceName: "lacajitalogon"), #imageLiteral(resourceName: "fowl flay"), #imageLiteral(resourceName: "hopslogon"), #imageLiteral(resourceName: "grilllogon"), #imageLiteral(resourceName: "clawlogon"), #imageLiteral(resourceName: "naughtylogon"), #imageLiteral(resourceName: "barxilogon"), #imageLiteral(resourceName: "beforelogon")]
    let profileDetailsArry = ["Card Number", "Registration Number", "Call Support", "Loyalty Points"]
    var profileValueArry   = ["", "", "+95 285 299 653", "0.00"]
    var isSidebarOpen      = false
    var selectedImage      = UIView()
    var isPageLoad         = false
    var menuApiData: MenuData!
    var allResutresntViews = [UIView()]
    var lblError           = UILabel()
    var userInformations: UserInformationResult!

    
    //Mark: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupview()
        
    }
    
    override func viewWillLayoutSubviews() {
        
        if isPageLoad {
            
            isPageLoad = false
            
            self.activityIndicatorView.startAnimating()
            self.getResutrantMenus()
           
        }
    }
    
    //Mark: @IBAction
    @IBAction func sidebarBtnTap(_ sender: Any) {
        
        self.leadingConstrianSidebar.constant = 0
        self.isSidebarOpen = true
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func searchBtnTap(_ sender: Any) {
        self.tralingConstrianSearch.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    @IBAction func offerBtnTap(_ sender: UIButton) {
        self.performSegue(withIdentifier: "offer", sender: nil)
    }
    
    @IBAction func btnLogoutTap(_ sender: Any) {
        AppSessionManager.removeAllObject()
        self.performSegue(withIdentifier: "Main", sender: nil)
    }
    
    @IBAction func historyBtnTap(_ sender: UIButton) {
        self.performSegue(withIdentifier: "history", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "menu" {
            if let vc = segue.destination as? MenuVC {
                vc.color = selectedImage.backgroundColor!
                vc.image = imagesArray[selectedImage.tag]
                vc.resutrentMenu = self.menuApiData.data.menus.first(where: {$0.id == Constant.RETURENT_LOCAL_DATA[selectedImage.tag].id})
            }
        }
        
        else if segue.identifier == "edit"{
            
            if let vc = segue.destination as? ProfileEditorVC {
                vc.userInformations = self.userInformations
            }
        }
        
        else if segue.identifier == "history"{
            
            if let vc = segue.destination as? HistroyVC {
                vc.points = self.profileValueArry[profileValueArry.count - 1]
            }
        }
    }
    
    
    //Mark: API CALL
    
    //get menu items from single platform
    func getResutrantMenus() {
        
        MenuAPI.getMenus() { result, error in
            
            if error == nil {
                
                if let modal = result {
                    self.menuApiData = modal
                    DispatchQueue.main.async {
                        
                        self.activityIndicatorView.stopAnimating()
                        var contentRect = CGRect.zero
                        
                        for view in self.scrollViw.subviews {
                            contentRect = contentRect.union(view.frame)
                        }
                        
                        self.setupScrollView()
                    }
                }
                
            }else {
                self.activityIndicatorView.stopAnimating()
                self.lblNoData.text = "No Internet Connection"
                self.lblNoData.isHidden = false
                _ = APIErrorHandling(error: error!, vc: self)
            }
            
            
        }
    }
    
    //get user infomation from Paytronix
    func getUserInformation()  {
        
        ResturentAPI.userInformation() { result, error, status in
            
            if status == 200 && result != nil  {
                
                self.userInformations = result
                
                if let card = result?.primaryCardNumbers[0] {
                    
                    self.profileValueArry[0] = card
                    let image = self.generateBarcode(from: card)
                    self.qrImage.image = image
                    
                    AppSessionManager.savePrintedCardNumber(number: card)
                }
                
                if let reg = result?.accountIds[0] {
                    self.profileValueArry[1] = "\(reg)"
                }
                
                if let username = result?.fields.firstName {
                    self.lblUsername.text = username.capitalizingFirstLetter()
                }
                
                self.tblProfileData.reloadData()
                self.getAccountInformation()

                
            }else if status == 401 {
                
                Utility.getAccessTokenUsingRefreshToken()
                
            }else {
                _ = APIErrorHandling(error: error!, vc: self)
            }
        }
        
    }
    
    func getAccountInformation()  {
        
        ResturentAPI.accountInformation() { result, error, status in
            
            if status == 200 && result != nil  {
                
                if (result?.pointBalances.count)!  > 0 {
                    
                    self.profileValueArry[3] = result?.pointBalances[0].balance ?? "0"
                    
                }
                
                self.tblProfileData.reloadData()
                
            }else if status == 401 {
                
                Utility.getAccessTokenUsingRefreshToken()
                
            }else {
                _ = APIErrorHandling(error: error!, vc: self)
            }
        }
    }
}


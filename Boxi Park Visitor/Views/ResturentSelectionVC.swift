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
    @IBOutlet weak var lblNoData: UILabel!
    @IBOutlet weak var viewOffer: UIView!
    @IBOutlet weak var qrImage: UIImageView!
    
    //Mark Varialbles
    var itemCount          = 5
    var tagId              = 0
    let colorArray         = [#colorLiteral(red: 0.9520129561, green: 0.9357979894, blue: 0.893722713, alpha: 1), #colorLiteral(red: 0.7740916014, green: 0.3885799944, blue: 0.2412629426, alpha: 1), #colorLiteral(red: 0.9653725028, green: 0.835703373, blue: 0.556709826, alpha: 1), #colorLiteral(red: 0.7598508, green: 0.2347533405, blue: 0.190864265, alpha: 1), #colorLiteral(red: 0.2463579476, green: 0.3117541969, blue: 0.3831449151, alpha: 1), #colorLiteral(red: 0.9520129561, green: 0.9357979894, blue: 0.893722713, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.4114020467, green: 0.6439546347, blue: 0.5185563564, alpha: 1),#colorLiteral(red: 0.133510083, green: 0.1185990497, blue: 0.1235295162, alpha: 1), #colorLiteral(red: 0.1140215024, green: 0.3539430797, blue: 0.4238928854, alpha: 1)]
    let imagesArray        = [ #imageLiteral(resourceName: "barnonalogon"), #imageLiteral(resourceName: "canoli_logo"), #imageLiteral(resourceName: "lacajitalogon"), #imageLiteral(resourceName: "fowl flay"), #imageLiteral(resourceName: "hopslogon"), #imageLiteral(resourceName: "grilllogon"), #imageLiteral(resourceName: "clawlogon"), #imageLiteral(resourceName: "naughtylogon"), #imageLiteral(resourceName: "barxilogon"), #imageLiteral(resourceName: "beforelogon")]
    let profileDetailsArry = ["Card Number", "Registration Number", "Call Support"]
    let profileValueArry   = ["002658932525", "14626421296499296", "+95 285 299 653"]
    var isSidebarOpen      = false
    var selectedImage      = UIView()
    var isPageLoad         = false
    var menuApiData: MenuData!
    var allResutresntViews = [UIView()]
    var lblError           = UILabel()
    
    
    //Mark: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupview()
        
    }
    
    override func viewWillLayoutSubviews() {
        
        if isPageLoad {
            
            isPageLoad = false
            
            if Constant.OFFLINE_DATA_ON {
                
                if let path = Bundle.main.path(forResource: "menu", ofType: "json") {
                    do {
                        let fileUrl = URL(fileURLWithPath: path)
                        // Getting data from JSON file using the file URL
                        let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                        let decoder = JSONDecoder()
                        let jsonData = try decoder.decode(MenuData.self, from: data as Data)
                        self.menuApiData = jsonData
                        DispatchQueue.main.async {
                            
                            self.activityIndicatorView.stopAnimating()
                            var contentRect = CGRect.zero
                            
                            for view in self.scrollViw.subviews {
                                contentRect = contentRect.union(view.frame)
                            }
                            
                            self.setupScrollView()
                        }
                        
                    } catch {
                        print("error")
                    }
                }
                    
                else {
                    print("no file")
                }
            }else {
                
                self.activityIndicatorView.startAnimating()
                self.getResutrantMenus()
            }
           
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "menu" {
            if let vc = segue.destination as? MenuVC {
                vc.color = selectedImage.backgroundColor!
                vc.image = imagesArray[selectedImage.tag]
                vc.resutrentMenu = self.menuApiData.data.menus.first(where: {$0.id == Constant.RETURENT_LOCAL_DATA[selectedImage.tag].id})
            }
        }
    }
    
    
    //Mark: API CALL
    fileprivate func getResutrantMenus() {
        
        API.getMenus() { result, error in
            
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
    
    //Mark: Custome Methods
    func setupview()  {
 
        self.lblNoData.isHidden = true
        
        //notify page is load done
        self.isPageLoad = true
        
        self.btnOffer.layer.cornerRadius       = 5
        self.btnLogout.layer.cornerRadius      = 8
        self.tblProfileData.tableFooterView    = UIView()
        self.tblProfileData.rowHeight          = UITableView.automaticDimension
        
        //add swap gestures Recognize
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSideBarGesture))
        swipeRight.direction = .right
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSideBarGesture))
        swipeLeft.direction = .left
        
        // Add tap gesture recognizer to lbllogout
        let tap                   = UITapGestureRecognizer(target: self, action: #selector(handleEditProfiletTap(_:)))
        lblEditProfile.addGestureRecognizer(tap)
        lblEditProfile.isUserInteractionEnabled = true
        lblViewEditProfile.addGestureRecognizer(tap)
        lblViewEditProfile.isUserInteractionEnabled = true

        lblEditProfile.set(image: #imageLiteral(resourceName: "edit_icon"), with: "Edit profile")
        
        let tap2                   = UITapGestureRecognizer(target: self, action: #selector(handleSearchTap(_:)))
        viwSearch.addGestureRecognizer(tap2)
        viwSearch.isUserInteractionEnabled = true
        
        let tap3                   = UITapGestureRecognizer(target: self, action: #selector(handleOfferViewTap(_:)))
        viewOffer.addGestureRecognizer(tap3)
        viewOffer.isUserInteractionEnabled = true
        
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
        
        txtSearch.layer.cornerRadius = 15
        txtSearch.rightViewMode = .always
        txtSearch.leftViewMode = .always
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: 20+8, height: 20) )
        let leftOuterView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10) )
        
        let iconView  = UIImageView(frame: CGRect(x: -8, y: 0, width: 20, height: 20))
        iconView.image = #imageLiteral(resourceName: "search")
        outerView.addSubview(iconView)
        
        txtSearch.rightView = outerView
        txtSearch.leftView = leftOuterView
        
        Constant.SHOW_ERROR_MSG = true
  
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(statusManager),
                         name: .flagsChanged,
                         object: nil)
        updateUserInterface()
        
        let image = generateQRCode(from: "002658932525")
        self.qrImage.image = image
    }
    
    func setupScrollView()  {
        
        Constant.RETURENT_LOCAL_DATA.forEach { (resturent) in
            
            if self.menuApiData.data.menus.contains(where: {$0.name == resturent.name}) {
                resturent.id = self.menuApiData.data.menus.first(where: {$0.name == resturent.name})?.id
                
            }
        }
        
        //set scrollView size
        self.scrollViw.contentSize = CGSize(width:self.view.frame.width, height:((view.frame.height/4) * CGFloat(itemCount)) + 60 + viwWeather.frame.height)
        
        
        let viw = TopView(frame: CGRect(x: 0, y: viwWeather.frame.height , width: view.frame.width , height: view.frame.height/4 + 40))
        
        var side1 = UIView(frame: CGRect(x: 0, y: 0, width: viw.frame.width/2, height: viw.frame.height))
        var side1Image = createImageView(x: 0, y: 0, width: (side1.frame.width/1.5), height: (side1.frame.height/1.5), image:  imagesArray[tagId])
        side1Image.center = side1.center
        side1.addSubview(side1Image)
        side1.backgroundColor = colorArray[tagId]
        side1.tag = tagId
        allResutresntViews.append(side1)
        
        tagId = tagId + 1
        var side2 = UIView(frame: CGRect(x: viw.frame.width/2, y: 0, width: viw.frame.width/2, height: viw.frame.height))
        var side2Image = createImageView(x: 0, y: 0, width: (side2.frame.width/1.5), height: (side2.frame.height/1.5) , image:  imagesArray[tagId ])
        side2.addSubview(side2Image)
        side2Image.center = CGPoint(x: side1.center.x, y: side1.center.y - 20)
        side2.backgroundColor =  colorArray[tagId]
        side2.tag = tagId
        allResutresntViews.append(side2)
        
        
        // Add tap gesture recognizer to View
        var tap1                   = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        side1.addGestureRecognizer(tap1)
        side1.isUserInteractionEnabled = true
        
        tap1                   = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        side2.addGestureRecognizer(tap1)
        side2.isUserInteractionEnabled = true
        
        viw.addSubview(side1)
        viw.addSubview(side2)
        scrollViw.addSubview(viw)
        
        let count      = itemCount - 2
        let itemWidth  = view.frame.width
        let itemHeight = view.frame.height/5 + viw.frame.height * 2/3
        let itemY      = viw.frame.height * 2/3 + viwWeather.frame.height
        let leftY      = viw.frame.height * 1/3
        
        for index in 1...count {
            
            let calculateValue = ((itemHeight*2/3) * CGFloat(index - 1))
            
            let middleView              = MiddleView(frame: CGRect(x: 0, y:itemY + calculateValue  , width: itemWidth , height: itemHeight))
            middleView.leftTopPoint     = CGPoint(x: 0, y: leftY)
            middleView.rightTopPoint    = CGPoint(x: middleView.frame.width , y: 0)
            
            middleView.leftBottomPoint  = CGPoint(x: 0 , y: middleView.frame.height)
            middleView.rightBottomPoint = CGPoint(x: middleView.frame.width , y: middleView.frame.height*2/3 )
            
            tagId = tagId + 1
            middleView.color            = colorArray[tagId ]
            
            side1 = UIImageView(frame: CGRect(x: 0, y: 0, width: middleView.frame.width/2, height: middleView.frame.height))
            side1.backgroundColor = colorArray[tagId ]
            side1Image = createImageView(x: 0, y: 0, width: (side1.frame.width/2), height: (side1.frame.height/2), image:  imagesArray[tagId])
            
            side1Image.center = CGPoint(x: side1.center.x, y: side1.center.y + 10)
            
            side1.addSubview(side1Image)
            
            
            side1.tag = tagId
            
            tagId = tagId + 1
            
            side2 = UIImageView(frame: CGRect(x: middleView.frame.width/2, y: 0, width: middleView.frame.width/2, height: middleView.frame.height))
            side2.backgroundColor = colorArray [tagId ]
            side2Image = createImageView(x: 0, y: 0, width: (side2.frame.width/1.8), height: (side2.frame.height/1.8), image: imagesArray[tagId])
            side2Image.center = CGPoint(x: side1.center.x, y: side1.center.y - 30)
            side2.addSubview(side2Image)
            
            side2.tag = tagId
            
            // Add tap gesture recognizer to View
            tap1                   = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            side1.addGestureRecognizer(tap1)
            side1.isUserInteractionEnabled = true
            
            tap1                   = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            side2.addGestureRecognizer(tap1)
            side2.isUserInteractionEnabled = true
            
            middleView.addSubview(side1)
            middleView.addSubview(side2)
            
            scrollViw.addSubview(middleView)
            
        }
        
        
        let calculateValue = ((itemHeight*2/3) * CGFloat(itemCount - 2))
        
        let bottomView              = BottomView(frame: CGRect(x: 0, y:itemY + calculateValue , width: itemWidth , height: itemHeight - 40 ))
        bottomView.leftTopPoint     = CGPoint(x: 0, y: leftY)
        bottomView.rightTopPoint    = CGPoint(x: bottomView.frame.width , y: 0)
        bottomView.leftBottomPoint  = CGPoint(x: 0 , y: bottomView.frame.height + self.view.frame.height*1/3)
        bottomView.rightBottomPoint = CGPoint(x: bottomView.frame.width , y: bottomView.frame.height)
        
        
        side1 = UIImageView(frame: CGRect(x: 0, y: 0, width: bottomView.frame.width/2, height: bottomView.frame.height))
        tagId = tagId + 1
        side1Image = createImageView(x: 0, y: 0, width: (side1.frame.width/1.5), height: (side1.frame.height/1.5) , image:  imagesArray[tagId])
        side1Image.center = side1.center
        side1.addSubview(side1Image)
        side1.backgroundColor = colorArray[tagId]
        
        side1.tag = tagId
        
        side2 = UIImageView(frame: CGRect(x: bottomView.frame.width/2, y: 0, width: bottomView.frame.width/2, height: bottomView.frame.height))
        tagId = tagId + 1
        side2Image = createImageView(x: 0, y: 0, width: (side2.frame.width/1.5), height: (side2.frame.height/1.5), image:  imagesArray[tagId])
        side2.addSubview(side2Image)
        side2Image.center = side1Image.center
        side2.backgroundColor = colorArray[tagId]
        side2.tag = tagId
        
        // Add tap gesture recognizer to View
        tap1                   = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        side1.addGestureRecognizer(tap1)
        side1.isUserInteractionEnabled = true
        
        tap1                   = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        side2.addGestureRecognizer(tap1)
        side2.isUserInteractionEnabled = true
        
        bottomView.addSubview(side1)
        bottomView.addSubview(side2)
        
        scrollViw.addSubview(bottomView)
    }
    
    @objc func handleSideBarGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            
            self.leadingConstrianSidebar.constant = 0
            self.isSidebarOpen = true
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            
            
            if self.isSidebarOpen {
                self.leadingConstrianSidebar.constant = -1500
                UIView.animate(withDuration: 0.5) {
                    self.view.layoutIfNeeded()
                }
                self.isSidebarOpen = false
            }
        }
    }
    
    @objc func handleTap(_ recognizer:UITapGestureRecognizer) {
        
        self.selectedImage = (recognizer.view)!
        
        if (Constant.RETURENT_LOCAL_DATA[selectedImage.tag].id > 0) {
            self.performSegue(withIdentifier: "menu", sender: nil)
        }
        
    }
    
    @objc func handleEditProfiletTap(_ recognizer:UITapGestureRecognizer) {

        self.performSegue(withIdentifier: "edit", sender: nil)
        
    }
    
    @objc func handleSearchTap(_ recognizer:UITapGestureRecognizer) {
        
        self.txtSearch.resignFirstResponder()
        self.tralingConstrianSearch.constant = -1500
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func handleOfferViewTap(_ recognizer:UITapGestureRecognizer) {
        
       self.performSegue(withIdentifier: "offer", sender: nil)
        
    }
    
    func createImageView(x: CGFloat , y: CGFloat , width: CGFloat, height: CGFloat, image: UIImage) -> UIImageView {
        
        let imageView = UIImageView(frame: CGRect(x: x, y: y, width: width, height: height))
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        
        return imageView
        
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
}

extension ResturentSelectionVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.profileDetailsArry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell            = tableView.dequeueReusableCell(withIdentifier: "data", for: indexPath) as! ProfileTC
        cell.lblHeader.text = profileDetailsArry[indexPath.row]
        cell.lblValue.text  = profileValueArry[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
}

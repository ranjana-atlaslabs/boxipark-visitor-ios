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
    
    //Mark Varialbles
    var itemCount     = 5
    var tagId         = 0
    let colorArray    = [#colorLiteral(red: 0.9520129561, green: 0.9357979894, blue: 0.893722713, alpha: 1), #colorLiteral(red: 0.7740916014, green: 0.3885799944, blue: 0.2412629426, alpha: 1), #colorLiteral(red: 0.9653725028, green: 0.835703373, blue: 0.556709826, alpha: 1), #colorLiteral(red: 0.7598508, green: 0.2347533405, blue: 0.190864265, alpha: 1), #colorLiteral(red: 0.2463579476, green: 0.3117541969, blue: 0.3831449151, alpha: 1), #colorLiteral(red: 0.9520129561, green: 0.9357979894, blue: 0.893722713, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.4114020467, green: 0.6439546347, blue: 0.5185563564, alpha: 1),#colorLiteral(red: 0.133510083, green: 0.1185990497, blue: 0.1235295162, alpha: 1), #colorLiteral(red: 0.1140215024, green: 0.3539430797, blue: 0.4238928854, alpha: 1)]
    let imagesArray   = [ #imageLiteral(resourceName: "barnonalogon"), #imageLiteral(resourceName: "canoli_logo"), #imageLiteral(resourceName: "lacajitalogon"), #imageLiteral(resourceName: "barxilogon"), #imageLiteral(resourceName: "hopslogon"), #imageLiteral(resourceName: "grilllogon"), #imageLiteral(resourceName: "clawlogon"), #imageLiteral(resourceName: "naughtylogon"), #imageLiteral(resourceName: "barxilogon"), #imageLiteral(resourceName: "beforelogon")]
    var isSidebarOpen = false
    var selectedImage = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupview()
    }
    
    //Mark: @IBAction
    @IBAction func sidebarBtnTap(_ sender: Any) {
        
        self.leadingConstrianSidebar.constant = 0
        self.isSidebarOpen = true
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "menu" {
            if let vc = segue.destination as? MenuVC {
                vc.color = selectedImage.backgroundColor!
            }
        }
    }
    
    //Mark: Custome Methods
    func setupview()  {
        self.btnOffer.layer.cornerRadius       = 8
        self.btnLogout.layer.cornerRadius      = 8
        self.tblProfileData.tableFooterView    = UIView()
        self.tblProfileData.rowHeight          = UITableView.automaticDimension
        self.setupScrollView()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        
        
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    func setupScrollView()  {
        
        
        self.scrollViw.contentSize = CGSize(width:self.view.frame.width, height:((view.frame.height/4) * CGFloat(itemCount - 1)))
        self.scrollViw.layoutIfNeeded()
        
        let viw = TopView(frame: CGRect(x: 0, y: 0, width: view.frame.width , height: view.frame.height/4))
        
        var side1 = UIView(frame: CGRect(x: 0, y: 0, width: viw.frame.width/2, height: viw.frame.height))
        var side1Image = createImageView(x: 0, y: 0, width: (side1.frame.width/1.5), height: (side1.frame.height/1.5), image:  imagesArray[tagId ])
        
        side1Image.center = side1.center
        
        side1.addSubview(side1Image)
        side1.backgroundColor = colorArray[tagId ]
        side1.tag = tagId
        
        tagId = tagId + 1
        var side2 = UIView(frame: CGRect(x: viw.frame.width/2, y: 0, width: viw.frame.width/2, height: viw.frame.height))
        var side2Image = createImageView(x: 0, y: 0, width: (side2.frame.width/1.5), height: (side2.frame.height/1.5), image:  imagesArray[tagId ])
        side2.addSubview(side2Image)
        side2Image.center = side1Image.center
        side2.backgroundColor =  colorArray[tagId]
        side2.tag = tagId
        
        
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
        let itemHeight = view.frame.height/5 + viw.frame.height * 1/3
        let itemY      = viw.frame.height * 2/3
        let leftY      = viw.frame.height * 1/3
        
        for index in 1...count {
            
            print(tagId)
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
           
            side1Image.center = side1.center
            
            side1.addSubview(side1Image)

            
            side1.tag = tagId
            
            tagId = tagId + 1
            
            side2 = UIImageView(frame: CGRect(x: middleView.frame.width/2, y: 0, width: middleView.frame.width/2, height: middleView.frame.height))
            side2.backgroundColor = colorArray [tagId ]
            side2Image = createImageView(x: 0, y: 0, width: (side2.frame.width/2), height: (side2.frame.height/2), image: imagesArray[tagId])
            
            side2Image.center = side1Image.center
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
        
        let bottomView              = BottomView(frame: CGRect(x: 0, y:itemY + calculateValue , width: itemWidth , height: itemHeight ))
        bottomView.leftTopPoint     = CGPoint(x: 0, y: leftY)
        bottomView.rightTopPoint    = CGPoint(x: bottomView.frame.width , y: 0)
        bottomView.leftBottomPoint  = CGPoint(x: 0 , y: bottomView.frame.height + self.view.frame.height*1/3)
        bottomView.rightBottomPoint = CGPoint(x: bottomView.frame.width , y: bottomView.frame.height)
        
        
        side1 = UIImageView(frame: CGRect(x: 0, y: 0, width: bottomView.frame.width/2, height: bottomView.frame.height))
        tagId = tagId + 1
        side1.backgroundColor = colorArray[tagId]
        
        side1.tag = tagId
        
        side2 = UIImageView(frame: CGRect(x: bottomView.frame.width/2, y: 0, width: bottomView.frame.width/2, height: bottomView.frame.height))
        tagId = tagId + 1
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
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            
            self.leadingConstrianSidebar.constant = 0
            self.isSidebarOpen = true
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
            
            //print("Swipe Right")
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            
            
            if self.isSidebarOpen {
                self.leadingConstrianSidebar.constant = -1500
                UIView.animate(withDuration: 0.3) {
                    self.view.layoutIfNeeded()
                }
                self.isSidebarOpen = false
            }
        }
    }

    @objc func handleTap(_ recognizer:UITapGestureRecognizer) {
        
        self.selectedImage = (recognizer.view)!
        
        self.performSegue(withIdentifier: "menu", sender: nil)
        
    }
    
    func createImageView(x: CGFloat , y: CGFloat , width: CGFloat, height: CGFloat, image: UIImage) -> UIImageView {
        
        let imageView = UIImageView(frame: CGRect(x: x, y: y, width: width, height: height))
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        
        return imageView
        
    }
}

extension ResturentSelectionVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell            = tableView.dequeueReusableCell(withIdentifier: "data", for: indexPath) as! ProfileTC
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }

}
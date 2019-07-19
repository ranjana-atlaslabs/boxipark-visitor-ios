//
//  ScrollViewSetup.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 7/17/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import Foundation
import UIKit

extension ResturentSelectionVC {
    
    func setupview()  {
        
        getUserInformation()
        
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
    
    //break into common methods
    func setupScrollView()  {
        
        //assigning resturent ids from api
        Constant.RETURENT_LOCAL_DATA.forEach { (resturent) in
            
            if self.menuApiData.data.menus.contains(where: {$0.name == resturent.name}) {
                resturent.id = self.menuApiData.data.menus.first(where: {$0.name == resturent.name})?.id
                
            }
        }
        
        //set scrollView size
        self.scrollViw.contentSize = CGSize(width:self.view.frame.width, height:((view.frame.height/4) * CGFloat(itemCount)) + 60 + viwWeather.frame.height)
        
        //draw top scroll view - left
        let viw = TopView(frame: CGRect(x: 0, y: viwWeather.frame.height , width: view.frame.width , height: view.frame.height/4 + 40))
        
        var side1 = UIView(frame: CGRect(x: 0, y: 0, width: viw.frame.width/2, height: viw.frame.height))
        var side1Image = createImageView(x: 0, y: 0, width: (side1.frame.width/1.5), height: (side1.frame.height/1.5), image:  imagesArray[tagId])
        side1Image.center = side1.center
        side1.addSubview(side1Image)
        side1.backgroundColor = colorArray[tagId]
        side1.tag = tagId
        allResutresntViews.append(side1)
        
        //draw top scroll view - right
        tagId = tagId + 1
        var side2 = UIView(frame: CGRect(x: viw.frame.width/2, y: 0, width: viw.frame.width/2, height: viw.frame.height))
        var side2Image = createImageView(x: 0, y: 0, width: (side2.frame.width/1.5), height: (side2.frame.height/1.5) , image:  imagesArray[tagId])
        side2.addSubview(side2Image)
        side2Image.center = CGPoint(x: side1.center.x, y: side1.center.y - 20)
        side2.backgroundColor =  colorArray[tagId]
        side2.tag = tagId
        allResutresntViews.append(side2)
        
        
        // Add tap gesture recognizer to top left view
        var tap1                   = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        side1.addGestureRecognizer(tap1)
        side1.isUserInteractionEnabled = true
        
        // Add tap gesture recognizer to top right view
        tap1                   = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        side2.addGestureRecognizer(tap1)
        side2.isUserInteractionEnabled = true
        
        viw.addSubview(side1)
        viw.addSubview(side2)
        scrollViw.addSubview(viw)
        
        //draw middle views
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
    
    func createView() -> UIView {
        
        let viw = UIView()
        
        side1 = UIImageView(frame: CGRect(x: 0, y: 0, width: middleView.frame.width/2, height: middleView.frame.height))
        side1.backgroundColor = colorArray[tagId ]
        side1Image = createImageView(x: 0, y: 0, width: (side1.frame.width/2), height: (side1.frame.height/2), image:  imagesArray[tagId])
        
        side1Image.center = CGPoint(x: side1.center.x, y: side1.center.y + 10)
        
        side1.addSubview(side1Image)
        
        return viw
    }
}

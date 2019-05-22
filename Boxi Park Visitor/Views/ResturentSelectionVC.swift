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
    
    //Mark Varialbles
    var itemCount = 10
    var tagId     = 1
    let colorArray = [UIColor.gray, UIColor.black, UIColor.blue, UIColor.brown, UIColor.magenta, UIColor.yellow, UIColor.cyan, UIColor.white]
    let imagesArray = [ #imageLiteral(resourceName: "cano_logo"), #imageLiteral(resourceName: "lacajitalogon"), #imageLiteral(resourceName: "beforelogon"), #imageLiteral(resourceName: "hopslogon"), #imageLiteral(resourceName: "barxilogon"), #imageLiteral(resourceName: "grilllogon"), #imageLiteral(resourceName: "naughtylogon"), #imageLiteral(resourceName: "beforelogon")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupview()
    }
    
    
    func setupview()  {
        self.btnOffer.layer.cornerRadius = 8
        self.setupScrollView()
    }
    
    func setupScrollView()  {
        
        self.scrollViw.contentSize = CGSize(width:self.view.frame.width, height:((view.frame.height/4) * CGFloat(itemCount - 2)))
        self.scrollViw.layoutIfNeeded()
        
        let colorArray2: [UIColor] = colorArray.reversed()
        let imagesArray2: [UIImage] = imagesArray.reversed()
        
    
        let viw = TopView(frame: CGRect(x: 0, y: 0, width: view.frame.width , height: view.frame.height/4))
        
        var side1 = UIView(frame: CGRect(x: 0, y: 0, width: viw.frame.width/2, height: viw.frame.height))
        var side1Image = createImageView(x: 0, y: 0, width: Int(side1.frame.width/1.5), height: Int(side1.frame.height/1.5), image:  #imageLiteral(resourceName: "canolilogon"))
        side1Image.center = side1.center
        side1.addSubview(side1Image)
        side1.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        side1.tag = tagId
        
        var side2 = UIView(frame: CGRect(x: viw.frame.width/2, y: 0, width: viw.frame.width/2, height: viw.frame.height))
        var side2Image = createImageView(x: 0, y: 0, width: Int(side2.frame.width/2), height: Int(side2.frame.height/2), image: #imageLiteral(resourceName: "cano_logo"))
        side2Image.center = side2.center
        side2.addSubview(side2Image)
        side2.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        
        tagId = tagId + 1
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
            
            let calculateValue = ((itemHeight*2/3) * CGFloat(index - 1))
            
            let middleView              = MiddleView(frame: CGRect(x: 0, y:itemY + calculateValue  , width: itemWidth , height: itemHeight))
            middleView.leftTopPoint     = CGPoint(x: 0, y: leftY)
            middleView.rightTopPoint    = CGPoint(x: middleView.frame.width , y: 0)
            
            middleView.leftBottomPoint  = CGPoint(x: 0 , y: middleView.frame.height)
            middleView.rightBottomPoint = CGPoint(x: middleView.frame.width , y: middleView.frame.height*2/3 )
            
            middleView.color            = colorArray[index - 1]
            
            side1 = UIImageView(frame: CGRect(x: 0, y: 0, width: middleView.frame.width/2, height: middleView.frame.height))
            side1.backgroundColor = colorArray[index - 1]
            //side1.image = imagesArray[index - 1]
            side1.contentMode = .scaleAspectFit
            
            tagId = tagId + 1
            side1.tag = tagId
            
            side2 = UIImageView(frame: CGRect(x: middleView.frame.width/2, y: 0, width: middleView.frame.width/2, height: middleView.frame.height))
            side2.backgroundColor = colorArray2 [index - 1]
           // side2.image = imagesArray2[index - 1]
            side2.contentMode = .scaleAspectFit
            tagId = tagId + 1
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
        
        bottomView.color = colorArray[colorArray.count - 1]
        
        side1 = UIImageView(frame: CGRect(x: 0, y: 0, width: bottomView.frame.width/2, height: bottomView.frame.height))
        
        side1.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        tagId = tagId + 1
        side1.tag = tagId
        
        side2 = UIImageView(frame: CGRect(x: bottomView.frame.width/2, y: 0, width: bottomView.frame.width/2, height: bottomView.frame.height))
        side2.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        tagId = tagId + 1
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


    
    @objc func handleTap(_ recognizer:UITapGestureRecognizer) {
        
        print(recognizer.view?.tag ?? 0)
        
    }
    
    func createImageView(x: Int , y: Int , width: Int, height: Int, image: UIImage) -> UIImageView {
        
        let imageView = UIImageView(frame: CGRect(x: x, y: y, width: width, height: height))
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        
        return imageView
        
    }
}

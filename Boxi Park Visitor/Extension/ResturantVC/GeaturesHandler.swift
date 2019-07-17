//
//  GeaturesHandler.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 7/17/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import Foundation
import UIKit

extension ResturentSelectionVC {
    
    
    //Mark: Custome Methods
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
    
}

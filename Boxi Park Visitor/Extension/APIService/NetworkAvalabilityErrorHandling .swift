//
//  NetworkAvalabilityErrorHandling .swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 7/8/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import Foundation
import UIKit

extension ResturentSelectionVC {
    
    func updateUserInterface() {

        self.resetView()
        
        switch Network.reachability.status {
            
        case .unreachable:
           
            view.setNeedsLayout()
            
        case .wwan:

            view.setNeedsLayout()
            
        case .wifi:

            view.setNeedsLayout()
        }
        
        print("Reachability Summary")
        print("Status:", Network.reachability.status)
        print("HostName:", Network.reachability.hostname ?? "nil")
        print("Reachable:", Network.reachability.isReachable)
        print("Wifi:", Network.reachability.isReachableViaWiFi)
    }
    
    @objc func statusManager(_ notification: Notification) {
        
        updateUserInterface()
    }
    
    func resetView()  {
        self.scrollViw.subviews.forEach ({
            
            if $0.tag > -1 {
                $0.removeFromSuperview()
            }
            
        })
        
        self.isPageLoad = true
        self.tagId = 0
    }
}

//
//  SideBar.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 7/17/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import Foundation
import UIKit

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

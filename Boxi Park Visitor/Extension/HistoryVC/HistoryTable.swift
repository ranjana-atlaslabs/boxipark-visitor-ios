//
//  HistoryTable.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 7/23/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import Foundation
import UIKit

extension HistroyVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count = 0
        
        if isLoyaltyPoints {
            count = self.histroyTrasactionPoints.count
        }else {
            count = self.histroyTrasactionRewards.count
        }
        
        if count == 0 {
            
            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "No records found"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            return 0
        }
        
        tableView.backgroundView = nil
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "history", for: indexPath) as! HistoryCell
        
        
        if isLoyaltyPoints {
            let trasaction_item = histroyTrasactionPoints[indexPath.row]
            cell.lblPoint.text = trasaction_item.point
            cell.lblPoint.textColor = trasaction_item.lableColor
            cell.lblResturentName.text = trasaction_item.storeName ?? ""
            cell.lblTransactionId.text = "Transaction ID : \(trasaction_item.transactionId ?? 0)"
            
            let dateStr = trasaction_item.datetime
            let date = Utility.stringToDate(date: dateStr!, formaterType: "yyyy-mm-dd HH:mm:ss")
            let new_date = Utility.dateToString(date: date, formaterType: "dd.mm.yyyy 'at' HH:mm a.").lowercased()
            cell.lblDateTime.text      = new_date
            
        }else {
            let trasaction_item = histroyTrasactionRewards[indexPath.row]
            cell.lblPoint.text = trasaction_item.reward
            cell.lblPoint.textColor = trasaction_item.lableColor
            cell.lblResturentName.text = trasaction_item.storeName ?? ""
            cell.lblTransactionId.text = "Transaction ID : \(trasaction_item.transactionId ?? 0)"
            
            let dateStr = trasaction_item.datetime
            let date = Utility.stringToDate(date: dateStr!, formaterType: "yyyy-mm-dd HH:mm:ss")
            let new_date = Utility.dateToString(date: date, formaterType: "dd.mm.yyyy 'at' HH:mm a.").lowercased()
            cell.lblDateTime.text      = new_date
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
}

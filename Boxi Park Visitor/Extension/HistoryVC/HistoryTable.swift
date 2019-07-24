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
        
        if histroyTrasaction == nil ||  histroyTrasaction.count == 0 {
            
            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "No records found"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
            
            return 0
        }
        
        tableView.backgroundView = nil
        return historyData.transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "history", for: indexPath) as! HistoryCell
        
        let trasaction_item = histroyTrasaction[indexPath.row]
        
        var accrued  = 0.0
        var redeemed = 0.0
        
        if let value = Double(trasaction_item.accrued) {
            accrued = value
        } else {
            print("Not a valid number: \(0)")
        }
        
        if let value = Double(trasaction_item.redeemed) {
            redeemed = value
            
        } else {
            print("Not a valid number: \(0)")
        }
        
        if accrued > 0 {
            cell.lblPoint.text = "+\(accrued) Points"
            cell.lblPoint.textColor = #colorLiteral(red: 0.4322328568, green: 0.6876894832, blue: 0.7780260444, alpha: 1)
        }else {
            cell.lblPoint.text = "-\(redeemed) Points"
            cell.lblPoint.textColor = #colorLiteral(red: 0.9212740064, green: 0.3939920068, blue: 0.2965783179, alpha: 1)
        }
        
        cell.lblResturentName.text = trasaction_item.storeName ?? ""
        cell.lblTransactionId.text = "Transaction ID : \(trasaction_item.transactionId ?? 0)"
        cell.lblDateTime.text      = trasaction_item.datetime
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
}

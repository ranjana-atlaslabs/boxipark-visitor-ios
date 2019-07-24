//
//  HistroyVC.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 7/23/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import UIKit

class HistroyVC: UIViewController {

    @IBOutlet weak var tblHistroy: UITableView!
    @IBOutlet weak var lblPoints: UILabel!
    
    var historyData: TransationResult!
    var histroyTrasaction: [TransactionTable]!
    var points = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
    }
    
    func setupView()  {
        
        tblHistroy.tableFooterView = UIView()
        lblPoints.text = points
        getTransactionHistory()
    }
    
    @IBAction func backBtnTap(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Get History Data
    
    func getTransactionHistory()  {
        
        
        HistroyAPI.getTransactionHistroy() { result, error , status in
            
            if status == 200 && result != nil {
                
                self.historyData = result
                
                self.historyData.transactions.forEach({ (transaction) in
                    
                    if transaction.details != nil && transaction.details.count > 0 {
                        
                        transaction.details.forEach({ (trans) in
                            
                            let tableItem = TransactionTable(storeName: transaction.storeName, accrued: trans.accrued, balance: trans.balance, redeemed: trans.redeemed, walletCode: trans.walletCode, datetime: transaction.datetime, transactionId: transaction.transactionId)
                            self.histroyTrasaction.append(tableItem)
                        })
                    }
                })
            }
        }
    }
    
}

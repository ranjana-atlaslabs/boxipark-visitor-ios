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
                print(result)
            }
            
        }
    }
    
}

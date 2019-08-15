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
    @IBOutlet weak var viwLoyaltyBottomBorder: UIView!
    @IBOutlet weak var viwRewardsBottomBorder: UIView!
    @IBOutlet weak var lblTopic: UILabel!
    @IBOutlet weak var lblPointCount: UILabel!
    @IBOutlet weak var lblPointExpireDate: UILabel!
    
    var historyData: TransationResult!
    var histroyTrasaction = [TransactionTable]()
    
    var histroyTrasactionPoints = [TransactionTablePoint]()
    var histroyTrasactionRewards = [TransactionTableReward]()
    
    var points = String()
    var rewardBalances = [RewardBalances]()
    
    var isLoyaltyPoints = true {
        
        didSet {
            changeStyle(isShowLoyalty: isLoyaltyPoints)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
    }
    
    func setupView()  {
        
        tblHistroy.tableFooterView = UIView()
        isLoyaltyPoints = true
        getTransactionHistory()
    }
    
    @IBAction func backBtnTap(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loyaltyPointsBtnTap(_ sender: UIButton) {
        isLoyaltyPoints = true
        tblHistroy.reloadData()
    }
    
    @IBAction func rewardsBtnTap(_ sender: UIButton) {
        isLoyaltyPoints = false
        tblHistroy.reloadData()
        
    }
    
    
    func changeStyle(isShowLoyalty:Bool)  {
        
        if isShowLoyalty {
            viwLoyaltyBottomBorder.backgroundColor = #colorLiteral(red: 0.9961006045, green: 0.3934076726, blue: 0.3241223693, alpha: 1)
            viwRewardsBottomBorder.backgroundColor = UIColor.clear
            lblTopic.text = "Loyalty Points"
            lblPoints.text = points
            lblPointCount.text = ""
            lblPointExpireDate.text = ""
        }else {
            viwLoyaltyBottomBorder.backgroundColor = UIColor.clear
            viwRewardsBottomBorder.backgroundColor = #colorLiteral(red: 0.9961006045, green: 0.3934076726, blue: 0.3241223693, alpha: 1)
            lblTopic.text = "Rewards"
            lblPoints.text = ""
            
            
            var totla_rewards = 0.0
            self.rewardBalances.forEach { (reward) in
                
                var nameArr = reward.name.components(separatedBy: " ")
                var word    = nameArr[0]
                _ = word.remove(at: word.startIndex)
                
                if let value = Double(word) {
                    totla_rewards += (Double(reward.balance)! * value)
                }

            }
            
            if self.rewardBalances.count > 1 {
                let count_25Dollrs = self.rewardBalances[0].balance
                let count_20Dollrs = (self.rewardBalances[1].balance) ?? ""
                
                let text  = "$25x\(count_25Dollrs ?? "")  $20x\(count_20Dollrs)"
                let range_1 = (text as NSString).range(of: "$25")
                let range_2 = (text as NSString).range(of: "$20")
                
                let attributedString = NSMutableAttributedString(string:text)
                attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: #colorLiteral(red: 0.9961006045, green: 0.3934076726, blue: 0.3241223693, alpha: 1) , range: range_1)
                attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: #colorLiteral(red: 0.9961006045, green: 0.3934076726, blue: 0.3241223693, alpha: 1) , range: range_2)
                
                lblPointCount.attributedText = attributedString
                
            }else if self.rewardBalances.count > 0 {
                
                var nameArr = self.rewardBalances[0].name.components(separatedBy: " ")
                let count_Dollrs = self.rewardBalances[0].balance
                
                let text  = "\(nameArr[0])x\(count_Dollrs ?? "")"
                let range_1 = (text as NSString).range(of: "\(nameArr[0])")
                
                let attributedString = NSMutableAttributedString(string:text)
                attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: #colorLiteral(red: 0.9961006045, green: 0.3934076726, blue: 0.3241223693, alpha: 1) , range: range_1)
                
                lblPointCount.attributedText = attributedString   
            }
            
            lblPoints.text = "$\(Int(totla_rewards))"
            
        }
    }
    
    //MARK: Get History Data
    
    func getTransactionHistory()  {
        
        self.histroyTrasaction.removeAll()
        
        HistroyAPI.getTransactionHistroy() { result, error , status in
            
            if status == 200 && result != nil {
                
                self.historyData = result
                
                self.historyData.transactions.forEach({ (transaction) in
                    
                    if transaction.details != nil && transaction.details.count > 0 {
                        
                        transaction.details.forEach({ (trans) in
                            
                            let walet_code = trans.walletCode
                            
                            if let walet_item = self.historyData.walletInfo.first(where: {$0.walletCode == walet_code}) {
                                
                                let name = walet_item.name.lowercased()
                                
                                if name.contains("points") {
                                    //it's point item
                                    
                                    if let value = Double(trans.accrued) {
                                        
                                        if value > 0 {
                                            
                                            
                                            let point = TransactionTablePoint(storeName: transaction.storeName, point: "+\(value) Points", datetime: transaction.datetime, transactionId: transaction.transactionId, lableColor: #colorLiteral(red: 0.4322328568, green: 0.6876894832, blue: 0.7780260444, alpha: 1))
                                            self.histroyTrasactionPoints.append(point)
                                        }
                                    }
                                    
                                    if let value = Double(trans.redeemed) {
                                        
                                        if value < 0 {
                                            let point = TransactionTablePoint(storeName: transaction.storeName, point: "\(value) Points", datetime: transaction.datetime, transactionId: transaction.transactionId, lableColor: #colorLiteral(red: 0.9212740064, green: 0.3939920068, blue: 0.2965783179, alpha: 1))
                                            
                                            self.histroyTrasactionPoints.append(point)
                                        }
                                    }
                                    
                                }else {
                                    //it's redeem item
                                    let nameArr = name.components(separatedBy: " ")
                                    
                                    if let value = Double(trans.accrued) {
                                        
                                        if value > 0 {
                                            
                                            let reward = TransactionTableReward(storeName: transaction.storeName, reward: "+\(Int(value)) X \(nameArr[0])", datetime: transaction.datetime, transactionId: transaction.transactionId, lableColor: #colorLiteral(red: 0.4322328568, green: 0.6876894832, blue: 0.7780260444, alpha: 1))
                                            self.histroyTrasactionRewards.append(reward)
                                        }
                                        
                                    }
                                    
                                    if let value = Double(trans.redeemed) {
                                        
                                        if value < 0 {
                                            let reward = TransactionTableReward(storeName: transaction.storeName, reward: "\(Int(value)) X \(nameArr[0])", datetime: transaction.datetime, transactionId: transaction.transactionId, lableColor: #colorLiteral(red: 0.9212740064, green: 0.3939920068, blue: 0.2965783179, alpha: 1))
                                            
                                            self.histroyTrasactionRewards.append(reward)
                                        }
                                    }
                                }
                            }
                        })
                    }
                })
                self.tblHistroy.reloadData()
            }
        }
    }
}

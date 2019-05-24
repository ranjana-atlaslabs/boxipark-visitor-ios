//
//  MenuVC.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 5/22/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import UIKit
import FittedSheets


class MenuVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tblMenuItems: UITableView!
    
    var color = UIColor()
    var image = UIImage()
    let sections: [String] = ["Cocktails", "Wine on Tap", "Bottled Wine", "Park Brewing \n Rotating Selections", "Canned Beer", "Beverages", "Cocktails"]
    
    let s1Data: [String] = ["Seasonal Sangria", "Smoked Manhattan", "1Ginger"]
    let s2Data: [String] = ["Seasonal Sangria", "Smoked Manhattan", "2Ginger"]
    let s3Data: [String] = ["Seasonal Sangria", "Smoked Manhattan", "3Ginger"]
    let s4Data: [String] = ["Seasonal Sangria", "Smoked Manhattan", "4Ginger"]
    let s5Data: [String] = ["Seasonal Sangria", "Smoked Manhattan", "5Ginger"]
    let s6Data: [String] = ["Seasonal Sangria", "Smoked Manhattan", "6Ginger"]
    let s7Data: [String] = ["Seasonal Sangria", "Smoked Manhattan", "7Ginger"]
    
    let price: [String] = ["6.00", "8.00", "9.00"]
    
    var sectionData: [Int: [String]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.setupview()
        
    }
    
    func setupview()  {
        imageView.backgroundColor = color
        imageView.image  = image
        imageView.contentMode = .scaleAspectFit
        
        imageView.layer.cornerRadius = 10
        
        tblMenuItems.separatorColor = UIColor.clear
        sectionData = [0: s1Data, 1:s2Data, 2: s3Data, 3:s4Data, 4: s5Data , 5:s6Data, 6: s7Data , 7: s7Data]
        tblMenuItems.tableFooterView = UIView()

    }
    
    func showBottomSheet()  {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "bottomSheet") as! BottomVC
        
        let sheetController = SheetViewController(controller: controller, sizes: [.fixed((self.view.frame.height) * 2/3  + 100)])
        
        // Adjust how the bottom safe area is handled on iPhone X screens
        sheetController.blurBottomSafeArea = false
        sheetController.adjustForBottomSafeArea = true
        
        
        // Make corners more round
        sheetController.topCornersRadius = 30
        
        // Disable the dismiss on background tap functionality
        sheetController.dismissOnBackgroundTap = false
        
        
        // Change the handle color
        sheetController.handleColor = UIColor.lightGray
        
        self.present(sheetController, animated: false, completion: nil)
    }
    
    @IBAction func backBtnTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count 
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (sectionData[section]?.count)!
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        let headerText = UILabel()
        headerText.frame = CGRect(x: 20, y: 0, width: tableView.frame.width, height: 50)
        headerText.text = sections[section]
        headerText.font = UIFont.boldSystemFont(ofSize: 20)
        view.addSubview(headerText)
        
        return view
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath) as! MenuItem
        
        cell.lblItemName.text = sectionData[indexPath.section]![indexPath.row]
        cell.lblItemPrice.text = "$    " + price[indexPath.row]
        cell.selectionStyle = .none
        
        let bottomBorder = CALayer()
        
        bottomBorder.frame = CGRect(x: 20.0, y: 43.0, width: cell.contentView.frame.size.width - 40, height: 1.0)
        bottomBorder.backgroundColor = UIColor(white: 0.8, alpha: 1.0).cgColor
        cell.contentView.layer.addSublayer(bottomBorder)

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        DispatchQueue.main.async {
            self.showBottomSheet()
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }

}


//
//  MenuTable.swift
//  Boxi Park Visitor
//
//  Created by Atlas-Labs on 7/18/19.
//  Copyright © 2019 Atlas-Labs. All rights reserved.
//

import Foundation
import UIKit

extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        
        if let resturent_section = resutrentMenu.sections {
            
            return resturent_section.count
        }
        
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return 50
        case .pad:
            return 65
            
        case .unspecified:
            return 65
        case .tv:
            return 65
        case .carPlay:
            return 65
        @unknown default:
            return 65
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let resturent_section_data = resutrentMenu.sections {
            
            var subHeaderCount = 0
            
            if !resturent_section_data[section].description.isEmpty &&  resturent_section_data[section].description != "" {
                subHeaderCount += 1
            }
            
            return (resturent_section_data[section].items.count + subHeaderCount)
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        let headerText = UILabel()
        headerText.sizeToFit()
        headerText.numberOfLines = 2
        headerText.frame = CGRect(x: 20, y: 0, width: tableView.frame.width, height: 50)
        
        if let resturent_section = resutrentMenu.sections {
            headerText.text = resturent_section[section].name
        }
        
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            headerText.font = UIFont(name: "Gotham-Bold", size: 20)
        case .pad:
            headerText.font = UIFont(name: "Gotham-Bold", size: 35)
            
        case .unspecified:
            break
        case .tv:
            break
        case .carPlay:
            break
        @unknown default:
            break
        }
        
        
        headerText.adjustsFontSizeToFitWidth = true
        headerText.minimumScaleFactor = 0.5
        
        view.addSubview(headerText)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if let resturent_section_data = resutrentMenu.sections {
            
            let resturentItem = resturent_section_data[indexPath.section]
            
            if indexPath.row == 0 && !resturentItem.description.isEmpty &&  resturentItem.description != ""{
                
                let header_cell = tableView.dequeueReusableCell(withIdentifier: "subHeader", for: indexPath) as! SubHeader
                
                
                header_cell.lblSubHeader.text = resturentItem.description.capitalizingFirstLetter()
                header_cell.lblSubHeader.setLineHeight(lineHeight: 1.3)
                cell = header_cell
                
            }else {
                let item_cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath) as! MenuItem
                let item = resturentItem.items[indexPath.row - headersArray[indexPath.section]]
                item_cell.lblItemName.set(image: #imageLiteral(resourceName: "info"), with: item.name)
                
                if item.choices.count > 0 {
                    if let price =  item.choices[0].prices.min {
                        switch price {
                        case .double(let num):
                            
                            item_cell.lblItemPrice.text =  String(format: "$ %.2f", num)
                            break
                        case .int(_):
                            break
                            
                        case .string(_):
                            break
                        }
                    }
                }
                
                cell = item_cell
                
                let bottomBorder = CALayer()
                
                bottomBorder.frame = CGRect(x: 20.0, y: 43.0, width: cell.contentView.frame.size.width - 40, height: 1.0)
                bottomBorder.backgroundColor = UIColor(white: 0.8, alpha: 1.0).cgColor
                cell.contentView.layer.addSublayer(bottomBorder)
            }
            
            
        }
        
        
        
        cell.selectionStyle = .none
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let resturent_section_data = resutrentMenu.sections {
            
            
            let resturentItem = resturent_section_data[indexPath.section]
            
            guard let _ = tblMenuItems.cellForRow(at: indexPath) as? MenuItem else {return}
            
            if resturentItem.description != "" {
                self.selectedItem = resturentItem.items[indexPath.row - 1]
            }else {
                self.selectedItem = resturentItem.items[indexPath.row ]
            }
            
        }
        DispatchQueue.main.async {
            self.showBottomSheet()
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return UITableView.automaticDimension + 55
        case .pad:
            return UITableView.automaticDimension + 55
            
        case .unspecified:
            return 65
        case .tv:
            return 65
        case .carPlay:
            return 65
        @unknown default:
            return 65
        }
        
        
        
    }
    
}

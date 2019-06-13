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
    @IBOutlet weak var scrollViw: UIScrollView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var viwContent: UIView!
    
    var color = UIColor()
    var image = UIImage()
    var resutrentMenu: Restaurant!
    var selectedItem: Item!
    var headersArray = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupview()
    }
    
    func setupview()  {
 
        imageView.backgroundColor = color
        imageView.image  = image
        imageView.contentMode = .scaleAspectFit
        
        imageView.layer.cornerRadius = 12
        
        tblMenuItems.separatorColor = UIColor.clear
        tblMenuItems.tableFooterView = UIView()
        
        resutrentMenu.sections.forEach { (sec) in
            
            if sec.description != "" {
                headersArray.append(1)
            }else {
                headersArray.append(0)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
     
        DispatchQueue.main.async {
            var contentRect = CGRect.zero
            
            for view in self.scrollViw.subviews {
                contentRect = contentRect.union(view.frame)
            }
            
            //set scrollView size
            self.scrollViw.contentSize = CGSize(width:self.view.frame.width, height: self.tblMenuItems.contentSize.height + self.topView.frame.height )
        }
    }
    
    func showBottomSheet()  {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "bottomSheet") as! BottomVC
        
        //Bind Data
        if let select_item = self.selectedItem {
            
            if select_item.choices.count > 0 {
                if let price =  select_item.choices[0].prices.min {
                    switch price {
                    case .double(let num):
                        
                        controller.price =  String(format: "$ %.2f", num)
                        break
                    case .int(_):
                        break
                        
                    case .string(_):
                        break
                    }
                }
            }
            
            if selectedItem.description != "" {
                controller.itemDescription = selectedItem.description
            }else{
                controller.itemDescription = selectedItem.name
            }
            
            controller.itemName = selectedItem.name
            
            
        }
        
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

extension UILabel {
    func set(image: UIImage, with text: String) {
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
        let attachmentStr = NSAttributedString(attachment: attachment)
        
        let mutableAttributedString = NSMutableAttributedString()
        
        let textString = NSAttributedString(string: text + "  ", attributes: [.font: self.font!])
        mutableAttributedString.append(textString)
        
        
        mutableAttributedString.append(attachmentStr)
        
        self.attributedText = mutableAttributedString
    }
    
    func setLineHeight(lineHeight: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.0
        paragraphStyle.lineHeightMultiple = lineHeight
        paragraphStyle.alignment = self.textAlignment
        
        let attrString = NSMutableAttributedString()
        if (self.attributedText != nil) {
            attrString.append( self.attributedText!)
        } else {
            attrString.append( NSMutableAttributedString(string: self.text!))
            attrString.addAttribute(NSAttributedString.Key.font, value: self.font ?? UIFont(name: "Gotham-Bold", size: 16) , range: NSMakeRange(0, attrString.length))
        }
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        self.attributedText = attrString
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}


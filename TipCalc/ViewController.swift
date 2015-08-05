//
//  ViewController.swift
//  TipCalc
//
//  Created by Dave Vo on 8/4/15.
//  Copyright © 2015 Chau Vo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    let lightTextColor = UIColor(red: 33/255, green: 94/255, blue: 33/255, alpha: 1.0)
    let lightHeaderColor = UIColor(red: 240/255, green: 255/255, blue: 240/255, alpha: 1.0)
    let lightFooterColor = UIColor(red: 204/255, green: 255/255, blue: 204/255, alpha: 1.0)
    
    let darkTextColor = UIColor.whiteColor()
    let darkHeaderColor = UIColor(red: 84/255, green: 139/255, blue: 84/255, alpha: 1.0)
    let darkFooterColor = UIColor(red: 0/255, green: 79/255, blue: 0/255, alpha: 1.0)
    
    let fmt = NSNumberFormatter()
    
    
//    defaults.setObject("#215E21", forKey: "lightTextColor")
//    defaults.setObject("#F0FFF0", forKey: "lightHeaderColor")
//    defaults.setObject("#CCFFCC", forKey: "lightFooterColor")
//    
//    defaults.setObject("#FFFFFF", forKey: "darkTextColor")
//    defaults.setObject("#548B54", forKey: "darkHeaderColor")
//    defaults.setObject("#004F00", forKey: "darkFooterColor")
    
    @IBOutlet var viewHome: UIView!
    
    @IBOutlet weak var txtAmount: UITextField!
    
    @IBOutlet weak var amountSeg: UISegmentedControl!

    @IBOutlet weak var viewTip: UIView!
    
    @IBOutlet weak var lblTip: UILabel!
    
    @IBOutlet weak var lblTotal: UILabel!
    
    @IBOutlet weak var lbl1p: UILabel!
    
    @IBOutlet weak var lbl2p: UILabel!
    
    @IBOutlet weak var lbl3p: UILabel!
    
    @IBOutlet weak var lbl4p: UILabel!
    
    @IBOutlet weak var lblPlus: UILabel!
    
    @IBOutlet weak var lblEqual: UILabel!
    
    
    
    @IBOutlet weak var img1: UIImageView!
    
    @IBOutlet weak var img2: UIImageView!
    
    @IBOutlet weak var img3: UIImageView!
    
    @IBOutlet weak var img4: UIImageView!
    
    @IBOutlet weak var img5: UIImageView!
    
    @IBOutlet weak var img6: UIImageView!
    
    @IBOutlet weak var img7: UIImageView!
    
    @IBOutlet weak var img8: UIImageView!
    
    @IBOutlet weak var img9: UIImageView!
    
    @IBOutlet weak var img10: UIImageView!
    
    var percent: Int = 0
    var tip: Double = 0
    var total: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        txtAmount.keyboardType = UIKeyboardType.DecimalPad
        
        fmt.numberStyle = .DecimalStyle
        fmt.groupingSeparator = ","
        
        viewTip.hidden = true
        
        self.view.userInteractionEnabled = true
        
        updateSetting()
        checkRemember()
        
        if txtAmount.text == "$" {
            //txtAmount.becomeFirstResponder()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        txtAmount.resignFirstResponder()
    }
    
    func checkRemember(){
        if let lastAccess = defaults.objectForKey("lastAccess") as! NSDate? {
            let elapsedTime = NSDate().timeIntervalSinceDate(lastAccess)
            let duration = Int(elapsedTime)
            if duration < 600 {
                if let lastAmount = defaults.objectForKey("lastAmount") as! String? {
                    if lastAmount != "$" {
                        txtAmount.text = lastAmount
                        
                        let lastSegIndex = defaults.integerForKey("lastSelectedSegIndex")
                        amountSeg.selectedSegmentIndex = lastSegIndex
                        switch lastSegIndex {
                        case 0:
                            percent = 10
                        case 1:
                            percent = 15
                        case 2:
                            percent = 20
                        default:
                            break
                        }
                        
                        updateValue()
                        viewTip.hidden = false
                        
                    }
                }
            }
        }
    }
    
    func updateSetting() {
        setColor()
        
        var defaultAmount = defaults.integerForKey("defaultAmount")
        if defaultAmount == 0 {
            defaultAmount = 20
        }
        percent = defaultAmount
        switch defaultAmount {
        case 10:
            amountSeg.selectedSegmentIndex = 0
        case 15:
            amountSeg.selectedSegmentIndex = 1
        case 20:
            amountSeg.selectedSegmentIndex = 2
        default:
            break
        }
        defaults.setInteger(amountSeg.selectedSegmentIndex, forKey: "lastSelectedSegIndex")
    }
    
    func setColor(){
        var theme = defaults.objectForKey("theme") as! String!
        if theme == nil {
            theme = "light"
        }
        if theme == "light" {
            viewHome.backgroundColor = lightHeaderColor
            viewTip.backgroundColor = lightFooterColor
            txtAmount.textColor = lightTextColor
            amountSeg.tintColor = lightTextColor
            lblPlus.textColor = lightTextColor
            lblTip.textColor = lightTextColor
            lblEqual.textColor = lightTextColor
            lblTotal.textColor = lightTextColor
            lbl1p.textColor = lightTextColor
            lbl2p.textColor = lightTextColor
            lbl3p.textColor = lightTextColor
            lbl4p.textColor = lightTextColor
            setImg("People")
        } else {
            viewHome.backgroundColor = darkHeaderColor
            viewTip.backgroundColor = darkFooterColor
            txtAmount.textColor = darkTextColor
            amountSeg.tintColor = darkTextColor
            lblPlus.textColor = UIColor.whiteColor()
            lblTip.textColor = darkTextColor
            lblEqual.textColor = darkTextColor
            lblTotal.textColor = darkTextColor
            lbl1p.textColor = darkTextColor
            lbl2p.textColor = darkTextColor
            lbl3p.textColor = darkTextColor
            lbl4p.textColor = darkTextColor
            setImg("PeopleWhite")
        }
    }
    
    func setImg(imgName: String){
        img1.image = UIImage(named: imgName)
        img2.image = UIImage(named: imgName)
        img3.image = UIImage(named: imgName)
        img4.image = UIImage(named: imgName)
        img5.image = UIImage(named: imgName)
        img6.image = UIImage(named: imgName)
        img7.image = UIImage(named: imgName)
        img8.image = UIImage(named: imgName)
        img9.image = UIImage(named: imgName)
        img10.image = UIImage(named: imgName)
    }
    
    @IBAction func amountChanged(sender: UITextField) {
        // Why this not working
//        if let iAmout: Int? = Int(txtAmount.text!) {
//            let iTip = Double(iAmout!) * Double(percent) / 100
//            lblTip.text =  "\(iTip)"
//        }
        
        if txtAmount.text == "" {
            txtAmount.text = "$"
            viewTip.hidden = true
        } else {
            if txtAmount.text?.characters.first == "$" {
                if let sAmount : String? = txtAmount.text {
                    txtAmount.text = String(dropFirst(sAmount!.characters))
                }
                viewTip.hidden = false
            }
        }
        
        updateValue()
        let lastAccess = NSDate()
        defaults.setObject(lastAccess, forKey: "lastAccess")
        defaults.setObject(txtAmount.text, forKey: "lastAmount")
        
    }
    
    
    @IBAction func percentChanged(sender: UISegmentedControl) {
        switch amountSeg.selectedSegmentIndex {
        case 0:
            percent = 10
        case 1:
            percent = 15
        case 2:
            percent = 20
        default:
            break
        }
        updateValue()
        defaults.setInteger(amountSeg.selectedSegmentIndex, forKey: "lastSelectedSegIndex")
    }
    
    func updateValue(){
        if let iAmout = NSNumberFormatter().numberFromString(txtAmount.text!) {
            tip = Double(iAmout) * Double(percent) / 100
            lblTip.text = "$" + fmt.stringFromNumber(tip)!
            total = Double(iAmout) + tip
            lblTotal.text = "$" + fmt.stringFromNumber(total)!
            
            lbl1p.text = "$" + (NSString(format: "%.2f", total) as String)
            lbl2p.text = "$" + (NSString(format: "%.2f", total / 2) as String)
            lbl3p.text = "$" + (NSString(format: "%.2f", total / 3) as String)
            lbl4p.text = "$" + (NSString(format: "%.2f", total / 4) as String)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "segueSettings":
                if let svc = segue.destinationViewController as? SettingsViewController {
                    if let ppc = svc.popoverPresentationController {
                        ppc.delegate = self
                    }
                    
                }
            default: break
            }
        }
    }
    
    func popoverPresentationControllerDidDismissPopover(popoverPresentationController: UIPopoverPresentationController) {
        
        updateSetting()
        updateValue()
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    
    

}


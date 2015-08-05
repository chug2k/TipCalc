//
//  SettingsViewController.swift
//  TipCalc
//
//  Created by Dave Vo on 8/4/15.
//  Copyright © 2015 Chau Vo. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var defaultAmountSeg: UISegmentedControl!
    
    @IBOutlet weak var darkThemeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var defaultAmount = defaults.integerForKey("defaultAmount") 
        if defaultAmount == 0 {
            defaultAmount = 20
        }
        
        switch defaultAmount {
        case 10:
            defaultAmountSeg.selectedSegmentIndex = 0
        case 15:
            defaultAmountSeg.selectedSegmentIndex = 1
        case 20:
            defaultAmountSeg.selectedSegmentIndex = 2
        default:
            break
        }
        var theme = defaults.objectForKey("theme") as! String!
        if theme == nil {
            theme = "light"
        }
        if theme == "light" {
            darkThemeSwitch.setOn(false, animated: true)
        } else {
            darkThemeSwitch.setOn(true, animated: true)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredContentSize: CGSize {
        get {
            return CGSizeMake(300, 150)
        }
        set { super.preferredContentSize = newValue }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch defaultAmountSeg.selectedSegmentIndex {
        case 0:
            defaults.setInteger(10, forKey: "defaultAmount")
        case 1:
            defaults.setInteger(15, forKey: "defaultAmount")
        case 2:
            defaults.setInteger(20, forKey: "defaultAmount")
        default:
            break
        }
        defaults.synchronize()
    }
    
    @IBAction func switchChanged(sender: UISwitch) {
        if darkThemeSwitch.on {
            defaults.setObject("dark", forKey: "theme")
        } else {
            defaults.setObject("light", forKey: "theme")
        }
    }
    

}

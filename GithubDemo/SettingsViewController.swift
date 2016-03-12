//
//  SettingsViewController.swift
//  
//
//  Created by Jay Liew on 3/1/16.
//
//

import UIKit

class SettingsViewController: UITableViewController {

    // MARK: Outlets
    
    @IBOutlet weak var sliderLabel: UILabel!
    @IBOutlet weak var starSlider: UISlider!
    
    @IBOutlet weak var languageFilterSwitch: UISwitch!
    @IBOutlet weak var pythonSwitch: UISwitch!
    @IBOutlet weak var djangoSwitch: UISwitch!
    @IBOutlet weak var swiftSwitch: UISwitch!
    @IBOutlet weak var javascriptSwitch: UISwitch!
    
    @IBOutlet weak var pythonViewCell: UIView!
    @IBOutlet weak var djangoViewCell: UIView!
    @IBOutlet weak var swiftViewCell: UIView!
    @IBOutlet weak var javascriptViewCell: UIView!
    
    // MARK: Properties
    
    var currentPrefs: Preferences!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentPrefs = currentPrefs ?? Preferences()
        
        starSlider.value = Float(currentPrefs.minStarRating)
        sliderValueChanged(self.starSlider)
        
        languageFilterSwitch.on = currentPrefs.languageFilter
        
        pythonSwitch.on = currentPrefs.languages["python"]!
        djangoSwitch.on = currentPrefs.languages["django"]!
        javascriptSwitch.on = currentPrefs.languages["javascript"]!
        swiftSwitch.on = currentPrefs.languages["swift"]!
        
        if !languageFilterSwitch.on {
            pythonViewCell.hidden = true
            djangoViewCell.hidden = true
            swiftViewCell.hidden = true
            javascriptViewCell.hidden = true
        }else{
            pythonViewCell.hidden = false
            djangoViewCell.hidden = false
            swiftViewCell.hidden = false
            javascriptViewCell.hidden = false
        }
        
    }
    
    func preferencesFromTableData() -> Preferences{
        let newPrefs = Preferences()
        newPrefs.minStarRating = Int(starSlider.value)
        newPrefs.languageFilter = self.languageFilterSwitch.on
        newPrefs.languages["django"] = djangoSwitch.on
        newPrefs.languages["javascript"] = javascriptSwitch.on
        newPrefs.languages["python"] = pythonSwitch.on
        newPrefs.languages["swift"] = swiftSwitch.on
        
        return newPrefs
    }
    
    // MARK: Actions
    
    @IBAction func switchValueChanged(sender: UISwitch) {
        if !languageFilterSwitch.on {
            pythonViewCell.hidden = true
            djangoViewCell.hidden = true
            swiftViewCell.hidden = true
            javascriptViewCell.hidden = true
        }else{
            pythonViewCell.hidden = false
            djangoViewCell.hidden = false
            swiftViewCell.hidden = false
            javascriptViewCell.hidden = false
        }
    }
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        let currentValue = Int(sender.value)
        sliderLabel.text = String(currentValue)
    }
    
    @IBAction func cancelToReposResultsViewController(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

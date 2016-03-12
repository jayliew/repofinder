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
    
    // MARK: Properties
    
    var currentPrefs: Preferences!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentPrefs = currentPrefs ?? Preferences()
        
        starSlider.value = Float(currentPrefs.minStarRating)
        languageFilterSwitch.on = currentPrefs.languageFilter
        sliderValueChanged(self.starSlider)
    }

    func preferencesFromTableData() -> Preferences{
        let newPrefs = Preferences()
        newPrefs.minStarRating = Int(starSlider.value)
        newPrefs.languageFilter = self.languageFilterSwitch.on
        return newPrefs
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

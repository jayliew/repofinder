//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD

class Preferences {
    var minStarRating = 4
    var languageFilter = true
    var languages: Dictionary<String, Bool> = [
        "python": true,
        "javascript": true,
        "django": true,
        "swift": true
    ]
    
}

// Main ViewController
class RepoResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: Outlets

    @IBOutlet weak var reposTableView: UITableView!

    // MARK: Properties
    
    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()
    var repos: [GithubRepo]!
    var preferences: Preferences = Preferences()

    override func viewDidLoad() {
        super.viewDidLoad()

        reposTableView.dataSource = self
        reposTableView.delegate = self
        reposTableView.estimatedRowHeight = 400
        reposTableView.rowHeight = UITableViewAutomaticDimension
        
        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self

        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar

        // Perform the first search when the view controller first loads
        doSearch()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "settingsSegue" {
            let navController = segue.destinationViewController as! UINavigationController
            let settingsVC = navController.topViewController as! SettingsViewController
            settingsVC.currentPrefs = self.preferences
        }
    }
    
    // MARK: Actions
    
    @IBAction func didSaveSettings(segue: UIStoryboardSegue){
        if let settingsVC = segue.sourceViewController as? SettingsViewController{
            self.preferences = settingsVC.preferencesFromTableData()
        }
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let repos = self.repos {
            return repos.count
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("com.jayliew.ReposViewCell", forIndexPath: indexPath) as! ReposViewCell
        let repo = self.repos[indexPath.row]
        
        cell.avatarImageView.setImageWithURL(NSURL(string: repo.ownerAvatarURL!)!)
        cell.nameLabel.text = repo.name
        cell.nameLabel.sizeToFit()
        
        cell.descriptionLabel.text = repo.repoDescription
        cell.ownerLabel.text = repo.ownerHandle
        cell.forksLabel.text = String(repo.forks!)
        cell.starsLabel.text = String(repo.stars!)
        
        return cell
    }

    // Perform the search.
    private func doSearch() {

        MBProgressHUD.showHUDAddedTo(self.view, animated: true)

        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in

            self.repos = [GithubRepo]()
            
            // Print the returned repositories to the output window
            for repo in newRepos {
                print(repo)
                self.repos.append(repo)
            }   

            self.reposTableView.reloadData()
            
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            }, error: { (error) -> Void in
                print(error)
        })
    }
}

// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true;
    }

    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true;
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
}
//
//  SearchResultsTableViewController.swift
//  iOSiTuneSearch
//
//  Created by Lambda_School_Loaner_201 on 11/2/19.
//  Copyright © 2019 Christian Lorenzo. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    let searchResultsController = SearchResultController()
    
    @IBOutlet weak var segementedControlOutlet: UISegmentedControl!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self

        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print (searchResultsController.search.count)
        return searchResultsController.search.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultsCell", for: indexPath)

        // Configure the cell...
        
        let result = searchResultsController.search[indexPath.row]
        cell.textLabel?.text = result.creator
        cell.detailTextLabel?.text = result.title

        return cell
    }
    

}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else {return}
        var resultType: ResultType!
        
        switch segementedControlOutlet.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            return resultType = nil
        }
        
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

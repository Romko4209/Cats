//
//  BreedsViewController.swift
//  Cats
//
//  Created by Romko on 25.09.2020.
//  Copyright © 2020 Romko. All rights reserved.
//

import UIKit

class BreedsViewController: UIViewController {

    // MARK:- UI objects
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private let searchController = UISearchController(searchResultsController: nil)

    
    // MARK:- NetworkManager
    private var networkManager = NetworkCatsManager()

    // MARK:- class fields
    private var breedsCat = [Breed]()
    var filteredBreed = [Breed]()
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {
            return false
        }
        return text.isEmpty
    }
    private var isFiltering:Bool{
        return searchController.isActive && !searchBarIsEmpty
    }
    
    
    
    // MARK:- Override viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        setupTableView()
        fetchData()
        setupSearchController()
    }
    
    // MARK:- setup Search Controller
    fileprivate func setupSearchController(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search breed"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    // MARK:- method Setup TableView
    fileprivate func setupTableView(){
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    // MARK:- method fetch data (breeds cats)
    fileprivate func fetchData(){
        networkManager.onCompletionBreeds = { breeds in
            self.breedsCat = breeds
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        networkManager.fetchBreeds()
    }
    
    // MARK:- Segue to DetailVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let dest = segue.destination as? DetailCatViewController{
            
            var breed: Breed?
            
            if isFiltering {
                guard let index = tableView.indexPathForSelectedRow else {return}
                breed = filteredBreed[index.row]
            } else if segue.identifier == "randomToDetail"{
                
                if breedsCat.count > 0{
                breed = breedsCat[Int.random(in: 0..<breedsCat.count)]
                }
                
            } else {
                guard let index = tableView.indexPathForSelectedRow else {return}
                breed = breedsCat[index.row]
            }
            dest.cat = breed
            
        }
    }
    
}

// MARK:- Extension tableView
extension BreedsViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           if isFiltering {
               return filteredBreed.count
           }
           return breedsCat.count
       }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var breed: Breed
        if isFiltering{
            breed = filteredBreed[indexPath.row]
        } else {
            breed = breedsCat[indexPath.row]
        }
        
        let breedCatName = breed.name
        cell.textLabel?.text = breedCatName
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "breedToDetailController", sender: nil)
    }
}
// MARK:- extension UiSearch
extension BreedsViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String){
        filteredBreed = breedsCat.filter({ (breed: Breed) -> Bool in
            
            return (breed.name?.lowercased().contains(searchText.lowercased()))!
        })
        
        tableView.reloadData()
    }
}

    


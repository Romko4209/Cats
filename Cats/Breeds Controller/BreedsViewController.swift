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

    // MARK:- NetworkManager
    private var networkManager = NetworkCatsManager()
    
    // MARK:- class fields
    private var breedsCat = [Breed]()
    
    // MARK:- Override viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        setupTableView()
        fetchData()
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
    
}

// MARK:- Extension tableView
extension BreedsViewController: UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let breedCatName = breedsCat[indexPath.row].name
        cell.textLabel?.text = breedCatName
        return cell
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breedsCat.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
    
    


//
//  MainGamesViewController.swift
//  Cats
//
//  Created by Romko on 26.09.2020.
//  Copyright © 2020 Romko. All rights reserved.
//

import UIKit

class MainGamesViewController: UIViewController{

    // MARK:- UI objects
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        cv.backgroundColor = .systemBackground
        return cv
    }()
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // MARK:- Network Manager
    private var networkManager = NetworkCatsManager()
    
    // MARK:- class fields
    private let games = Games.games
    private var breeds = [Breed]()
    private var questionCount = 3
       
    // MARK:- Override viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.center = self.view.center
        activityIndicator.style = UIActivityIndicatorView.Style.large
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        setupCollectionView()
        fetchDataBreedsCats()
        
    }
    
    // MARK:- Setup collection view
    fileprivate func setupCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
           
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
           
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        navigationController?.navigationBar.prefersLargeTitles = true
           
        collectionView.isHidden = true
       }
    
    // MARK:- fetch data
    private func fetchDataBreedsCats(){
        networkManager.onCompletionBreeds = { breeds in
            self.breeds = breeds
            DispatchQueue.main.async {
                self.collectionView.isHidden = false
                self.activityIndicator.stopAnimating()
            }
        }
        
        networkManager.fetchBreeds()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        switch segue.identifier {
        case "QuizGameSegue":
            if let dest = segue.destination as? QuizViewController{
                dest.listBreeds = breeds
                dest.questionCount = questionCount
            }
        default:
            return
        }
    }
    
}

extension MainGamesViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate{
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GalleryCollectionViewCell
        let image = games[indexPath.row].photoGames
        cell.imageView.image = image

        return cell
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: collectionView.frame.height/3.5)
     }
     
    // MARK:- selected games
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let game = games[indexPath.row]
        switch game.photoGames{
        case #imageLiteral(resourceName: "cat-quiz"):
            let ac = UIAlertController(title: "Choose level", message: nil, preferredStyle: .actionSheet)
                     
                     ac.addAction(UIAlertAction(title: "Simple", style: .default, handler: { action in
                         self.questionCount = 3
                        self.performSegue(withIdentifier: game.segueIdentifieGames, sender: nil)
                     }))
                     ac.addAction(UIAlertAction(title: "Medium", style: .default, handler: { action in
                         self.questionCount = 6
                         self.performSegue(withIdentifier: game.segueIdentifieGames, sender: nil)
                     }))
                     ac.addAction(UIAlertAction(title: "Hard", style: .default, handler: { action in
                         self.questionCount = 9
                         self.performSegue(withIdentifier: game.segueIdentifieGames, sender: nil)
                     }))
                     ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                     present(ac,animated: true)
            performSegue(withIdentifier: game.segueIdentifieGames, sender: nil)
        default:
            return
        }
     }
}


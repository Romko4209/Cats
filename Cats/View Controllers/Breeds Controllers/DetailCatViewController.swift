//
//  DetailCatViewController.swift
//  Cats
//
//  Created by Romko on 26.09.2020.
//  Copyright © 2020 Romko. All rights reserved.
//

import UIKit

class DetailCatViewController: UIViewController {

    // MARK:- UI objects
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private let galleryView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 58
        return stack
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        label.font = UIFont(name: "American Typewriter", size: 25)
        label.textColor = .systemIndigo
        label.numberOfLines = 0
        return label
    }()
    
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Description"
        label.font = UIFont(name: "American Typewriter", size: 25)
        label.textColor = .systemOrange
        label.numberOfLines = 0
        return label
    }()
    
    private let temperamentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Temperament"
        label.font = UIFont(name: "American Typewriter", size: 25)
        label.textColor = .systemIndigo
        label.numberOfLines = 0
        return label
    }()
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Country"
        label.font = UIFont(name: "American Typewriter", size: 25)
        label.textColor = .systemOrange
        label.numberOfLines = 0
        return label
    }()
    
    private let weightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Weight"
        label.font = UIFont(name: "American Typewriter", size: 25)
        label.textColor = .systemIndigo
        label.numberOfLines = 0
        return label
    }()
    
    private let avarageLifeSpanLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Avarage Life Span"
        label.font = UIFont(name: "American Typewriter", size: 25)
        label.textColor = .systemOrange
        return label
    }()
    
    private let wikipediaButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont(name: "American Typewriter", size: 25)
        button.titleLabel?.textColor = .systemIndigo
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.setTitle(" Wikipedia ", for: .normal)
        button.backgroundColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var galleryCollectionView = GalleryCollectionView()
    
    // MARK:- NetworkManager
    var networkManager = NetworkCatsManager()
    
    // MARK:- class fields
    var cat: Breed?
    var imagesURL = [ImageCat]()
    
    // MARK:- Override viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupGalleryView()
        setupStackView()
        isHidenLabels(varBool: true)
        setupInformation()
        setupGallery()
        loadImages()
    }
    
    // MARK:- method setupScrollView
    fileprivate func setupScrollView(){
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
    
    // MARK:- method setupGalleryView
    fileprivate func setupGalleryView(){
        scrollView.addSubview(galleryView)
  
        galleryView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        galleryView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        galleryView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        galleryView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    // MARK:- method setupStackView
    fileprivate func setupStackView(){
        scrollView.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: galleryView.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(temperamentLabel)
        stackView.addArrangedSubview(countryLabel)
        stackView.addArrangedSubview(weightLabel)
        stackView.addArrangedSubview(avarageLifeSpanLabel)
        stackView.addArrangedSubview(wikipediaButton)
        let viewEmpty = UIView()
        stackView.addArrangedSubview(viewEmpty)
    }
    
    // MARK:- method setup information
    fileprivate func setupInformation(){
         guard let cat = cat else {return}
         nameLabel.text = cat.name
         descriptionLabel.text = cat.description
         temperamentLabel.text = cat.temperament
         countryLabel.text = cat.origin
         weightLabel.text = "\(cat.weight.metric ?? "None") kgs"
         avarageLifeSpanLabel.text = "\(cat.life_span ?? "None") average life span"
     }
   
    // MARK:- method setupGallery
    fileprivate func setupGallery(){
        galleryView.addSubview(galleryCollectionView)
                
        galleryCollectionView.leadingAnchor.constraint(equalTo: galleryView.leadingAnchor).isActive = true
        galleryCollectionView.trailingAnchor.constraint(equalTo: galleryView.trailingAnchor).isActive = true
        galleryCollectionView.centerYAnchor.constraint(equalTo: galleryView.centerYAnchor).isActive = true
        galleryCollectionView.heightAnchor.constraint(equalTo: galleryView.heightAnchor).isActive = true
     }
     
     // MARK:- method is hidden UI
     fileprivate func isHidenLabels(varBool:Bool){
         nameLabel.isHidden = varBool
         descriptionLabel.isHidden = varBool
         temperamentLabel.isHidden = varBool
         countryLabel.isHidden = varBool
         weightLabel.isHidden = varBool
         avarageLifeSpanLabel.isHidden = varBool
         galleryCollectionView.isHidden = varBool
         wikipediaButton.isHidden = varBool
     }
     
     // MARK:- request images
     fileprivate func loadImages(){
         
         networkManager.onCompletionImages = { images in
             self.imagesURL = images
             DispatchQueue.main.async {
                self.galleryCollectionView.setArrayWithCats(cells: self.imagesURL)
                 self.isHidenLabels(varBool: false)
                 self.galleryCollectionView.reloadData()
             }
         }
         networkManager.fetchImagesCats(cat: cat,limit: 4)
     }
}

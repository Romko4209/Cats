//
//  PhotosViewController.swift
//  Cats
//
//  Created by Romko on 26.09.2020.
//  Copyright © 2020 Romko. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    // MARK:- UI objects
    let buttonCat: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "cat"), for: .normal)
        return button
    }()
    
    let labelRandomCat: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Random photos cats"
        label.font = UIFont(name: "Chalkduster", size: 25)
        return label
    }()
    
    let labelTap: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Сlick on the\nphoto of the cat"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "Chalkduster", size: 25)
        return label
    }()
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // MARK:- NetworkManager
    var networkManager = NetworkCatsManager()
    
    // MARK:- class fields
    let limitDownloadImage = 10
    var photosURL = [ImageCat]()
    var indexImage = 0
    
    // MARK:- Override loadView
    override func loadView() {
        super.loadView()
     setupButtonAndLabels()
    }
    
    // MARK:- Override viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.center = self.view.center
        activityIndicator.style = UIActivityIndicatorView.Style.large
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        setupUI()
        
        
    }
    
    // MARK:- Override viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.labelTap.pulsateStartAnimation()
    }
    
    // MARK:- method setupUI components
    fileprivate func setupUI(){
        activityIndicator.startAnimating()
        view.backgroundColor = .systemBackground
        labelIsHidden(true)
        
        loadImages()
    }
    
    // MARK:- method hide UI
    fileprivate func labelIsHidden(_ bool: Bool){
        self.buttonCat.isHidden = bool
        self.labelRandomCat.isHidden = bool
        self.labelTap.isHidden = bool
    }
    
    // MARK:- method setupButtonAndLabels
    fileprivate func setupButtonAndLabels(){
        view.addSubview(buttonCat)
        view.addSubview(labelRandomCat)
        view.addSubview(labelTap)
        
        buttonCat.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonCat.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        buttonCat.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        buttonCat.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        buttonCat.addTarget(self, action: #selector(self.buttonCatTapped(sender:)), for: .touchUpInside)
        
        labelRandomCat.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        labelRandomCat.bottomAnchor.constraint(equalTo: buttonCat.topAnchor,constant: -50).isActive = true
        
        labelTap.topAnchor.constraint(equalTo: buttonCat.bottomAnchor,constant: 50).isActive = true
        labelTap.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    // MARK:- method buttonCatTapped
    @objc fileprivate func buttonCatTapped(sender: UIButton){
      labelTap.layer.removeAllAnimations()
        sender.rotate()
        sender.imageURL(imageURL: photosURL[indexImage].url,label: labelTap)
        
        indexImage += 1
        if indexImage == limitDownloadImage{
            indexImage = 0
            setupUI()
        }
    }
    // MARK:- request images
    fileprivate func loadImages(){
        
        networkManager.onCompletionImages = { images in
            self.photosURL = images
            
            DispatchQueue.main.async {
                self.labelIsHidden(false)
                self.labelTap.pulsateStartAnimation()
                self.activityIndicator.stopAnimating()
            }
        }
        networkManager.fetchImagesCats(cat: nil, limit: limitDownloadImage)
    }
}


//
//  DetailCatViewController.swift
//  Cats
//
//  Created by Romko on 26.09.2020.
//  Copyright © 2020 Romko. All rights reserved.
//

import UIKit

class DetailCatViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private let galleryView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
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
        return label
    }()
    
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Description"
        label.font = UIFont(name: "American Typewriter", size: 25)
        label.textColor = .systemOrange
        return label
    }()
    
    private let temperamentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Temperament"
        label.font = UIFont(name: "American Typewriter", size: 25)
        label.textColor = .systemIndigo
        return label
    }()
    
    private let countryLabel: UILabel = {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.text = "Country"
           label.font = UIFont(name: "American Typewriter", size: 25)
           label.textColor = .systemOrange
           return label
       }()
    
    private let weightLabel: UILabel = {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.text = "Weight"
           label.font = UIFont(name: "American Typewriter", size: 25)
           label.textColor = .systemIndigo
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
        setupGalleryView()
        setupStackView()
        
    }
    
    fileprivate func setupScrollView(){
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
  
    fileprivate func setupGalleryView(){
        scrollView.addSubview(galleryView)
  
        galleryView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        galleryView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        galleryView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        galleryView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        galleryView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
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
    }

    
}

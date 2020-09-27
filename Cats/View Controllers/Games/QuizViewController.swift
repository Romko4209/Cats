//
//  QuizViewController.swift
//  Cats
//
//  Created by Romko on 26.09.2020.
//  Copyright © 2020 Romko. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
 
    // MARK:- UI objects
    private var topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont(name: "American Typewriter", size: 25)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.setTitle("CONFIRM", for: .normal)
        button.isEnabled = false
        button.backgroundColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let exitButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "xmark")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var image = UIImageView()
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // MARK:- Network Manager
    var networkManager = NetworkCatsManager()
    
    // MARK:- class fields
    var buttons = [UIButton]()
    
    
    var listBreeds = [Breed]()
    
    var answer: String?
    
    var questionCount = 3
    var questionIndex = 0
    var correctAnswer = 0
    
    // MARK:- Override viewDidLoad
      override func viewDidLoad() {
          super.viewDidLoad()
        setupViews()
        setupVCForQuizOne()
        activityIndicator.style = UIActivityIndicatorView.Style.large
        image.addSubview(activityIndicator)
        activityIndicator.center = image.center
        updateUI()
          
      }
    
    // MARK:- method setup Views top and bottom views
    fileprivate func setupViews(){
        view.addSubview(topView)
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        view.addSubview(bottomView)
        bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        

    }
    
    // MARK:- method Update Ui
    fileprivate func updateUI(){
        for button in buttons{
            button.backgroundColor = .white
        }
        confirmButton.backgroundColor = .lightGray
        confirmButton.isEnabled = false
        
        let randomIndex = Int.random(in: 0..<listBreeds.count)
           
        
        loadImage(breed: listBreeds[randomIndex])

        answer = listBreeds[randomIndex].name
           
        var answerOptions = [answer]
           
        while answerOptions.count != 4 {
            let index = Int.random(in: 0..<listBreeds.count)
            if index != randomIndex {
                answerOptions.append(listBreeds[index].name)
            }
        }
        answerOptions.shuffle()
        
        for index in 0..<buttons.count{
            buttons[index].setTitle(answerOptions[index], for: .normal)
        }
    }
       
    // MARK:- setup VC for quiz
    fileprivate func setupVCForQuizOne(){
        let imageView: UIImageView = {
            let view = UIImageView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.contentMode = .scaleAspectFit
            return view
        }()
        image = imageView
        let stackView: UIStackView = {
            let stack = UIStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .vertical
            stack.spacing = CGFloat(8)
            return stack
        }()
        for _ in 0..<4{
            let button: UIButton = {
            let button = UIButton(type: .system)
            button.titleLabel?.font = UIFont(name: "American Typewriter", size: 20)
            button.layer.cornerRadius = 7
            button.layer.borderWidth = 1
            button.backgroundColor = .white
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            return button
            }()
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }
                   
        topView.addSubview(imageView)
        bottomView.addSubview(stackView)
        bottomView.addSubview(confirmButton)
        
        imageView.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: topView.widthAnchor, multiplier: 0.6).isActive = true
        imageView.widthAnchor.constraint(equalTo: topView.widthAnchor, multiplier: 0.7).isActive = true
        
        topView.addSubview(exitButton)
        exitButton.bottomAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        exitButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor,constant: -8).isActive = true
        exitButton.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.11).isActive = true
        exitButton.widthAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.11).isActive = true
        
        stackView.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: 0.9).isActive = true
           
        confirmButton.bottomAnchor.constraint(equalTo: bottomView.layoutMarginsGuide.bottomAnchor).isActive = true
        confirmButton.leadingAnchor.constraint(equalTo: bottomView.layoutMarginsGuide.leadingAnchor).isActive = true
        confirmButton.trailingAnchor.constraint(equalTo: bottomView.layoutMarginsGuide.trailingAnchor).isActive = true
       }
       
    // MARK:- request image
    fileprivate func loadImage(breed cat:Breed?){
        activityIndicator.startAnimating()
        networkManager.onCompletionImages = { images in
            guard let imageURL = images[0].url else {return}
            self.image.imageURL(imageURL: imageURL)
            DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
            }
        }
        networkManager.fetchImagesCats(cat: cat, limit: 1)
        
    }
    // MARK:- tap your answer
    @objc fileprivate func buttonTapped(_ sender: UIButton){
           for button in buttons{
               button.backgroundColor = .white
           }
           sender.backgroundColor = .gray
           confirmButton.backgroundColor = .green
           confirmButton.isEnabled = true
       }
        
    // MARK:- tapped confirm button
    @objc fileprivate func confirmButtonTapped(_ sender: UIButton){
        var text: String?
           
        for button in buttons {
            if button.backgroundColor == .gray{
            text = button.titleLabel?.text
            }
        }
        let ac = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Continue", style: .default) { [weak self] action in
        self?.questionIndex += 1
               
        if (self?.questionIndex)! < (self?.questionCount)!{
            self?.image.image = UIImage()
            self?.updateUI()
        } else {
            let resultAlert = UIAlertController(title: "Your Result \((self?.correctAnswer)!)/\((self?.questionCount)!).",
                message: "Start Over?" ,
                preferredStyle: .alert)
            
            let actionOk = UIAlertAction(title: "Yes", style: .default) { actionOk in
                       self?.updateUI()
                       self?.questionIndex = 0
                       self?.correctAnswer = 0
                   }
                   
            let actionExit = UIAlertAction(title: "Exit", style: .destructive) { actionExit in
                       self?.dismiss(animated: true, completion: nil)
                   }
                   resultAlert.addAction(actionOk)
                   resultAlert.addAction(actionExit)
                   self?.present(resultAlert,animated: true)
               }
           }
            ac.addAction(action)
          
           if text == answer{
               ac.title = "RIGHT!"
               if let bgView = ac.view.subviews.first, let groupView = bgView.subviews.first, let contentView = groupView.subviews.first {
                   contentView.backgroundColor = .green
                   correctAnswer += 1
               }
           } else {
                ac.title = "WRONG!"
               ac.message = "Right answer: \(answer!)"
               
                if let bgView = ac.view.subviews.first, let groupView = bgView.subviews.first, let contentView = groupView.subviews.first {
                    contentView.backgroundColor = .red
                }
           }
           present(ac,animated: true)
       }
    
    // MARK:- exit game
    @objc fileprivate func exitButtonTapped(){
        dismiss(animated: true, completion: nil)
    }
}


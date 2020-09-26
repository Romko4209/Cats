//
//  GalleryCollectionView.swift
//  Cats
//
//  Created by Romko on 27.09.2020.
//  Copyright © 2020 Romko. All rights reserved.
//

import Foundation
import UIKit

class GalleryCollectionView: UICollectionView, UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var imagesURL = [ImageCat]()
    var indicator: UIActivityIndicatorView?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame:.zero, collectionViewLayout: layout)
        backgroundColor = .systemBackground
        dataSource = self
        delegate = self
        
        register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        translatesAutoresizingMaskIntoConstraints = false
    
        isPagingEnabled = true
    }
    
    
    func setArrayWithCats(cells:[ImageCat]){
      imagesURL = cells
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesURL.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GalleryCollectionViewCell

        let imageCat = imagesURL[indexPath.row]
        cell.configure(with: imageCat)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height * 0.8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

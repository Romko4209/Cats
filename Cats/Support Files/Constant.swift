//
//  Constant.swift
//  Cats
//
//  Created by Romko on 25.09.2020.
//  Copyright © 2020 Romko. All rights reserved.
//

import Foundation

struct Constant {
    static let breedsURL = "https://api.thecatapi.com/v1/breeds"
    static let apiKey = "abc59e96-5dfa-4cb0-ab9b-ebad87379a79"
    
    static func getImageBreedURL (id:String? = nil, limit: Int = 1) -> String{
           if let id = id {
           return"https://api.thecatapi.com/v1/images/search?breed_ids=\(id)&limit=\(limit)"
           }else{
               return "https://api.thecatapi.com/v1/images/search?mime_types=jpg&limit=\(limit)"
           }
       }
}

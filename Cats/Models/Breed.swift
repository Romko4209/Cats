//
//  Breed.swift
//  Cats
//
//  Created by Romko on 25.09.2020.
//  Copyright © 2020 Romko. All rights reserved.
//

import Foundation

struct Breed: Decodable{
    let id: String?
    let name: String?
    let description: String?
    let temperament: String?
    let origin: String?
    let life_span: String?
    let wikipedia_url: String?
    let weight: Weight
 
}

struct Weight: Decodable{
    let metric: String?
}

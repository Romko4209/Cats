//
//  NetworkCatsManager.swift
//  Cats
//
//  Created by Romko on 25.09.2020.
//  Copyright © 2020 Romko. All rights reserved.
//

import Foundation

struct NetworkCatsManager{

    var onCompletionBreeds: (([Breed]) -> Void)?
    var onCompletionImages: (([ImageCat]) -> Void)?
    
     func fetchBreeds(){
         
         if let url = URL(string: Constant.breedsURL){
         var request = URLRequest(url: url)
             request.addValue(Constant.apiKey, forHTTPHeaderField: "x-api-key")
         request.httpMethod = "GET"
         
         URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
             print(error.localizedDescription)
             }
             
             if let data = data {
                 if let breeds = self.passeJSONCats(data: data){
                     self.onCompletionBreeds?(breeds)
                 }
             }
         }.resume()
         }
     }
     
     
    fileprivate func passeJSONCats(data: Data) -> [Breed]? {
         do{
             let breeds = try JSONDecoder().decode([Breed].self, from: data)
             return breeds
         }catch let error as NSError {
             print(error.localizedDescription)
         }
         return nil
     }
    
    func fetchImagesCats(cat: Breed?,limit: Int? = nil){
        
         var stringURL = Constant.getImageBreedURL()
         if let idCat = cat?.id, let limit = limit{
             stringURL = Constant.getImageBreedURL(id: idCat, limit: limit)
         }else{
         if let limit = limit {
             stringURL = Constant.getImageBreedURL(id: nil, limit: limit)
             }
         }
         if let url = URL(string: stringURL){
         var request = URLRequest(url: url)
             request.addValue(Constant.apiKey, forHTTPHeaderField: "x-api-key")
         request.httpMethod = "GET"
         
         URLSession.shared.dataTask(with: request) {(data, _, error) in
         if let error = error {
             print(error)
             }
             
             if let data = data {
                 if let imagesURL = self.passeJSONImages(data: data){
                     self.onCompletionImages?(imagesURL)
                 }
             }
             }.resume()
         }
         
     }
     
    fileprivate func passeJSONImages(data: Data) -> [ImageCat]? {
           do{
               let imagesURL = try JSONDecoder().decode([ImageCat].self, from: data)
               return imagesURL
           }catch let error as NSError {
               print(error.localizedDescription)
           }
           return nil
       }
     
     
}

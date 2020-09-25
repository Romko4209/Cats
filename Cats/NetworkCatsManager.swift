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
    
}

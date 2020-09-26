//
//  Game.swift
//  Cats
//
//  Created by Romko on 26.09.2020.
//  Copyright © 2020 Romko. All rights reserved.
//

import Foundation
import UIKit

struct Game {
    let photoGames: UIImage
    let segueIdentifieGames: String
    init(photoGames: UIImage, segueIdentifieGames: String) {
        self.photoGames = photoGames
        self.segueIdentifieGames = segueIdentifieGames
    }
}

struct Games {
    static let games = [Game(photoGames: #imageLiteral(resourceName: "cat-quiz"), segueIdentifieGames: "QuizGameSegue")]
}

//
//  Game.swift
//  Bullseye Game
//
//  Created by Jordan on 1/25/24.
//

import Foundation
import UIKit

struct Game {
    var target = Int.random(in: 1...100)
    var score = 0
    var round = 1
    
    typealias User = (name: String, highscore: Int)// target: Int)
    var leaderboard: Array<User> = []

    func points(sliderValue: Int) -> Int {
        //return 100 - Int(pow(Double(sliderValue - target), 2.0).squareRoot())
        let pointTotal: Int = 100 - abs(sliderValue - target)
        return pointTotal
    }
}

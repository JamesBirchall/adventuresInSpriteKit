//
//  GameplayController.swift
//  JackTheGiant
//
//  Created by James Birchall on 23/04/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import SpriteKit

class GameplayController {
    
    static let sharedInstance = GameplayController()  // only one instance of this class to be available
    private init() { }  // cannot create an object from this class
    
    var scoreText: SKLabelNode?
    var coinText: SKLabelNode?
    var lifeText: SKLabelNode?
    
    var score: Int?
    var coinScore: Int?
    var lifeScore: Int?
    
    func initialiseVariables() {
        if GameManager.sharedInstance.gameStartedFromMainMenu {
            
            GameManager.sharedInstance.gameStartedFromMainMenu = false // reset
            
            score = 0
            coinScore = 0
            lifeScore = 2
            
            scoreText?.text = "\(score!)"
            coinText?.text = "x\(coinScore!)"
            lifeText?.text = "x\(lifeScore!)"
        } else if GameManager.sharedInstance.gameRestartedPlayerDied {
            
            GameManager.sharedInstance.gameRestartedPlayerDied = false
            
            scoreText?.text = "\(score!)"
            coinText?.text = "x\(coinScore!)"
            lifeText?.text = "x\(lifeScore!)"
        }
    }
}

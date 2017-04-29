//
//  HighscoreScene.swift
//  JackTheGiant
//
//  Created by James Birchall on 18/04/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import SpriteKit

class HighscoreScene: SKScene {
    
    private enum Scenes {
        case mainMenu
    }
    
    private var backButton: SKSpriteNode?
    private var highScore: SKLabelNode?
    private var coinScore: SKLabelNode?
    private var difficultyLabel: SKLabelNode?
    
    override func didMove(to view: SKView) {
        print("Highscore Shown")
        
//        if let node1 = self.childNode(withName: "HighscoreLabel") as? SKLabelNode {
//            node1.fontName = "blow"
//        }
        
//        for family: String in UIFont.familyNames
//        {
//            print("\(family)")
//            for names: String in UIFont.fontNames(forFamilyName: family)
//            {
//                print("== \(names)")
//            }
//        }
        
//        let font = UIFont(name: "Blow", size: 48)
//        if let node1 = self.childNode(withName: "HighscoreLabel") as? SKLabelNode {
//            node1.fontName = font?.fontName
//            node1.fontSize = (font?.pointSize)!
//        }
        
        backButton = self.childNode(withName: "BackButton") as? SKSpriteNode
        highScore = self.childNode(withName: "HighscoreLabel") as? SKLabelNode
        coinScore = self.childNode(withName: "CoinLabel") as? SKLabelNode
        difficultyLabel = self.childNode(withName: "DifficultyLabel") as? SKLabelNode
        
        // set depending on difficulty relevent scores
        
        if GameManager.sharedInstance.getEasyDifficulty() {
            highScore?.text = "\(GameManager.sharedInstance.getEasyDifficultyScore())"
            coinScore?.text = "\(GameManager.sharedInstance.getEasyDifficultyCoinScore())"
            
            // print("Game Score: \(highScore!.text) CoinScore: \(coinScore!.text)")
            difficultyLabel?.text = "Easy Highscores"
        } else if GameManager.sharedInstance.getMediumDifficulty() {
            highScore?.text = "\(GameManager.sharedInstance.getMediumDifficultyScore())"
            coinScore?.text = "\(GameManager.sharedInstance.getMediumDifficultyCoinScore())"
            difficultyLabel?.text = "Medium Highscores"
        } else if GameManager.sharedInstance.getHardDifficulty() {
            highScore?.text = "\(GameManager.sharedInstance.getHardDifficultyScore())"
            coinScore?.text = "\(GameManager.sharedInstance.getHardDifficultyCoinScore())"
            difficultyLabel?.text = "Hard Highscores"
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // check for touches on certain buttons
        for touch in touches {
            let location = touch.location(in: self)
            
            if let nodePoint = atPoint(location).name {
                switch nodePoint {
                case "BackButton":
                    showScene(option: .mainMenu)
                default:
                    break
                }
            }
        }
    }
    
    private func showScene(option: Scenes) {
        
        self.run(SKAction.playSoundFileNamed("Click Sound.wav", waitForCompletion: false))
        
        weak var scene: SKScene!
        
        switch option {
        case .mainMenu:
            scene = GameplayScene(fileNamed: "MainMenuScene")
        }
        
        if scene != nil {
            scene.scaleMode = .aspectFill
            self.view?.presentScene(scene, transition: .flipHorizontal(withDuration: 0.5))
        }
    }
    
    deinit {
        // showing us that this scene and its objects are de-allocated
        print("Highscore was deallocated.")
    }
}

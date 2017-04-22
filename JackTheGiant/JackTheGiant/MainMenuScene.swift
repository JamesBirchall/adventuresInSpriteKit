//
//  MainMenuScene.swift
//  JackTheGiant
//
//  Created by James Birchall on 18/04/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    
    private enum Scenes {
        case start
        case highscore
        case option
    }
    
    private var startButton: SKSpriteNode?
    private var highscoreButton: SKSpriteNode?
    private var optionsButton: SKSpriteNode?
    private var quitButton: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        print("Main Menu Shown")
        
        // setup buttons
        startButton = self.childNode(withName: "StartButton") as? SKSpriteNode
        highscoreButton = self.childNode(withName: "HighscoreButton") as? SKSpriteNode
        optionsButton = self.childNode(withName: "OptionsButton") as? SKSpriteNode
        quitButton = self.childNode(withName: "QuitButton") as? SKSpriteNode
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // check for touches on certain buttons
        for touch in touches {
            let location = touch.location(in: self)
            
            if let nodePoint = atPoint(location).name {
                switch nodePoint {
                case "StartButton":
                    showScene(option: .start)
                case "HighscoreButton":
                    showScene(option: .highscore)
                case "OptionsButton":
                    showScene(option: .option)
                default:
                    break
                }
            }
        }
    }
    
    private func showScene(option: Scenes) {
        weak var scene: SKScene!
        
        switch option {
        case .start:
            scene = GameplayScene(fileNamed: "GameplayScene")
        case .highscore:
            scene = HighscoreScene(fileNamed: "HighscoreScene")
        case .option:
            scene = OptionsScene(fileNamed: "OptionsScene")
        }
        
        if scene != nil {
            scene.scaleMode = .aspectFill
            self.view?.presentScene(scene, transition: .doorway(withDuration: 0.5))
        }
    }
    
    deinit {
        // showing us that this scene and its objects are de-allocated
        print("Main menu was deallocated.")
    }
}

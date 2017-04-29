//
//  OptionsScene.swift
//  JackTheGiant
//
//  Created by James Birchall on 19/04/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import SpriteKit

class OptionsScene: SKScene {
    
    private var easyButton: SKSpriteNode?
    private var mediumButton: SKSpriteNode?
    private var hardButton: SKSpriteNode?
    private var checkSign: SKSpriteNode?

    private enum Scenes {
        case mainMenu
    }
    
    private var backButton: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        backButton = self.childNode(withName: "BackButton") as? SKSpriteNode
        
        easyButton = self.childNode(withName: "EasyButton") as? SKSpriteNode
        mediumButton = self.childNode(withName: "MediumButton") as? SKSpriteNode
        hardButton = self.childNode(withName: "HardButton") as? SKSpriteNode
        checkSign = self.childNode(withName: "CheckSign") as? SKSpriteNode
        
        // setup the sign depending on current difficulty
        if GameManager.sharedInstance.getEasyDifficulty() {
            checkSign?.position.y = (easyButton?.position.y)!
        } else if GameManager.sharedInstance.getMediumDifficulty() {
            checkSign?.position.y = (mediumButton?.position.y)!
        } else if GameManager.sharedInstance.getHardDifficulty() {
            checkSign?.position.y = (hardButton?.position.y)!
        }
    }
    
    private func setDifficulty(difficulty: Int) {
        switch difficulty {
        case 0:
            GameManager.sharedInstance.setEasyDifficulty(true)
            GameManager.sharedInstance.setMediumDifficulty(false)
            GameManager.sharedInstance.setHardDifficulty(false)
        case 1:
            GameManager.sharedInstance.setEasyDifficulty(false)
            GameManager.sharedInstance.setMediumDifficulty(true)
            GameManager.sharedInstance.setHardDifficulty(false)
        case 2:
            GameManager.sharedInstance.setEasyDifficulty(false)
            GameManager.sharedInstance.setMediumDifficulty(false)
            GameManager.sharedInstance.setHardDifficulty(true)
        default:
            break
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // check for touches on certain buttons
        for touch in touches {
            let location = touch.location(in: self)
            
            if let nodePoint = atPoint(location).name {
                switch nodePoint {
                case "BackButton":
                    GameManager.sharedInstance.saveData()   // save latest settings
                    showScene(option: .mainMenu)
                case "EasyButton":
                    checkSign?.position.y = (easyButton?.position.y)!
                    setDifficulty(difficulty: 0)
                case "MediumButton":
                    checkSign?.position.y = (mediumButton?.position.y)!
                    setDifficulty(difficulty: 1)
                case "HardButton":
                    checkSign?.position.y = (hardButton?.position.y)!
                    setDifficulty(difficulty: 2)
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
        print("Options was deallocated.")
    }
}

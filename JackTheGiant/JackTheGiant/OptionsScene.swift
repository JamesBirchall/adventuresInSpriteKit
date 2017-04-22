//
//  OptionsScene.swift
//  JackTheGiant
//
//  Created by James Birchall on 19/04/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import SpriteKit

class OptionsScene: SKScene {

    private enum Scenes {
        case mainMenu
    }
    
    private var backButton: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        backButton = self.childNode(withName: "BackButton") as? SKSpriteNode
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

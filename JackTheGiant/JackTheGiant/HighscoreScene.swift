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
        print("Highscore was deallocated.")
    }
}

//
//  GameplayScene.swift
//  FlappyBird
//
//  Created by James Birchall on 18/08/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene {
    
    private var bird: Bird!
    
    private enum imageNames: String {
        case BackgroundSpriteNode
        case GroundSpriteNode
    }
    
    let daytime: Bool = {
        
        // TODO: Add logic here for if its daytime or night time in current timezone.
        return true
    }()
    
    override func didMove(to view: SKView) {
        
        backgroundColor = UIColor.brown
        initialise()
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        moveBackgroundsAndGrounds()
    }
    
    // MARK: - Initialise
    private func initialise() {
        
        createBackgrounds()
        createGround()
        createBird()
    }
    
    private func createBackgrounds() {
        
        var imageNamed: String!
        if daytime {
            imageNamed = "BackgroundDay"
        } else {
            imageNamed = "BackgroundNight"
        }
        
        for i in 0...2 {
            let background = SKSpriteNode(imageNamed: imageNamed)
            background.name = imageNames.BackgroundSpriteNode.rawValue
            background.zPosition = 0
            background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            background.position = CGPoint(x: i * Int(background.size.width), y: 0)
            addChild(background)
        }
    }
    
    private func createGround() {
        for i in 0...2 {
            let ground = SKSpriteNode(imageNamed: "Ground")
            ground.name = imageNames.GroundSpriteNode.rawValue
            ground.zPosition = 1
            ground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            let yPosition = -(frame.size.height / 2)    // half the size of the screen and negative
            ground.position = CGPoint(x: i * Int(ground.size.width), y: Int(yPosition))
            addChild(ground)
        }
    }
    
    private func createBird() {
        bird = Bird(imageNamed: "Blue 1")
        bird.initialise()
        bird.position = CGPoint(x: -50, y: 0)
        addChild(bird)
    }
    
    private func moveBackgroundsAndGrounds() {
        
        enumerateChildNodes(withName: imageNames.BackgroundSpriteNode.rawValue) { [weak self] (node: SKNode, error: UnsafeMutablePointer<ObjCBool>) in
            node.position.x -= 4.5
            
            if let width = self?.frame.width {
                if node.position.x <= -(width) {
                    node.position.x += width * 3
                }
            }
        }
        
        enumerateChildNodes(withName: imageNames.GroundSpriteNode.rawValue) { [weak self] (node: SKNode, error: UnsafeMutablePointer<ObjCBool>) in
            node.position.x -= 4.5
            
            if let width = self?.frame.width {
                if node.position.x <= -(width) {
                    node.position.x += width * 3
                }
            }
        }
    }
}

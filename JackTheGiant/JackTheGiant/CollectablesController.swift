//
//  CollectablesController.swift
//  JackTheGiant
//
//  Created by James Birchall on 23/04/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import SpriteKit

class CollectablesController {
    func getCollectables() -> SKSpriteNode {
        
        var collectable = SKSpriteNode()
        
        if Int(randomBetweenNumbers(first: 0, second: 7)) >= 4 {
            if GameplayController.sharedInstance.lifeScore! < 2 {
                collectable = SKSpriteNode(imageNamed: "Life")
                collectable.name = "Life"
                collectable.physicsBody = SKPhysicsBody(rectangleOf: collectable.size)
            }
        } else {
            collectable = SKSpriteNode(imageNamed: "Coin")
            collectable.name = "Coin"
            collectable.physicsBody = SKPhysicsBody(circleOfRadius: collectable.size.height / 2)
            
        }
        
        collectable.physicsBody?.affectedByGravity = false
        collectable.physicsBody?.categoryBitMask = ColliderType.darkCloudAndCollectables
        collectable.physicsBody?.collisionBitMask = ColliderType.player
        collectable.zPosition = 2
        
        return collectable
    }
    
    func randomBetweenNumbers(first: CGFloat, second: CGFloat) -> CGFloat {
        
        var randomNumber = (CGFloat(arc4random()) / CGFloat(UINT32_MAX))
        randomNumber *= abs(first - second)
        randomNumber += min(first, second)
        
        return randomNumber
    }
}

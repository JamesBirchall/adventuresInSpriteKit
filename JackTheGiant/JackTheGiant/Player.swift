//
//  Player.swift
//  JackTheGiant
//
//  Created by James Birchall on 26/12/2016.
//  Copyright © 2016 James Birchall. All rights reserved.
//

import SpriteKit

// masks for Physics collision bit masks
struct ColliderType {
    static let player: UInt32 = 0
    static let cloud: UInt32 = 1
    static let darkCloudAndCollectables: UInt32 = 2
}

// inherit spriteNode as we are a sprite node!
class Player: SKSpriteNode {
    
    private var textureAtlas = SKTextureAtlas()
    private var playerAnimation = [SKTexture]()
    private var playerAnimationAction = SKAction()
    
    func initPlayerAndAnimation() {
        textureAtlas = SKTextureAtlas(named: "Player.atlas")
        
        // 1 = idle animation hence start from 2
        for i in 2...textureAtlas.textureNames.count {
            let name = "Player \(i)"
            let texture = SKTexture(imageNamed: name)
            playerAnimation.append(texture)
        }
        
        physicsBody = SKPhysicsBody(rectangleOf: self.size)
        physicsBody?.affectedByGravity = true
        physicsBody?.categoryBitMask = ColliderType.player
        physicsBody?.collisionBitMask = ColliderType.cloud // collide with Cloud but not any action needed as its a physics body as well
        physicsBody?.contactTestBitMask = ColliderType.darkCloudAndCollectables // inform player didBeginContactFunction
        physicsBody?.allowsRotation = false
        physicsBody?.restitution = 0
        
        playerAnimationAction = SKAction.animate(with: playerAnimation, timePerFrame: 0.08, resize: true, restore: false)
    }
    
    func animatePlayer(moveLeft: Bool) {
        
        if moveLeft {
            self.xScale = -fabs(self.xScale)
        } else {
            self.xScale = fabs(self.xScale)
        }
        
        self.run(SKAction.repeatForever(playerAnimationAction), withKey: "Animate")
        //self.run(playerAnimationAction) runs once
    }
    
    func stopPlayerAnimation() {
        self.removeAction(forKey: "Animate")
        self.texture = SKTexture(imageNamed: "Player 1")
        self.size = (self.texture?.size())!
    }
    
    func movePlayer(moveLeft: Bool) {
        if moveLeft {
            // move left
            self.position.x -= 7
        } else {
            // move right
            self.position.x += 7
        }
    }
}

//
//  Bird.swift
//  FlappyBird
//
//  Created by James Birchall on 28/08/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import SpriteKit

class Bird: SKSpriteNode {
    
    func initialise() {
        name = "Bird"
        zPosition = 3
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        // physics setup
        physicsBody = SKPhysicsBody(circleOfRadius: size.height / 2)
        physicsBody?.affectedByGravity = true
        physicsBody?.categoryBitMask = ColliderType.bird
        // collide with pipes/ground
        physicsBody?.collisionBitMask = ColliderType.ground | ColliderType.pipe
        // call didBeginContact
        physicsBody?.contactTestBitMask = ColliderType.ground | ColliderType.pipe | ColliderType.score
    }
    
    func flap() {
        
        // reset velocity
        physicsBody?.velocity = CGVector(dx: 0, dy: 0)  // speed / time
        
        // apply impulse to physics body
        let vector = CGVector(dx: 0, dy: 120)
        physicsBody?.applyImpulse(vector)
    }
}

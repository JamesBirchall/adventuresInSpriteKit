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
    }
}

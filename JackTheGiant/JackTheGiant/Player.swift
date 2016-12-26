//
//  Player.swift
//  JackTheGiant
//
//  Created by James Birchall on 26/12/2016.
//  Copyright © 2016 James Birchall. All rights reserved.
//

import SpriteKit

// inherit spriteNode as we are a sprite node!
class Player: SKSpriteNode {
    
    func movePlayer(moveLeft: Bool) {
        if moveLeft {
            // move left
            self.position.x = self.position.x - 7
        } else {
            // move right
            self.position.x = self.position.x + 7
        }
    }
}

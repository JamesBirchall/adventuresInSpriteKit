//
//  GameplayScene.swift
//  JackTheGiant
//
//  Created by James Birchall on 26/12/2016.
//  Copyright © 2016 James Birchall. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene {
    
    var player: Player? // may not be in scene
    var canMove = false
    var moveLeft = false
    var centre: CGFloat?
    
    override func didMove(to view: SKView) {
        print("Scene was loaded")
        
        centre = (self.scene?.size.width)! / (self.scene?.size.height)!
        
        player = self.childNode(withName: "Player") as! Player? // uses value in class name
    }
    
    override func update(_ currentTime: TimeInterval) {
        managePlayer()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if touch.location(in: self).x > centre! {
                moveLeft = false
            } else {
                moveLeft = true
            }
        }
        
        canMove = true
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canMove = false
    }
    
    func managePlayer() {
        if canMove {
            player?.movePlayer(moveLeft: moveLeft)
        }
    }
}

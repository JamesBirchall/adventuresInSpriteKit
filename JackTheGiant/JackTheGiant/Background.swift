//
//  Background.swift
//  JackTheGiant
//
//  Created by James Birchall on 08/04/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import Foundation
import SpriteKit

class Background: SKSpriteNode {
    
    func moveBackground(camera: SKCameraNode) {
        
        // 10 makes sure background is full out of the view before changing
        if (self.position.y - self.size.height - 10) > camera.position.y {
            self.position.y -= self.size.height * 3 // 3 is due to having 3 backgrounds
        }
    }
}

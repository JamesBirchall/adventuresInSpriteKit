//
//  Clouds.swift
//  JackTheGiant
//
//  Created by James Birchall on 09/04/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import Foundation
import SpriteKit

class CloudsController {
    
    let collectableController = CollectablesController()
    
    var lastCloudPositionY = CGFloat()
    
    func shuffle(cloudsArray: inout [SKSpriteNode]) {
        
        print("Clouds Array Size = \(cloudsArray.count-1)") // clouds array is current 7 in size!
        // check if first cloud is dark cloud and whilst it is randomise the order
        for (i, _) in cloudsArray.enumerated() {
            // loop through and swap elements
            // iteration 1 = get random number between 0 & count
            // then move cloud to that position in array
            let rand = Int(arc4random_uniform(UInt32(cloudsArray.count-1)))
            if i != rand {
                swap(&cloudsArray[i], &cloudsArray[rand])
            }
        }
    }
    
    func randomBetweenNumbers(first: CGFloat, second: CGFloat) -> CGFloat {
        
        // get random number between 0-1 by taking arc4random and dividing by its max value
        var randomNumber = (CGFloat(arc4random()) / CGFloat(UINT32_MAX))
        
        // multiply this by the distance between the 2 numbers
        randomNumber *= abs(first - second)
        
        // add the lesser value so the range is between the 2 original provided numbers
        randomNumber += min(first, second)
        
        return randomNumber
    }
    
    func createClouds() -> [SKSpriteNode] {
        var clouds = [SKSpriteNode]()
        
        for _ in 0..<1 {
            let cloud1 = SKSpriteNode(imageNamed:"Cloud 1")
            cloud1.name = "1"
            let cloud2 = SKSpriteNode(imageNamed:"Cloud 2")
            cloud2.name = "2"
            let cloud3 = SKSpriteNode(imageNamed:"Cloud 3")
            cloud3.name = "3"
            let darkCloud = SKSpriteNode(imageNamed:"Dark Cloud")
            darkCloud.name = "DarkCloud"
            
            cloud1.xScale = 0.9
            cloud1.yScale = 0.9
            cloud2.xScale = 0.9
            cloud2.yScale = 0.9
            cloud3.xScale = 0.9
            cloud3.yScale = 0.9
            darkCloud.xScale = 0.9
            darkCloud.yScale = 0.9
            
            // add physics bodies to clouds
            // need to make the collision box a little smaller than the cloud
            let cloud1Size = CGSize(width: cloud1.size.width * 0.9, height: cloud1.size.height * 0.7)
            let cloud2Size = CGSize(width: cloud2.size.width * 0.9, height: cloud2.size.height * 0.7)
            let cloud3Size = CGSize(width: cloud3.size.width * 0.9, height: cloud3.size.height * 0.7)
            let darkCloudSize = CGSize(width: darkCloud.size.width * 0.9, height: darkCloud.size.height * 0.7)
            cloud1.physicsBody = SKPhysicsBody(rectangleOf: cloud1Size)
            cloud2.physicsBody = SKPhysicsBody(rectangleOf: cloud2Size)
            cloud3.physicsBody = SKPhysicsBody(rectangleOf: cloud3Size)
            darkCloud.physicsBody = SKPhysicsBody(rectangleOf: darkCloudSize)
            
            // they don't get affected by Gravity
            cloud1.physicsBody?.affectedByGravity = false
            cloud2.physicsBody?.affectedByGravity = false
            cloud3.physicsBody?.affectedByGravity = false
            darkCloud.physicsBody?.affectedByGravity = false
            
            // is of a Cloud type so player can collide with use
            cloud1.physicsBody?.categoryBitMask = ColliderType.cloud
            cloud2.physicsBody?.categoryBitMask = ColliderType.cloud
            cloud3.physicsBody?.categoryBitMask = ColliderType.cloud
            darkCloud.physicsBody?.categoryBitMask = ColliderType.darkCloudAndCollectables
            
            // collide with the player
            cloud1.physicsBody?.collisionBitMask = ColliderType.player
            cloud2.physicsBody?.collisionBitMask = ColliderType.player
            cloud3.physicsBody?.collisionBitMask = ColliderType.player
            darkCloud.physicsBody?.collisionBitMask = ColliderType.player
            
            
            
            clouds.append(cloud1)
            clouds.append(cloud2)
            clouds.append(cloud3)
            clouds.append(darkCloud)
        }
        
        shuffle(cloudsArray: &clouds)
        
        return clouds
    }
    
    func arrangeCloudsInScene(scene: SKScene,
                              distanceBetweenClounds: CGFloat,
                              centre: CGFloat,
                              minX: CGFloat,
                              maxX: CGFloat,
                              player: Player,
                              initialClouds: Bool) {
        
        var clouds = createClouds()
        
        var positionY = CGFloat()
        
        if initialClouds {
            while clouds[0].name == "DarkCloud" {
                shuffle(cloudsArray: &clouds)
            }
            
            positionY = centre - 100
        } else {
            positionY = lastCloudPositionY
        }
        
        var random = 0
        
        for cloud in clouds {
            
            var randomX = CGFloat()
            
            if random == 0 {
                randomX = randomBetweenNumbers(first: centre+90, second: maxX)
                random = 1
            } else if random == 1 {
                randomX = randomBetweenNumbers(first: centre-90, second: minX)
                random = 0
            }
            
            cloud.position = CGPoint(x: randomX, y: positionY)
            cloud.zPosition = 3
            
            if !initialClouds {
                if Int(randomBetweenNumbers(first: 0, second: 7)) >= 3 {
                    if cloud.name != "DarkCloud" {
                        let collectable = collectableController.getCollectables()
                        if collectable.name != nil {
                            // we dont want to be adding nil named collectables - they are non-existant nodes
                            collectable.position = CGPoint(x: cloud.position.x, y: cloud.position.y + 60)
                            scene.addChild(collectable)
                        }
                    }
                }
            }
            
            scene.addChild(cloud)
            positionY -= distanceBetweenClounds
            lastCloudPositionY = positionY
            
            if initialClouds {
                // set player to standing on the first cloud
                player.position = CGPoint(x: clouds[0].position.x, y: clouds[0].position.y + 76)
            }
        }
    }
}

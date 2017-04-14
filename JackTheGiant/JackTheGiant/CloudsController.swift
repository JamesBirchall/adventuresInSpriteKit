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
    
    var lastCloudPositionY = CGFloat()
    
    func shuffle(cloudsArray: inout [SKSpriteNode]) {

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
    
    func createClouds() -> [SKSpriteNode] {
        var clouds = [SKSpriteNode]()
        
        for _ in 0..<2 {
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
        
        for cloud in clouds {
            cloud.position = CGPoint(x: 0, y: positionY)
            cloud.zPosition = 3
            scene.addChild(cloud)
            positionY -= distanceBetweenClounds
            lastCloudPositionY = positionY
        }
        
        
    }
}

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

        cloudsArray.shuffle()
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

extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}

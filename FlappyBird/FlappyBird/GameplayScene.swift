//
//  GameplayScene.swift
//  FlappyBird
//
//  Created by James Birchall on 18/08/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene {
    
    private var bird: Bird!
    private var pipesHolder: SKNode!
    
    private enum imageNames: String {
        case BackgroundSpriteNode
        case GroundSpriteNode
        case PipesHolderName
        case Pipe
    }
    
    let daytime: Bool = {
        
        // TODO: Add logic here for if its daytime or night time in current timezone.
        return true
    }()
    
    override func didMove(to view: SKView) {
        
        backgroundColor = UIColor.brown
        initialise()
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        moveBackgroundsAndGrounds()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        bird.flap()
    }
    
    // MARK: - Initialise
    private func initialise() {
        
        createBackgrounds()
        createGround()
        spawnPipes()
        createBird()
    }
    
    private func createBackgrounds() {
        
        var imageNamed: String!
        if daytime {
            imageNamed = "BackgroundDay"
        } else {
            imageNamed = "BackgroundNight"
        }
        
        for i in 0...2 {
            let background = SKSpriteNode(imageNamed: imageNamed)
            background.name = imageNames.BackgroundSpriteNode.rawValue
            background.zPosition = 0
            background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            background.position = CGPoint(x: i * Int(background.size.width), y: 0)
            addChild(background)
        }
    }
    
    private func createGround() {
        for i in 0...2 {
            let ground = SKSpriteNode(imageNamed: "Ground")
            ground.name = imageNames.GroundSpriteNode.rawValue
            ground.zPosition = 1
            ground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            let yPosition = -(frame.size.height / 2)    // half the size of the screen and negative
            ground.position = CGPoint(x: i * Int(ground.size.width), y: Int(yPosition))
            
            ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
            ground.physicsBody?.affectedByGravity = false
            ground.physicsBody?.isDynamic = false
            ground.physicsBody?.categoryBitMask = ColliderType.ground
            // setup on 1 physics body is needed only
//            ground.physicsBody?.collisionBitMask = ColliderType.bird
//            ground.physicsBody?.contactTestBitMask = ColliderType.bird
            
            addChild(ground)
        }
    }
    
    private func createBird() {
        bird = Bird(imageNamed: "Blue 1")
        bird.initialise()
        bird.position = CGPoint(x: -50, y: 0)
        addChild(bird)
    }
    
    private func moveBackgroundsAndGrounds() {
        
        enumerateChildNodes(withName: imageNames.BackgroundSpriteNode.rawValue) { [weak self] (node: SKNode, error: UnsafeMutablePointer<ObjCBool>) in
            node.position.x -= 4.5
            
            if let width = self?.frame.width {
                if node.position.x <= -(width) {
                    node.position.x += width * 3
                }
            }
        }
        
        enumerateChildNodes(withName: imageNames.GroundSpriteNode.rawValue) { [weak self] (node: SKNode, error: UnsafeMutablePointer<ObjCBool>) in
            node.position.x -= 4.5
            
            if let width = self?.frame.width {
                if node.position.x <= -(width) {
                    node.position.x += width * 3
                }
            }
        }
    }
    
    private func createPipes() {
        
        pipesHolder = SKNode()
        pipesHolder.name = imageNames.PipesHolderName.rawValue
        
        let pipeUp = SKSpriteNode(imageNamed: "Pipe 1")
        let pipeDown = SKSpriteNode(imageNamed: "Pipe 1")
        
        pipeUp.name = imageNames.Pipe.rawValue
        pipeUp.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        pipeUp.position = CGPoint(x: 0, y: 500)
        pipeUp.zRotation = CGFloat.pi
        
        pipeUp.physicsBody = SKPhysicsBody(rectangleOf: pipeUp.size)
        pipeUp.physicsBody?.categoryBitMask = ColliderType.pipe
        pipeUp.physicsBody?.affectedByGravity = false
        pipeUp.physicsBody?.isDynamic = false
        
        pipeDown.name = imageNames.Pipe.rawValue
        pipeDown.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        pipeDown.position = CGPoint(x: 0, y: -500)
        
        pipeDown.physicsBody = SKPhysicsBody(rectangleOf: pipeUp.size)
        pipeDown.physicsBody?.categoryBitMask = ColliderType.pipe
        pipeDown.physicsBody?.affectedByGravity = false
        pipeDown.physicsBody?.isDynamic = false
        
        pipesHolder.addChild(pipeUp)
        pipesHolder.addChild(pipeDown)
        
        pipesHolder.zPosition = 5
        
        pipesHolder.position.x = frame.size.width + 100
        pipesHolder.position.y = 0
        
        addChild(pipesHolder)
        
        let destination = frame.width * 2
        
        let moveAction = SKAction.moveTo(x: -destination, duration: 10)
        let removeAction = SKAction.removeFromParent()
        
        pipesHolder.run(SKAction.sequence([moveAction, removeAction]), withKey: "MoveRemoveActions")
    }
    
    private func spawnPipes() {
        let spawnAction = SKAction.run {
            [weak self] in
            self?.createPipes()
        }
        
        let delayAction = SKAction.wait(forDuration: 3)
        
        let sequenceAction = SKAction.sequence([spawnAction, delayAction])
        
        self.run(SKAction.repeatForever(sequenceAction), withKey: "SpawnPipesActions")
    }
}

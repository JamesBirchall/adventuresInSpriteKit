//
//  GameScene.swift
//  HelloSpriteKit
//
//  Created by James Birchall on 21/12/2016.
//  Copyright © 2016 James Birchall. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    enum shapeType {
        case square
        case circle
        case triangle
    }

    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    static var drawShapeType : shapeType = .square
    
    override func didMove(to view: SKView) {
        
        // gets called when the view is loaded
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.1
        
        // choose which shape to draw
        switch GameScene.drawShapeType {
        case .square:
            self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        case .circle:
            self.spinnyNode = SKShapeNode(circleOfRadius: w/2)
        case .triangle:
            let trianglePath = UIBezierPath()
            trianglePath.move(to: CGPoint(x: 0, y: 0))
            trianglePath.addLine(to: CGPoint(x: w/2, y: w))
            trianglePath.addLine(to: CGPoint(x: w, y: 0))
            
            trianglePath.close()
            
            //self.spinnyNode = SKShapeNode(path: trianglePath.cgPath, center: true)
            self.spinnyNode = SKShapeNode(path: trianglePath.cgPath, centered: true)
        }

        // starts an SKAction against the SpinnyNode shape
        // rotate in circle for 1 second
        // wait for half, fade out over half and then remove itself
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(M_PI), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
            //spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5)]))
        }
    }
    
    // MARK: Touch Events response
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // lets animate the label if its present
        if let label = self.label {
            
            // creates an action on the label form the named file and
            // Pulse is the named action - key seems to have no relevance
            // guessing .sks files get added into some lookup
            label.run(SKAction.init(named: "Pulse")!, withKey: "somethingfadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

//
//  GameViewController.swift
//  HelloSpriteKit
//
//  Created by James Birchall on 21/12/2016.
//  Copyright © 2016 James Birchall. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    @IBOutlet weak var segmentSelection: UISegmentedControl!
    // MARK: Setup Scene for Storyboard->View Controller this is attached to
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // SKView inherits from UIView, but then adds to its functionality
            // by adding presentScene and debug information
            // an object that displays SpriteKit contents
            
            // Load the SKScene from 'GameScene.sks'
            // GameScene contains a background colour and single Label
            // Each .sks file appears to be tied to a class file, in this case same name
            // is probably best practise GameScene.swift
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .fill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            // used for optimising draw?  Appears to be related to z index of objects
            view.ignoresSiblingOrder = true
            
            // dbug information capabilities
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsDrawCount = true
        }
    }
    
    // MARK: UIViewController override methods
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func changedSelector(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            GameScene.drawShapeType = .square
            print("Square Type")
        case 1:
            GameScene.drawShapeType = .circle
            print("Circle Type")
        case 2:
            GameScene.drawShapeType = .triangle
            print("Triangle Type")
        default:
            break
        }
        
        // ugly ass way of getting my segment selection data to set static shape type!
        // what a hack!
        // could really have a parameter in the class object that when its updated knows to start drawing
        // different shapes
        
        if let view = self.view as! SKView? {
            // SKView inherits from UIView, but then adds to its functionality
            // by adding presentScene and debug information
            // an object that displays SpriteKit contents
            
            // Load the SKScene from 'GameScene.sks'
            // GameScene contains a background colour and single Label
            // Each .sks file appears to be tied to a class file, in this case same name
            // is probably best practise GameScene.swift
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .fill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            // used for optimising draw?  Appears to be related to z index of objects
            view.ignoresSiblingOrder = true
            
            // dbug information capabilities
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsDrawCount = true
        }
    }
}

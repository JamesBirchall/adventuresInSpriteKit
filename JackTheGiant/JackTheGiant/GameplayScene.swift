//
//  GameplayScene.swift
//  JackTheGiant
//
//  Created by James Birchall on 26/12/2016.
//  Copyright © 2016 James Birchall. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene {
    
    var mainCamera: SKCameraNode?
    
    var background1: Background?
    var background2: Background?
    var background3: Background?
    var pauseButton: SKSpriteNode?
    
    var cloudsController = CloudsController()
    
    var player: Player? // may not be in scene
    var canMove = false
    var moveLeft = false
    var centre: CGFloat?
    
    private var cameraDistanceBeforeCreatingNewClouds = CGFloat()
    
    var distanceBeteenClouds = CGFloat(240)
    let minX = CGFloat(-160)
    let maxX = CGFloat(160)
    
    override func didMove(to view: SKView) {
        print("Gameplay Screen Shown")
        initVariables()
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveCamera()
        managePlayer()
        manageBackgrounds()
        createClouds()  // check and create new clouds if camera has moved so far
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if touch.location(in: self).x > centre! {
                moveLeft = false
                player?.animatePlayer(moveLeft: false)
            } else {
                moveLeft = true
                player?.animatePlayer(moveLeft: true)
            }
        }
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location).name == pauseButton?.name {
                pauseGame() // we want to pause the game here..
            }
        }
        
        canMove = true
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canMove = false
        player?.stopPlayerAnimation()
    }
    
    func initVariables() {
        print("Scene was loaded")
        
        centre = (self.scene?.size.width)! / (self.scene?.size.height)!
        
        player = childNode(withName: "Player") as! Player? // uses value in class name
        player?.initPlayerAndAnimation()
        
        mainCamera = childNode(withName: "Main_Camera") as? SKCameraNode
        getBackgrounds()
        cloudsController.arrangeCloudsInScene(scene: self.scene!, distanceBetweenClounds: distanceBeteenClouds, centre: centre!, minX: minX, maxX: maxX, initialClouds: true)
        
        // print("The random number is \(cloudsController.randomBetweenNumbers(first: 2, second: 5))")
        
        cameraDistanceBeforeCreatingNewClouds = (mainCamera?.position.y)! - 400
        
        pauseButton = childNode(withName: "PauseButton") as? SKSpriteNode
    }
    
    func getBackgrounds() {
        background1 = self.childNode(withName: "Background1") as? Background
        background2 = self.childNode(withName: "Background2") as? Background
        background3 = self.childNode(withName: "Background3") as? Background
    }
    
    func manageBackgrounds() {
        background1?.moveBackground(camera: mainCamera!)
        background2?.moveBackground(camera: mainCamera!)
        background3?.moveBackground(camera: mainCamera!)
    }
    
    func managePlayer() {
        if canMove {
            player?.movePlayer(moveLeft: moveLeft)
        }
    }
    
    func moveCamera() {
        self.mainCamera?.position.y -= 2
    }
    
    func createClouds() {
        if cameraDistanceBeforeCreatingNewClouds > (mainCamera?.position.y)! {
            // reset to new distance
            cameraDistanceBeforeCreatingNewClouds = (mainCamera?.position.y)! - 800
            
            cloudsController.arrangeCloudsInScene(scene: self.scene!, distanceBetweenClounds: distanceBeteenClouds, centre: centre!, minX: minX, maxX: maxX, initialClouds: false)
        }
    }
    
    func pauseGame() {
        
    }
}

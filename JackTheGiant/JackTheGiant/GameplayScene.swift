//
//  GameplayScene.swift
//  JackTheGiant
//
//  Created by James Birchall on 26/12/2016.
//  Copyright © 2016 James Birchall. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene, SKPhysicsContactDelegate {
    
    private enum Scenes {
        case mainMenu
    }
    
    var mainCamera: SKCameraNode?
    
    var background1: Background?
    var background2: Background?
    var background3: Background?
    var pauseButton: SKSpriteNode?
    var pausePanel: SKSpriteNode?
    
    var cloudsController = CloudsController()
    
    var player: Player? // may not be in scene
    var canMove = false
    var moveLeft = false
    var centre: CGFloat?
    
    private var acceleration = CGFloat()
    private var cameraSpeed = CGFloat()
    private var maxSpeed = CGFloat()
    
    private let playerMinX = CGFloat(-214)
    private let playerMaxX = CGFloat(214)
    
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
        player?.setScore()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location).name == "ResumeButton" {
                pausePanel?.removeFromParent()  // removes the panel object, sets optional to nil
                self.scene?.isPaused = false // pauses all nodes children and this one.
                return
            }
            
            if atPoint(location).name == "QuitButton" {
                self.scene?.isPaused = false // pauses all nodes children and this one.
                showScene(option: .mainMenu)    // exit from this scene
            }

            if self.scene?.isPaused == false {
                
                // check for pause button first action
                if atPoint(location).name == "PauseButton" {
                    self.scene?.isPaused = true // pauses all nodes children and this one.
                    pauseGame()
                    return
                }
                
                // animate only when scene not under a pause state
                if location.x > centre! {
                    moveLeft = false
                    player?.animatePlayer(moveLeft: false)
                } else {
                    moveLeft = true
                    player?.animatePlayer(moveLeft: true)
                }
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
        
        physicsWorld.contactDelegate = self
        
        centre = (self.scene?.size.width)! / (self.scene?.size.height)!
        
        player = childNode(withName: "Player") as! Player? // uses value in class name
        player?.initPlayerAndAnimation()
        
        mainCamera = childNode(withName: "Main_Camera") as? SKCameraNode
        
        getBackgrounds()
        getLabels()
        
        GameplayController.sharedInstance.initialiseVariables()
        
        cloudsController.arrangeCloudsInScene(scene: self.scene!, distanceBetweenClounds: distanceBeteenClouds, centre: centre!, minX: minX, maxX: maxX, initialClouds: true)
        
        // print("The random number is \(cloudsController.randomBetweenNumbers(first: 2, second: 5))")
        
        cameraDistanceBeforeCreatingNewClouds = (mainCamera?.position.y)! - 400
        
        pauseButton = childNode(withName: "PauseButton") as? SKSpriteNode
        
        setCameraSpeed()    // setup speed based on difficulty of game
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
        
        if (player?.position.y)! - (player?.size.height)! * 3.7 > (mainCamera?.position.y)! {
            print("Player is out of bounds up.")
            self.scene?.isPaused = true
        }
        if (player?.position.y)! + (player?.size.height)! * 3.7 < (mainCamera?.position.y)! {
            print("Player is out of bounds down.")
            self.scene?.isPaused = true
        }
        
        // stop player from going outside left and right sides - could also be done by physics box around the main camera - though that would mean top/bottom hit
        if (player?.position.x)! < playerMinX {
            player?.position.x = playerMinX
        }
        if (player?.position.x)! > playerMaxX {
            player?.position.x = playerMaxX
        }
    }
    
    func moveCamera() {
        
        cameraSpeed += acceleration
        if cameraSpeed >= maxSpeed {
            cameraSpeed = maxSpeed
        }
        
        self.mainCamera?.position.y -= cameraSpeed
    }
    
    func createClouds() {
        if cameraDistanceBeforeCreatingNewClouds > (mainCamera?.position.y)! {
            // reset to new distance
            cameraDistanceBeforeCreatingNewClouds = (mainCamera?.position.y)! - 800
            
            cloudsController.arrangeCloudsInScene(scene: self.scene!, distanceBetweenClounds: distanceBeteenClouds, centre: centre!, minX: minX, maxX: maxX, initialClouds: false)
        }
        
        childNodeOutOfBounds()
    }
    
    func getLabels() {
        GameplayController.sharedInstance.scoreText = mainCamera?.childNode(withName: "ScoreLabel") as? SKLabelNode
        GameplayController.sharedInstance.coinText = mainCamera?.childNode(withName: "CoinsLabel") as? SKLabelNode
        GameplayController.sharedInstance.lifeText = mainCamera?.childNode(withName: "LifeLabel") as? SKLabelNode
    }
    
    func pauseGame() {
            createPausePanel()
    }
    
    func createPausePanel() {
        pausePanel = SKSpriteNode(imageNamed: "Pause Menu")
        pausePanel?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        pausePanel?.xScale = 1.6
        pausePanel?.yScale = 1.6
        //pausePanel?.scale(to: CGSize(width: 1.6, height: 1.6))
        pausePanel?.zPosition = 14
        pausePanel?.position = CGPoint(x: (mainCamera?.frame.width)! / 2, y: (mainCamera?.frame.height)! / 2)
        print("Pause Panel Setup")
        
        
        let resumeButton = SKSpriteNode(imageNamed: "Resume Button")
        resumeButton.name = "ResumeButton"
        resumeButton.zPosition = 15
        resumeButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        resumeButton.position = CGPoint(x: (pausePanel?.position.x)!, y: (pausePanel?.position.y)! + 25)
        pausePanel?.addChild(resumeButton)
        
        let quitButton = SKSpriteNode(imageNamed: "Quit Button 2")
        quitButton.name = "QuitButton"
        quitButton.zPosition = 15
        quitButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        quitButton.position = CGPoint(x: (pausePanel?.position.x)!, y: (pausePanel?.position.y)! - 45)
        pausePanel?.addChild(quitButton)
        
        mainCamera?.addChild(pausePanel!)
    }
    
    private func showScene(option: Scenes) {
        weak var scene: SKScene!
        
        switch option {
        case .mainMenu:
            scene = GameplayScene(fileNamed: "MainMenuScene")
        }
        
        if scene != nil {
            scene.scaleMode = .aspectFill
            self.view?.presentScene(scene, transition: .flipHorizontal(withDuration: 0.5))
        }
    }
    
    deinit {
        // showing us that this scene and its objects are de-allocated
        print("Gameplay Scene was deallocated.")
    }
    
    // MARK: Physics World Contact Delegate Methods
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody?   // Player body variable
        var secondBody: SKPhysicsBody?  // what Player hit!
        
        if contact.bodyA.node?.name == "Player" {
            // either player is the first object
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            // of the second object!
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody?.node?.name == "Player" && secondBody?.node?.name == "Life" {
            // deal with contact for life (Remove Life Node and add Life to player)
            GameplayController.sharedInstance.incrementLife()
            
            secondBody?.node?.removeFromParent()
        } else if firstBody?.node?.name == "Player" && secondBody?.node?.name == "Coin" {
            // deal with contact
            GameplayController.sharedInstance.incrementCoin()
            secondBody?.node?.removeFromParent()
        } else if firstBody?.node?.name == "Player" && secondBody?.node?.name == "DarkCloud" {
            // kill the player
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        //
    }
    
    func childNodeOutOfBounds() {
        for child in children {
            if child.position.y > (mainCamera?.position.y)! + (self.scene?.size.height)! {
                if !(child.name?.contains("Background"))! {
                    
                    print("Removing child: \(child.name!)")
                    // we know its not a background
                    child.removeFromParent()
                }
            }
        }
    }
    
    func setCameraSpeed() {
        if GameManager.sharedInstance.getEasyDifficulty() {
            acceleration = 0.001
            cameraSpeed = 1.5
            maxSpeed = 4
        } else if GameManager.sharedInstance.getMediumDifficulty() {
            acceleration = 0.002
            cameraSpeed = 2.0
            maxSpeed = 6
        } else if GameManager.sharedInstance.getHardDifficulty() {
            acceleration = 0.003
            cameraSpeed = 2.5
            maxSpeed = 8
        }
    }
}

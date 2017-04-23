//
//  GameplayScene.swift
//  JackTheGiant
//
//  Created by James Birchall on 26/12/2016.
//  Copyright © 2016 James Birchall. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene {
    
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
    
    func getLabels() {
        GameplayController.sharedInstance.scoreText = mainCamera?.childNode(withName: "ScoreLabel") as? SKLabelNode
        GameplayController.sharedInstance.coinText = mainCamera?.childNode(withName: "LifeLabel") as? SKLabelNode
        GameplayController.sharedInstance.lifeText = mainCamera?.childNode(withName: "CoinsLabel") as? SKLabelNode
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
}

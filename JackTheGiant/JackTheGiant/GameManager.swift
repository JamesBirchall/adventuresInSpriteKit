//
//  GameController.swift
//  JackTheGiant
//
//  Created by James Birchall on 23/04/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import Foundation

class GameManager {
    static let sharedInstance = GameManager()
    private init(){ }
    
    private var gameData: GameData?
    
    var gameStartedFromMainMenu = false
    var gameRestartedPlayerDied = false
}

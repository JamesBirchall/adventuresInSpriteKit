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
    
    func initialiseGameData() {
        if !FileManager.default.fileExists(atPath: getFilePath()) {
            gameData = GameData()
            
            gameData?.setEasyDifficultyScore(0)
            gameData?.setEasyDifficultyCoinScore(0)
            gameData?.setMediumDifficultyScore(0)
            gameData?.setMediumDifficultyCoinScore(0)
            gameData?.setHardDifficultyScore(0)
            gameData?.setHardDifficultyCoinScore(0)
            gameData?.setEasyDifficulty(false)
            gameData?.setMediumDifficulty(true)
            gameData?.setHardDifficulty(false)
            gameData?.setIsMusicOn(false)
            saveData()  // save first settings
        }
        
        // print("\(getFilePath())")
        
        loadData()  // reload same data - or load data if already have a file in existance
    }
    
    func loadData() {
        gameData = NSKeyedUnarchiver.unarchiveObject(withFile: getFilePath()) as? GameData
    }
    
    func saveData() {
        if gameData != nil {
            NSKeyedArchiver.archiveRootObject(gameData!, toFile: getFilePath())
            // print("Game Data Saved.")
        } else {
            // print("Game Data not saved.")
        }
    }
    
    private func getFilePath() -> String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first as URL!
        return url!.appendingPathComponent("GameManager.plist").path
    }
    
    func setEasyDifficultyScore(easyDifficultyScore: Int32) {
        gameData?.setEasyDifficultyScore(easyDifficultyScore)
    }
    func getEasyDifficultyScore() -> Int32 {
        return (gameData?.getEasyDifficultyScore())!
    }
    func setMediumDifficultyScore(mediumDifficultyScore: Int32) {
        gameData?.setMediumDifficultyScore(mediumDifficultyScore)
    }
    func getMediumDifficultyScore() -> Int32 {
        return (gameData?.getMediumDifficultyScore())!
    }
    func setHardDifficultyScore(hardDifficultyScore: Int32) {
        gameData?.setHardDifficultyScore(hardDifficultyScore)
    }
    func getHardDifficultyScore() -> Int32 {
        return (gameData?.getHardDifficultyScore())!
    }
    
    func setEasyDifficultyCoinScore(easyDifficultyScore: Int32) {
        gameData?.setEasyDifficultyCoinScore(easyDifficultyScore)
    }
    func getEasyDifficultyCoinScore() -> Int32 {
        return (gameData?.getEasyDifficultyCoinScore())!
    }
    func setMediumDifficultyCoinScore(mediumDifficultyScore: Int32) {
        gameData?.setMediumDifficultyCoinScore(mediumDifficultyScore)
    }
    func getMediumDifficultyCoinScore() -> Int32 {
        return (gameData?.getMediumDifficultyCoinScore())!
    }
    func setHardDifficultyCoinScore(hardDifficultyScore: Int32) {
        gameData?.setHardDifficultyCoinScore(hardDifficultyScore)
    }
    func getHardDifficultyCoinScore() -> Int32 {
        return (gameData?.getHardDifficultyCoinScore())!
    }
    func setEasyDifficulty(_ easyDifficulty: Bool) {
        gameData?.setEasyDifficulty(easyDifficulty)
    }
    func getEasyDifficulty() -> Bool {
        return (gameData?.getEasyDifficulty())!
    }
    func setMediumDifficulty(_ mediumDifficulty: Bool) {
        gameData?.setMediumDifficulty(mediumDifficulty)
    }
    func getMediumDifficulty() -> Bool {
        return (gameData?.getMediumDifficulty())!
    }
    func setHardDifficulty(_ hardDifficulty: Bool) {
        gameData?.setHardDifficulty(hardDifficulty)
    }
    func getHardDifficulty() -> Bool {
        return (gameData?.getHardDifficulty())!
    }
    func setIsMusicOn(_ isMusicOn: Bool) {
        gameData?.setIsMusicOn(isMusicOn)
    }
    func getIsMusicOn() -> Bool {
        return (gameData?.getIsMusicOn())!
    }
}

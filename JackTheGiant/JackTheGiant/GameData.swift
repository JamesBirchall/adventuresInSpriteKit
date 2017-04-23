//
//  GameData.swift
//  JackTheGiant
//
//  Created by James Birchall on 23/04/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import Foundation

class GameData: NSObject, NSCoding {
    
    struct Keys {
        static let easyDifficultyScore = "EasyDifficultyScore"
        static let mediumDifficultyScore = "MediumDifficultyScore"
        static let hardDifficultyScore = "HardDifficultyScore"
        
        static let easyDifficultyCoinScore = "EasyDifficultyCoinScore"
        static let mediumDifficultyCoinScore = "MediumDifficultyCoinScore"
        static let hardDifficultyCoinScore = "HardDifficultyCoinScore"
        
        static let difficulty = "Difficulty"
        static let music = "Music"
    }
    
    private var easyDifficultyScore = Int32()
    private var mediumDifficultyScore = Int32()
    private var hardDifficultyScore = Int32()
    
    private var easyDifficultyCoinScore = Int32()
    private var mediumDifficultyCoinScore = Int32()
    private var hardDifficultyCoinScore = Int32()
    
    private var difficulty: difficultySettings?
    
    public enum difficultySettings {
        case easy
        case medium
        case hard
    }
    
    override init() { }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        
        // for loading data
        easyDifficultyScore = aDecoder.decodeInt32(forKey: Keys.easyDifficultyScore)
        mediumDifficultyScore = aDecoder.decodeInt32(forKey: Keys.mediumDifficultyScore)
        hardDifficultyScore = aDecoder.decodeInt32(forKey: Keys.hardDifficultyScore)
        easyDifficultyCoinScore = aDecoder.decodeInt32(forKey: Keys.easyDifficultyCoinScore)
        mediumDifficultyCoinScore = aDecoder.decodeInt32(forKey: Keys.mediumDifficultyCoinScore)
        hardDifficultyCoinScore = aDecoder.decodeInt32(forKey: Keys.hardDifficultyCoinScore)
        difficulty = aDecoder.decodeObject(forKey: Keys.difficulty) as? difficultySettings
        musicOn = aDecoder.decodeBool(forKey: Keys.music)
        
    }
    
    func encode(with aCoder: NSCoder) {
        // for saving data
        aCoder.encode(easyDifficultyScore, forKey: Keys.easyDifficultyScore)
        aCoder.encode(mediumDifficultyScore, forKey: Keys.mediumDifficultyScore)
        aCoder.encode(hardDifficultyScore, forKey: Keys.hardDifficultyScore)
        aCoder.encode(easyDifficultyCoinScore, forKey: Keys.easyDifficultyCoinScore)
        aCoder.encode(mediumDifficultyCoinScore, forKey: Keys.mediumDifficultyCoinScore)
        aCoder.encode(hardDifficultyCoinScore, forKey: Keys.hardDifficultyCoinScore)
        aCoder.encode(difficulty, forKey: Keys.difficulty)  // assuming Int by default!
        aCoder.encode(musicOn, forKey: Keys.music)
    }
    
    private var musicOn = false
    
    func setEasyDifficultyScore(_ easyScore: Int32) {
        easyDifficultyScore = easyScore
    }
    func setMediumDifficultyScore(_ mediumScore: Int32) {
        mediumDifficultyScore = mediumScore
    }
    func setHardDifficultyScore(_ hardScore: Int32) {
        hardDifficultyScore = hardScore
    }
    func getEasyDifficultyScore() -> Int32 {
        return easyDifficultyScore
    }
    func getMediumDifficultyScore() -> Int32 {
        return mediumDifficultyScore
    }
    func getHardDifficultyScore() -> Int32 {
        return hardDifficultyScore
    }
    
    func setEasyDifficultyCoinScore(_ easyScore: Int32) {
        easyDifficultyCoinScore = easyScore
    }
    func setMediumDifficultyCoinScore(_ mediumScore: Int32) {
        mediumDifficultyCoinScore = mediumScore
    }
    func setHardDifficultyCoinScore(_ hardScore: Int32) {
        hardDifficultyCoinScore = hardScore
    }
    func getEasyDifficultyCoinScore() -> Int32 {
        return easyDifficultyCoinScore
    }
    func getMediumDifficultyCoinScore() -> Int32 {
        return mediumDifficultyCoinScore
    }
    func getHardDifficultyCoinScore() -> Int32 {
        return hardDifficultyCoinScore
    }
    
    func toggleMusic() {
        if musicOn {
            musicOn = false
        } else {
            musicOn = true
        }
    }
    
    func isMusicOn() -> Bool {
        return musicOn
    }
    
    func setDifficulty(_ diffSetting: difficultySettings) {
        difficulty = diffSetting
    }
    
    func getDifficulty() -> difficultySettings {
        if difficulty != nil {
            return difficulty!
        } else {
            return difficultySettings.easy  // default to easy mode
        }
    }
}

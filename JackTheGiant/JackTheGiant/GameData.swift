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
        
        static let EasyDifficulty = "EasyDifficulty"
        static let MediumDifficulty = "MediumDifficulty"
        static let HardDifficulty = "HardDifficulty"
        
        static let music = "Music"
    }
    
    private var easyDifficultyScore = Int32()
    private var mediumDifficultyScore = Int32()
    private var hardDifficultyScore = Int32()
    
    private var easyDifficultyCoinScore = Int32()
    private var mediumDifficultyCoinScore = Int32()
    private var hardDifficultyCoinScore = Int32()
    
    private var easyDifficulty = false
    private var mediumDifficulty = false
    private var hardDifficulty = false
    
    private var isMusicOn = false
    
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
        easyDifficulty = aDecoder.decodeBool(forKey: Keys.EasyDifficulty);
        mediumDifficulty = aDecoder.decodeBool(forKey: Keys.MediumDifficulty);
        hardDifficulty = aDecoder.decodeBool(forKey: Keys.HardDifficulty);
        isMusicOn = aDecoder.decodeBool(forKey: Keys.music)
        
    }
    
    func encode(with aCoder: NSCoder) {
        // for saving data
        aCoder.encode(easyDifficultyScore, forKey: Keys.easyDifficultyScore)
        aCoder.encode(mediumDifficultyScore, forKey: Keys.mediumDifficultyScore)
        aCoder.encode(hardDifficultyScore, forKey: Keys.hardDifficultyScore)
        aCoder.encode(easyDifficultyCoinScore, forKey: Keys.easyDifficultyCoinScore)
        aCoder.encode(mediumDifficultyCoinScore, forKey: Keys.mediumDifficultyCoinScore)
        aCoder.encode(hardDifficultyCoinScore, forKey: Keys.hardDifficultyCoinScore)
        aCoder.encode(easyDifficulty, forKey: Keys.EasyDifficulty);
        aCoder.encode(mediumDifficulty, forKey: Keys.MediumDifficulty);
        aCoder.encode(hardDifficulty, forKey: Keys.HardDifficulty);
        
        aCoder.encode(isMusicOn, forKey: Keys.music)
    }
    
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
    
    func setEasyDifficulty(_ easyDifficulty: Bool) {
        self.easyDifficulty = easyDifficulty
    }
    
    func getEasyDifficulty() -> Bool {
        return self.easyDifficulty
    }
    
    func setMediumDifficulty(_ mediumDifficulty: Bool) {
        self.mediumDifficulty = mediumDifficulty
    }
    
    func getMediumDifficulty() -> Bool {
        return self.mediumDifficulty
    }
    
    func setHardDifficulty(_ hardDifficulty: Bool) {
        self.hardDifficulty = hardDifficulty
    }
    
    func getHardDifficulty() -> Bool {
        return self.hardDifficulty
    }
    
    func setIsMusicOn(_ isMusicOn: Bool) {
        self.isMusicOn = isMusicOn
    }
    
    func getIsMusicOn() -> Bool {
        return self.isMusicOn
    }

}

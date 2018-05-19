//
//  SpriteNames.swift
//  Slingshot
//
//  Created by Robert Desjardins on 2018-03-26.
//  Copyright © 2018 Robert Desjardins. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class GameData {
    static let shared = GameData()
    var kPlayerName = "playerName"
    var kEnemy1Name = "enemy1Name"
    var kEnemy2Name = "enemy2Name"
    var kEnemy3Name = "enemy3Name"
    var kEnemy4Name = "enemy4Name"
    var kEnemy5Name = "enemy5Name"
    var deviceWidth = UIScreen.main.bounds.size.width
    var deviceHeight = UIScreen.main.bounds.size.height
    
    var playerScore = 0
    var playerHighScore: [Int] = []
    var creditsEarned: Int = 0
    var totalCredits: Int = 0
    
    var playerHealth = 100
    var playerAttack1 = "Slash"
    var playerAttack2 = "Bash"
    
    var battleSceneButtonFontSize : CGFloat = 36
    
    var currentEnemy:String = ""

    private init() { }
}

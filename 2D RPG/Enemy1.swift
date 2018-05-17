//
//  Enemy1.swift
//  2D RPG
//
//  Created by Robert Desjardins on 2018-05-17.
//  Copyright © 2018 Robert Desjardins. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import AVFoundation

class Enemy1: SKSpriteNode {

    var enemyWidth:CGFloat = 0
    var enemyHeight:CGFloat = 0
    var enemyAttack1Damage: Int = 0
    var enemyAttack1HitChange: Int = 0
    
    func initEnemy() {
        self.size = CGSize(width: enemyWidth, height: enemyHeight)
        self.zPosition = 6
        self.name = GameData.shared.kEnemy1Name
    }
}

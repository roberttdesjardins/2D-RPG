//
//  Player.swift
//  2D RPG
//
//  Created by Robert Desjardins on 2018-05-14.
//  Copyright © 2018 Robert Desjardins. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import AVFoundation

class Player: SKSpriteNode {
    
    var playerHealth:CGFloat = 0
    var playerWidth:CGFloat = 38
    var playerHeight:CGFloat = 48
    
    func initPlayer() {
        self.size = CGSize(width: playerWidth, height: playerHeight)
        self.zPosition = 6
        self.name = GameData.shared.kPlayerName
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        self.physicsBody!.isDynamic = true
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.Player
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Edge
        self.physicsBody?.collisionBitMask = PhysicsCategory.Edge
    }
    
    func playerIdleAnim(player: Player) {
        player.size.width = 38
        var gifIdle: [SKTexture] = []
        for i in 0...3 {
            gifIdle.append(SKTexture(imageNamed: "player_idle_frame_\(i)_delay-0.13s"))
        }
        player.run(SKAction.repeatForever(SKAction.animate(with: gifIdle, timePerFrame: 0.13)))
    }
    
    func playerRunningAnim(player: Player) {
        player.size.width = 66
        var gifRunning: [SKTexture] = []
        for i in 0...11 {
            gifRunning.append(SKTexture(imageNamed: "player_running_frame_\(i)_delay-0.07s"))
        }
        player.run(SKAction.repeatForever(SKAction.animate(with: gifRunning, timePerFrame: 0.07)))
    }
}

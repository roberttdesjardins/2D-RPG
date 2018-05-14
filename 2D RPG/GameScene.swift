//
//  GameScene.swift
//  2D RPG
//
//  Created by Robert Desjardins on 2018-05-13.
//  Copyright © 2018 Robert Desjardins. All rights reserved.
//
// Game Idea:
// 2D Pixel Art game Rogue Like
// Player is slightly on the left of the screen
// Hold down screen to move forward
// Button for inventory
// Random events come up
// Can choose to interact with some objects (House, go in?, Artifact, touch it?)
// In battle, choose a move, or run

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    let worldNode = SKNode()
    
    private var lastUpdateTime : TimeInterval = 0
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
        
    }
    
    func setUpPlayer() {
        let player:Player = Player(imageNamed: "player_frame_0_delay-0.13s")
        player.initPlayer()
        player.position = CGPoint(x: size.width * (1/2), y: size.height * (1/6))
        worldNode.addChild(player)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
    }
}

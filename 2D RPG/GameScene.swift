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
    
    private var playerStateChanged = true
    private var touchToMove = false
    
    private var inWorld = false  // If go into battle, event, menu, inventory, inWorld becomes false
    
    override func sceneDidLoad() {
        inWorld = true
        addChild(worldNode)
        self.lastUpdateTime = 0
        setUpPlayer()
    }
    
    func setUpPlayer() {
        let player:Player = Player(imageNamed: "player_idle_frame_0_delay-0.13s")
        player.initPlayer()
        player.position = CGPoint(x: size.width * (1/2), y: size.height * (1/6))
        worldNode.addChild(player)
        playerIdleAnim(player: player)
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
    
    // TODO: If the player is "Moving", move the background to the right but keep the player in same spot
    func moveBackground() {
        
    }
    
    func choosePlayerAnimation() {
        if let player = worldNode.childNode(withName: GameData.shared.kPlayerName) as? Player{
            if touchToMove {
                playerRunningAnim(player: player)
            } else {
                playerIdleAnim(player: player)
            }
            
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if inWorld {
            touchToMove = true
            playerStateChanged = true
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        touchToMove = false
        playerStateChanged = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            touchDown(atPoint: touch.location(in: view))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            touchUp(atPoint: touch.location(in: view))
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            touchUp(atPoint: touch.location(in: view))
        }
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        //let dt = currentTime - self.lastUpdateTime
        
        if playerStateChanged {
            if let player = worldNode.childNode(withName: GameData.shared.kPlayerName) as? Player{
                player.removeAllActions()
            }
            playerStateChanged = false
            choosePlayerAnimation()
        }
        
    }
}

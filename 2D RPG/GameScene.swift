//
//  GameScene.swift
//  2D RPG
//
//  Created by Robert Desjardins on 2018-05-13.
//  Copyright © 2018 Robert Desjardins. All rights reserved.
//
// Game Idea:
// 2D Pixel Art Rogue Like Game
// Player is slightly on the left of the screen
// Hold down screen to move forward
// Button for inventory
// Random events come up
// Can choose to interact with some objects (House, go in?, Artifact, touch it?)
// In battle, choose a move, or run

// TODO:
// Give player health
// Create monsters which are passed to BattleScene
// Create Inventory

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    let worldNode = SKNode()
    
    private var scoreLabel = SKLabelNode(fontNamed: "Avenir")
    
    private var lastUpdateTime : TimeInterval = 0
    
    private var playerStateChanged = true
    private var touchToMove = false
    
    private var inWorld = false  // If go into battle, event, menu, inventory, inWorld becomes false
    
    // Background
    let background1 = SKSpriteNode(imageNamed: "glacial_mountains_lightened")
    let background2 = SKSpriteNode(imageNamed: "glacial_mountains_lightened")
    
    override func sceneDidLoad() {
        inWorld = true
        addChild(worldNode)
        self.lastUpdateTime = 0
        setUpPlayer()
        setupBackground()
        setUpHud()
    }
    
    func setupBackground() {
        background1.anchorPoint = CGPoint(x: 0, y: 0)
        background1.position = CGPoint(x: 0, y: 0)
        background1.zPosition = -15
        background1.size.width = size.width
        background1.size.height = background1.size.width * 0.5625
        worldNode.addChild(background1)
        
        background2.anchorPoint = CGPoint(x: 0, y: 0)
        background2.position = CGPoint(x: background1.size.width, y: 0)
        background2.zPosition = -15
        background2.size.width = size.width
        background2.size.height = background2.size.width * 0.5625
        worldNode.addChild(background2)
    }
    
    func setUpHud() {
        scoreLabel.fontSize = 15
        scoreLabel.fontColor = SKColor.white
        scoreLabel.text = String("Score: \(GameData.shared.playerScore)")
        
        //TODO: Test this on iphoneX
        if UIScreen.main.nativeBounds.height == 2436.0 {
            scoreLabel.position = CGPoint(x: 0, y: size.height - (scoreLabel.frame.size.height + 22))
        } else {
            scoreLabel.position = CGPoint(x: 0, y: size.height - scoreLabel.frame.size.height)
        }
        
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        scoreLabel.zPosition = 20
        addChild(scoreLabel)
    }
    
    func updateHud(){
        scoreLabel.text = String("Score: \(GameData.shared.playerScore)")
    }
    
    // If the player is "Moving", move the background to the right but keep the player in same spot
    func updateBackground() {
        background1.position = CGPoint(x: background1.position.x - 1, y: background1.position.y)
        background2.position = CGPoint(x: background2.position.x - 1, y: background2.position.y)
        
        if(background1.position.x < 0 - background1.size.width)
        {
            background1.position = CGPoint(x: background2.position.x + background2.size.width, y: background2.position.y)
        }
        
        if(background2.position.x < 0 - background2.size.width)
        {
            background2.position = CGPoint(x: background1.position.x + background2.size.width, y: background1.position.y)
        }
    }
    
    func setUpPlayer() {
        let player:Player = Player(imageNamed: "player_idle_frame_0_delay-0.13s")
        player.initPlayer()
        player.position = CGPoint(x: size.width * (1/4), y: size.height * (1/6))
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
        
        if touchToMove {
            GameData.shared.playerScore = GameData.shared.playerScore + 1
            updateHud()
            updateBackground()
        }
        
    }
}

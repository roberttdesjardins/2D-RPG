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
// Learn how to add constraits in scene
// Make harder enemies appear more often the further along the player gets

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    let worldNode = SKNode()
    
    private var scoreLabel = SKLabelNode(fontNamed: "Avenir")
    private var healthLabel = SKLabelNode(fontNamed: "Avenir")
    
    private var lastUpdateTime : TimeInterval = 0
    private var counter : Int = 0
    
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
        
        if UIScreen.main.nativeBounds.height == 2436.0 {
            scoreLabel.position = CGPoint(x: 0, y: size.height - (scoreLabel.frame.size.height + 22))
        } else {
            scoreLabel.position = CGPoint(x: 0, y: size.height - scoreLabel.frame.size.height)
        }
        
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        scoreLabel.zPosition = 20
        worldNode.addChild(scoreLabel)
        
        healthLabel.fontSize = 15
        healthLabel.fontColor = SKColor.white
        healthLabel.text = String("Health: \(GameData.shared.playerHealth)")
        
        healthLabel.position = scoreLabel.position - CGPoint(x: 0, y: healthLabel.frame.size.height)
        healthLabel.zPosition = 20
        worldNode.addChild(healthLabel)
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
        player.playerIdleAnim(player: player)
    }
    
    
    func choosePlayerAnimation() {
        if let player = worldNode.childNode(withName: GameData.shared.kPlayerName) as? Player{
            if touchToMove {
                player.playerRunningAnim(player: player)
            } else {
                player.playerIdleAnim(player: player)
            }
        }
    }
    
    
    // EVENTS
    // callRandomEvent takes a CGFloat between 0 and 100, and based on the CGFloat, calls an event
    func callRandomEvent(percentage: CGFloat) {
        if percentage <= 50 {
            // TODO: Change code to make adding enemies easier
            if percentage <= 10 {
                print("Encounter enemy1")
                GameData.shared.currentEnemy = GameData.shared.kEnemy1Name
            } else if percentage <= 20 {
                print("Encounter enemy2")
                GameData.shared.currentEnemy = GameData.shared.kEnemy2Name
            } else if percentage <= 30 {
                print("Encounter enemy3")
                GameData.shared.currentEnemy = GameData.shared.kEnemy3Name
            } else if percentage <= 40 {
                print("Encounter enemy4")
                GameData.shared.currentEnemy = GameData.shared.kEnemy4Name
            } else {
                print("Encounter enemy5")
                GameData.shared.currentEnemy = GameData.shared.kEnemy5Name
            }
            battleSceneLoad(view: view!)
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
            counter = counter + 1
            updateHud()
            updateBackground()
            
            // Increases chances of a random event the longer you move forward. Counter resets when random event is called
            
            let arc4 = arc4random_uniform(50000)
            print("\(arc4)")
            if (min(counter, 600) > arc4) {
                print("counter: \(counter)")
                counter = 0
                callRandomEvent(percentage: random(min: 0, max: 100))
            }
        }
        
    }
}

//
//  BattleScene.swift
//  2D RPG
//
//  Created by Robert Desjardins on 2018-05-15.
//  Copyright © 2018 Robert Desjardins. All rights reserved.
//

import SpriteKit
import GameplayKit

class BattleScene: SKScene {
    let worldNode = SKNode()
    var runButton: SKSpriteNode! = nil
    var attack1Button: SKSpriteNode! = nil
    var attack2Button: SKSpriteNode! = nil
    
    override func sceneDidLoad() {
        addChild(worldNode)
        createUI()
    }
    
    func createUI() {
        // TODO: put in actual size
        let runButtonSize = CGSize(width: 100, height: 40)
        let runButtonPosition = CGPoint(x: runButtonSize.width/2, y: size.height - runButtonSize.height/2)
        
        let attack1ButtonSize = CGSize(width: 100, height: 40)
        let attack1ButtonPosition = CGPoint(x: size.width/4, y: attack1ButtonSize.height)
        
        let attack2ButtonSize = CGSize(width: 100, height: 40)
        let attack2ButtonPosition = CGPoint(x: size.width * (3/4), y: attack2ButtonSize.height)
        
        createRunButton(position: runButtonPosition, size: runButtonSize)
        createAttack1Button(position: attack1ButtonPosition, size: attack1ButtonSize, text: GameData.shared.playerAttack1)
        createAttack2Button(position: attack2ButtonPosition, size: attack2ButtonSize, text: GameData.shared.playerAttack2)
    }
    
    func createRunButton(position: CGPoint, size: CGSize) {
        runButton = SKSpriteNode(imageNamed: "")
        runButton.zPosition = 2
        runButton.size = size
        runButton.position = position
        worldNode.addChild(runButton)
    }
    
    // TODO: Put in attack text ontop of blank button?
    func createAttack1Button(position: CGPoint, size: CGSize, text: String) {
        attack1Button = SKSpriteNode(imageNamed: "")
        attack1Button.zPosition = 2
        attack1Button.size = size
        attack1Button.position = position
        worldNode.addChild(attack1Button)
    }
    
    // TODO: Put in attack text ontop of blank button?
    func createAttack2Button(position: CGPoint, size: CGSize, text: String) {
        attack2Button = SKSpriteNode(imageNamed: "")
        attack2Button.zPosition = 2
        attack2Button.size = size
        attack2Button.position = position
        worldNode.addChild(attack2Button)
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
        if runButton.contains(touchLocation) {
            playButtonPressSound()
            //TODO: Code to run
        }
        if attack1Button.contains(touchLocation) {
            playButtonPressSound()
            //TODO: Code to attack1
        }
        if attack2Button.contains(touchLocation) {
            playButtonPressSound()
            //TODO: Code to attack2
        }
    }
}

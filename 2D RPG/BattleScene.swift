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
    
    override func sceneDidLoad() {
        addChild(worldNode)
        createUI()
    }
    
    func createUI() {
        createButton(text: "Run!")
        createButton(text: GameData.shared.playerAttack1)
        createButton(text: GameData.shared.playerAttack2)
    }
    
    func createEnemy() {
        if GameData.shared.currentEnemy == GameData.shared.kEnemy1Name {
            let enemy:Enemy1 = Enemy1(imageNamed: "")
        }
        if GameData.shared.currentEnemy == GameData.shared.kEnemy2Name {
            //let enemy:Enemy1 = Enemy1(imageNamed: "")
        }
        if GameData.shared.currentEnemy == GameData.shared.kEnemy3Name {
            //let enemy:Enemy1 = Enemy1(imageNamed: "")
        }
        if GameData.shared.currentEnemy == GameData.shared.kEnemy4Name {
            //let enemy:Enemy1 = Enemy1(imageNamed: "")
        }
        if GameData.shared.currentEnemy == GameData.shared.kEnemy5Name {
            //let enemy:Enemy1 = Enemy1(imageNamed: "")
        }
    }
    
    func createButton(text: String) {
        let buttonTexture: SKTexture! = SKTexture(imageNamed: "button")
        let buttonTextureSelected: SKTexture! = SKTexture(imageNamed: "buttonSelected.png")
        let button = FTButtonNode(normalTexture: buttonTexture, selectedTexture: buttonTextureSelected, disabledTexture: buttonTexture)
        
        if (text == "Run!") {
            button.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(BattleScene.runButtonTapped))
            button.position = CGPoint(x: button.size.width/2, y: size.height - button.size.height)
        } else if (text == GameData.shared.playerAttack1) {
            button.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(BattleScene.attack1ButtonTapped))
            button.position = CGPoint(x: size.width/4, y: button.size.height)
        } else if (text == GameData.shared.playerAttack2) {
            button.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(BattleScene.attack2ButtonTapped))
            button.position = CGPoint(x: size.width * (3/4), y: button.size.height)
        }
        
        
        button.setButtonLabel(title: text as NSString, font: "Arial", fontSize: GameData.shared.battleSceneButtonFontSize)
        button.zPosition = 2
        button.name = "button"
        self.addChild(button)
    }
    
    @objc func runButtonTapped() {
        print("Run Button Tapped")
        playButtonPressSound()
        playerRun()
    }
    
    func playerRun() {
        
    }
    
    @objc func attack1ButtonTapped() {
        print("\(GameData.shared.playerAttack1) Button Tapped")
        playButtonPressSound()
    }
    
    @objc func attack2ButtonTapped() {
        print("\(GameData.shared.playerAttack2) Button Tapped")
        playButtonPressSound()
    }
    
    
}

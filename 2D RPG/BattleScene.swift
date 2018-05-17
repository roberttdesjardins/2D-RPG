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
        let runButtonFontSize : CGFloat = 36
        let runButtonPosition = CGPoint(x: 0, y: size.height)
        
        let attack1ButtonFontSize : CGFloat = 36
        let attack1ButtonPosition = CGPoint(x: size.width/4, y: 0)
        
        let attack2ButtonFontSize : CGFloat = 36
        let attack2ButtonPosition = CGPoint(x: size.width * (3/4), y: 0)
        
        createButton(position: runButtonPosition, fontSize: runButtonFontSize, text: "Run!")
        createButton(position: attack1ButtonPosition, fontSize: attack1ButtonFontSize, text: GameData.shared.playerAttack1)
        createButton(position: attack2ButtonPosition, fontSize: attack2ButtonFontSize, text: GameData.shared.playerAttack2)
    }
    
    func createButton(position: CGPoint, fontSize: CGFloat, text: String) {
        let buttonTexture: SKTexture! = SKTexture(imageNamed: "button")
        let buttonTextureSelected: SKTexture! = SKTexture(imageNamed: "buttonSelected.png")
        let button = FTButtonNode(normalTexture: buttonTexture, selectedTexture: buttonTextureSelected, disabledTexture: buttonTexture)
        button.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(BattleScene.runButtonTap))
        button.setButtonLabel(title: text as NSString, font: "Arial", fontSize: fontSize)
        button.position = position
        button.zPosition = 2
        button.name = "button"
        self.addChild(button)
    }
    
    @objc func runButtonTap() {
        print("Run Button Tapped")
        playButtonPressSound()
    }
    
    
}

//
//  MainMenyScene.swift
//  Incoming!
//
//  Created by Anh Pham on 7/29/19.
//  Copyright © 2019 Anh Pham. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit
import GameplayKit
import AVFoundation

class MainMenuScene: SKScene {
    
     let introSound = SKAction.playSoundFileNamed("introSound", waitForCompletion: false)
    
    override func sceneDidLoad() {
        
        run(introSound)
        
        
    }
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x:self.size.width/2, y:self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        let gameName1 = SKLabelNode(fontNamed: "Space Invaders")
        gameName1.text = "Incoming!"
        gameName1.fontSize = 155
        gameName1.fontColor = SKColor.white
        gameName1.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.6)
        gameName1.zPosition = 1
        self.addChild(gameName1)
        
        let startGame = SKLabelNode(fontNamed: "Space Invaders")
        startGame.text = "Start Game"
        startGame.fontSize = 65
        startGame.fontColor = SKColor.white
        startGame.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.4)
        startGame.zPosition = 1
        startGame.name = "startButton"
        self.addChild(startGame)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in  touches {
            
            let pointOfTouch = touch.location(in: self)
            let nodeITapped = atPoint(pointOfTouch)
            
            if nodeITapped.name == "startButton"{
                
                let sceneToMoveTo = GameScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
                
            }
        }
        
        
    }
    
}

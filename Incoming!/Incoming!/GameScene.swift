//
//  GameScene.swift
//  Incoming!
//
//  Created by Anh Pham on 7/22/19.
//  Copyright © 2019 Anh Pham. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation
var  gameScore = 0

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //global variables
    let scoreLabel = SKLabelNode(fontNamed: "Space Invaders")        //add in bundle & info.plist
    
    var livesNumber = 3 
    let livesLabel = SKLabelNode(fontNamed: "Space Invaders")
    
    var levelNumber = 0
    
    let leftSide = SKLabelNode(fontNamed: "Space Invaders")
    let rightSide = SKLabelNode(fontNamed: "Space Invaders")
    
    let player = SKSpriteNode(imageNamed: "playerShip2")
    let enemySoundL = SKAction.playSoundFileNamed("leftEnemy", waitForCompletion: false)
    let enemySoundR = SKAction.playSoundFileNamed("rightEnemy", waitForCompletion: false)
    let explosionSound = SKAction.playSoundFileNamed("endgame", waitForCompletion: false)
    
    let tapToStartLabel = SKLabelNode (fontNamed: "Space Invaders")
    
    
    enum gameState {
        case preGame        //before the start of the game
        case inGame         // during the game
        case afterGame       // after the game
    }
    
    
    struct PhysicsCategories{
        static let None: UInt32 = 0
        static let Player : UInt32 = 0b1 //1
        static let Bullet : UInt32 = 0b10 //2
        static let Enemy : UInt32 = 0b100 //3
    }

    var currentGameState = gameState.preGame
    
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    func random( min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    var gameArea: CGRect
    
    
    override init( size: CGSize){
        
        let maxAspectRatio:CGFloat = 16.0/9.0
        let playableWidth = size.height/maxAspectRatio
        let margin = (size.width - playableWidth)/2
        gameArea = CGRect (x:margin, y:0, width:playableWidth, height:size.height)
        
        super.init( size: size)
        
    }
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMove(to view:SKView){
        
        gameScore = 0
        
        self.physicsWorld.contactDelegate = self
        
        let background = SKSpriteNode(imageNamed:"background")
        
        background.size = self.size
        background.position = CGPoint(x:self.size.width/2, y:self.size.height/2)
        background.zPosition = 0
        view.showsPhysics = true
        self.addChild(background)
        
        
        player.setScale(1)
        player.position = CGPoint (x:self.size.width/2, y:self.size.height * 0.2)
        player.zPosition = 2
        player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: player.size.width*0.07, height: player.size.height*0.22))
        player.physicsBody!.isDynamic = true
        player.physicsBody!.affectedByGravity = false
        player.physicsBody!.categoryBitMask = PhysicsCategories.Player
        player.physicsBody!.collisionBitMask = PhysicsCategories.None
        player.physicsBody!.contactTestBitMask = PhysicsCategories.Enemy
        self.addChild(player)
        
        scoreLabel.text = "Score: 0"
        scoreLabel.fontSize = 75
        scoreLabel.fontColor = SKColor.white
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        scoreLabel.position = CGPoint(x: self.size.width*0.90, y: self.size.height + scoreLabel.frame.size.height)
        scoreLabel.zPosition = 100
        self.addChild(scoreLabel)
        
        let moveOnToScreenAction = SKAction.moveTo(y: self.size.height*0.9, duration: 0.3)
        scoreLabel.run(moveOnToScreenAction)
        
        tapToStartLabel.text = "Tap to Begin"
        tapToStartLabel.fontColor = SKColor.white
        tapToStartLabel.fontSize = 100
        tapToStartLabel.zPosition = 1
        tapToStartLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        tapToStartLabel.alpha = 0
        self.addChild(tapToStartLabel)
        
        let fadeInAction = SKAction.fadeIn(withDuration: 0.75)
        tapToStartLabel.run(fadeInAction)           //can you make this happen after the player hits start? try declaring the var outside of the class & call it in another function place
    }
    
    func startGame() {
        
        currentGameState = gameState.inGame
        let fadeOutAction = SKAction.fadeOut(withDuration: 0.5)
        let deleteAction = SKAction.removeFromParent()
        let deleteSequence = SKAction.sequence([fadeOutAction, deleteAction])
        tapToStartLabel.run(deleteSequence)
        
        let moveShipOntoScreenAction = SKAction.moveTo(y: self.size.height*0.2, duration: 0.75)
        let startLevelAction = SKAction.run(startNewLevel)
        let startGameSequence = SKAction.sequence([moveShipOntoScreenAction, startLevelAction])
        player.run(startGameSequence)
        
    }
    
    func addScore() {
        
        gameScore += 1
        scoreLabel.text = "Score: \(gameScore)"
        
        //trigger point = case # - 1
        if gameScore == 10 || gameScore == 25 || gameScore == 50 {
            startNewLevel()
        }
        
        let scaleUp = SKAction.scale(to: 1.5, duration: 0.2)
        let scaleDown = SKAction.scale(to: 1, duration: 0.2)
        let scaleSequence = SKAction.sequence([scaleUp, scaleDown])
        scoreLabel.run(scaleSequence)
        
    }
    
    
    func runGameOver() {
        
        currentGameState = gameState.afterGame
        
        self.removeAllActions()
        
        self.enumerateChildNodes(withName: "Bullet") {
            bullet, stop in
            bullet.removeAllActions()
        }
        
        self.enumerateChildNodes(withName: "Enemy") {
            enemy, stop in
            enemy.removeAllActions()
        }
        
        let changeSceneAction = SKAction.run(changeScene)
        let waitToChangeScene = SKAction.wait(forDuration: 1)
        let changeSceneSequence = SKAction.sequence([waitToChangeScene, changeSceneAction])
        self.run(changeSceneSequence)
        
    }
    
    
    func changeScene() {
        
        let sceneToMoveTo = GameOverScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration: 0.5)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
        
        
    }
    
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        var body1 = SKPhysicsBody()
        var body2 = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask{
            body1 = contact.bodyA
            body2 = contact.bodyB
            
        }
        else{
            body1 = contact.bodyB
            body2 = contact.bodyA
        }
        
        if body1.categoryBitMask == PhysicsCategories.Player && body2.categoryBitMask == PhysicsCategories.Enemy{
            
            //writing to text file
            let path = "/Users/anhpham/Documents/XCode/Incoming!/Incoming!/Incoming.txt"
            
            let text = "ZY"
            do {
                try text.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
                // text.append("Hi")
            } catch {
                print(error)
            }
            runGameOver()
            
            if body1.node != nil{
                spawnExplosion(spawnPosition: body1.node!.position)
            }
            
            
            if body2.node != nil{
                spawnExplosion(spawnPosition: body2.node!.position)
            }
            
            
            body1.node?.removeFromParent()
            body2.node?.removeFromParent()
        }
        
        
    }
    
    
    func spawnExplosion(spawnPosition: CGPoint){
        
        let explosion = SKSpriteNode (imageNamed:"explosition")
        explosion.position = spawnPosition
        explosion.zPosition = 3
        explosion.setScale(0)
        self.addChild(explosion)
        
        let scaleIn = SKAction.scale(to: 1, duration: 0.1)
        let fadeOut = SKAction.fadeOut(withDuration: 0.1)
        let delete = SKAction.removeFromParent()
        
        //add sound if want
        
        let explosionSequence = SKAction.sequence([explosionSound, scaleIn,fadeOut,delete])
        explosion.run(explosionSequence)
    }
    
    
    
    func startNewLevel(){
        
        levelNumber += 1
        
        if self.action(forKey: "spawningEnemies") != nil {
            self.removeAction(forKey: "spawningEnemies")
        }
        
        var levelDuration = TimeInterval()
        
        switch levelNumber {
        case 1: levelDuration = 1.2
        case 2: levelDuration = 1
        case 3: levelDuration = 0.8
        case 4: levelDuration = 0.5
        default:
            levelDuration = 0.5
            print("Cannot find level info")
            
        }
        
        let spawn = SKAction.run(spawnEnemy)
        let waitToSpawn = SKAction.wait(forDuration:4)                  //CHANGE HERE
        let spawnSequence = SKAction.sequence([spawn, waitToSpawn])
        let spawnAlways = SKAction.repeatForever(spawnSequence)
        self.run(spawnAlways)
        
        
    }
    
    
    func spawnEnemy(){
        
        let randomBegin = random (min: gameArea.minX, max: gameArea.maxX)
        let randomEnd = random (min: gameArea.minX, max: gameArea.maxX)
        
        let spawnPoint = CGPoint(x: randomBegin, y: self.size.height * 1.2)
        let endPoint = CGPoint(x: randomEnd, y: -self.size.height * 0.2)
    
        
        let enemy = SKSpriteNode(imageNamed: "alien3")
        enemy.setScale(0.5)
        enemy.position = spawnPoint
        enemy.zPosition = 2
        enemy.physicsBody = SKPhysicsBody (rectangleOf: enemy.size)
        enemy.physicsBody!.isDynamic = true
        enemy.physicsBody!.affectedByGravity = false
        enemy.physicsBody!.categoryBitMask = PhysicsCategories.Enemy
        enemy.physicsBody!.collisionBitMask = PhysicsCategories.None
        enemy.physicsBody!.contactTestBitMask = PhysicsCategories.Player | PhysicsCategories.Bullet
        self.addChild(enemy)
        
        
        if (enemy.position.x > self.size.width*0.5) {
            enemy.run(enemySoundR)
            let path = "/Users/anhpham/Documents/XCode/Incoming!/Incoming!/Incoming.txt"
            
            let text = "YYY"
            do {
                try text.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
                // text.append("Hi")
            } catch {
                print(error)
            }
        }
        
//        if (enemy.position.x > self.size.width*0.5) {
//            let path = "/Users/anhpham/Documents/XCode/Incoming!/Incoming!/Incoming.txt"
//            let text = "Z"
//            do {
//                try text.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
//            } catch {
//                print(error)
//            }
//        }
        
        if enemy.position.x < self.size.width*0.5 {
            enemy.run(enemySoundL)
            let path = "/Users/anhpham/Documents/XCode/Incoming!/Incoming!/Incoming.txt"
            
            let text = "ZZZ"
            do {
                try text.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
                // text.append("Hi")
            } catch {
                print(error)
            }
        }
    
        
//        if (enemy.position.x < self.size.width*0.5) {
//            let path = "/Users/anhpham/Documents/XCode/Incoming!/Incoming!/Incoming.txt"
//            let text = "Y"
//            do {
//                try text.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
//            } catch {
//                print(error)
//            }
//        }
        
        
        
        
        let moveEnemy = SKAction.move(to: endPoint, duration:5)         //CHANGE HERE
        let deleteEnemy = SKAction.removeFromParent()
        let addScoreToGame = SKAction.run(addScore)
        let enemySequence = SKAction.sequence([moveEnemy, deleteEnemy, addScoreToGame])
        if currentGameState == gameState.inGame {
            enemy.run(enemySequence)
        }
        
        
        
        let dx = endPoint.x - spawnPoint.x
        let dy = endPoint.y - spawnPoint.y
        let atrLine = atan2(dy ,dx)
        enemy.zRotation = atrLine
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        if currentGameState == gameState.preGame {
            startGame()
        }
        
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches{
            
            let pointOfTouch = touch.location(in: self)
            let previousPointOfTouch = touch.previousLocation(in: self)
            
            let amountDragged = pointOfTouch.x - previousPointOfTouch.x
            
            if currentGameState == gameState.inGame {
                player.position.x += amountDragged
            }
            if player.position.x >= gameArea.maxX - 60 {
                player.position.x = gameArea.maxX - 60
            }
            
            if player.position.x <= gameArea.minX + 60 {
                player.position.x = gameArea.minX + 60
            }
        }
        
        /*
        //reading -- doesn't work YET
        let path = "/Users/anhpham/Documents/XCode/Incoming!/Incoming!/Incoming.txt"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent(path)
        
        do {
            let distanceMoved = try String(contentsOf: fileURL, encoding: .utf8)
            if distanceMoved == "right" {
                let endPointR = CGPoint(x: gameArea.maxX - 60, y: self.size.height*0.2)
                
                let movePlayerR = SKAction.move(to: endPointR, duration: 1)
                player.run(movePlayerR)
            }
            else if distanceMoved == "left" {
                let endPointL = CGPoint(x: gameArea.minX + 60, y: self.size.height*0.2)
                
                let movePlayerL = SKAction.move(to: endPointL, duration: 1)
                player.run(movePlayerL)
            }
        }
        catch {
            print(error)
        }
        
        
    }*/
    
}
}





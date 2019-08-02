//
//  GameViewController.swift
//  Incoming!
//
//  Created by Anh Pham on 7/22/19.
//  Copyright © 2019 Anh Pham. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class GameViewController: UIViewController {
    
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        //writing to text file
        let path = "/Users/anhpham/Documents/XCode/Incoming!/Incoming!/Incoming.txt"
        
        var text = "Yo like seriously work I mean it. "
        do {
            try text.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
            text.append("Hi")
        } catch {
            print(error)
        }*/
        
        
        //background music
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init (fileURLWithPath: Bundle.main.path(forResource: "backgroundMusic", ofType: "wav")!))
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 0.03
            audioPlayer.play()
            audioPlayer.numberOfLoops = -1
        } catch {
            print(error)
        }
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene  = MainMenuScene(size: CGSize(width: 1080, height: 1920))
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

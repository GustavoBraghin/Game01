//
//  GameViewController.swift
//  Intro
//
//  Created by Marcos Morais on 31/03/19.
//  Copyright © 2019 Developer Academy UCB. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import GameKit

class GameViewController: UIViewController {
    
    func authenticatePlayer(){
        let player = GKLocalPlayer.local
        
        player.authenticateHandler = { vc, error in
            
            guard error == nil else {
                print(error?.localizedDescription ?? "error")
                return
            }
            
            if (vc != nil) {
                self.present(vc!, animated: true, completion: nil)
            } else {
                print("Player is authenticated = \(player.isAuthenticated)")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        authenticatePlayer()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene = GameScene(size: view.frame.size)
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

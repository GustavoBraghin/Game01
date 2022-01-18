//
//  GameOverNode.swift
//  Intro
//
//  Created by Gustavo da Silva Braghin on 17/01/22.
//  Copyright © 2022 Developer Academy UCB. All rights reserved.
//

import SpriteKit

class GameOverNode: SKNode{
    
    var playButton = SKSpriteNode()
    var background = SKShapeNode()
    
    init(size: CGSize, position: CGPoint) {
        super.init()
        
        setBg(size: size, position: position)
        setPlayButton(size: size, position: position)
        self.addChild(background)
        self.addChild(playButton)
    }
    
    func setPlayButton(size: CGSize, position: CGPoint){
        playButton = SKSpriteNode(color: .red, size: CGSize(width: size.width * 0.3, height: size.height * 0.08))
        playButton.position = position
        playButton.zPosition = 151
        
        let labelNode = SKLabelNode(fontNamed: "AvenirNext-Bold")
        labelNode.color = .white
        labelNode.verticalAlignmentMode = .center
        labelNode.text = "Play"
        labelNode.zPosition = 151
        
        playButton.addChild(labelNode)
    }
    
    func setBg(size: CGSize, position: CGPoint){
        background = SKShapeNode(rectOf: CGSize(width: size.width * 0.5, height: size.height * 0.33), cornerRadius: 15)
        background.fillColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.3)
        background.position = position
        background.zPosition = 150
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//        override func didMove(to view: SKView) {
//
//            playButton = SKSpriteNode(texture: playButtonTex)
//            playButton.position = CGPoint(x: frame.midX, y: frame.midY)
//            self.addChild(playButton)
//        }
//
//        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//            if let touch = touches.first {
//                let pos = touch.location(in: self)
//                let node = self.atPoint(pos)
//
//                if node == playButton {
//                    if let view = view {
//                        let transition:SKTransition = SKTransition.fade(withDuration: 1)
//                        let scene:SKScene = GameScene(size: self.size)
//                        self.view?.presentScene(scene, transition: transition)
//                    }
//                }
//            }
//        }
}

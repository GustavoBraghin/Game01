//
//  GameOverNode.swift
//  Intro
//
//  Created by Gustavo da Silva Braghin on 17/01/22.
//  Copyright © 2022 Developer Academy UCB. All rights reserved.
//

import SpriteKit

class GameOverNode: SKNode{
    
    //button in the gameOverNode
    var playButton = SKShapeNode()
    
    //backgroundMask of gameOverNode
    var background = SKShapeNode()
    
    init(size: CGSize, position: CGPoint) {
        super.init()
        
        //setting buttons and adding to the node
        setBg(size: size, position: position)
        setPlayButton(size: size, position: position)
        
        self.addChild(background)
        self.addChild(playButton)
    }
    
    //set play button with color, shape, position, and name
    func setPlayButton(size: CGSize, position: CGPoint){
        playButton = SKShapeNode(rectOf: CGSize(width: size.width * 0.3, height: size.height * 0.08), cornerRadius: 15)
        playButton.fillColor = UIColor(red: 143/255, green: 183/255, blue: 36/255, alpha: 1)
        playButton.strokeColor = .clear
        playButton.position = position
        playButton.zPosition = 151
        playButton.name = "playAgain"
        
        let labelNode = SKLabelNode(fontNamed: "AvenirNext-Bold")
        labelNode.color = .white
        labelNode.verticalAlignmentMode = .center
        labelNode.text = "Play"
        labelNode.zPosition = 151
        labelNode.name = "playAgain"
        
        playButton.addChild(labelNode)
    }
    
    //set background with color, shape, and position
    func setBg(size: CGSize, position: CGPoint){
        background = SKShapeNode(rectOf: CGSize(width: size.width * 0.5, height: size.height * 0.33), cornerRadius: 15)
        background.fillColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.3)
        background.strokeColor = .clear
        background.position = position
        background.zPosition = 150
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

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
    var mainMenuButton = SKShapeNode()
    var highscoreLabel = SKLabelNode()
    var tapToPlayLabel = SKLabelNode()
    
    //backgroundMask of gameOverNode
    var background = SKShapeNode()
    
    init(size: CGSize, position: CGPoint) {
        super.init()
        
        //setting buttons and adding to the node
        setBg(size: size, position: position)
        setPlayButton(size: size, position: position)
        //setMainMenuButton(size: size, position: position)
        
        self.addChild(background)
        //self.addChild(playButton)
        //self.addChild(mainMenuButton)
    }
    
    //set play button with color, shape, position, and name
//    func setPlayButton(size: CGSize, position: CGPoint){
//        playButton = SKShapeNode(rectOf: CGSize(width: size.width * 0.3, height: size.height * 0.08), cornerRadius: 15)
//        playButton.fillColor = UIColor(red: 143/255, green: 183/255, blue: 36/255, alpha: 1)
//        playButton.strokeColor = .clear
//        //playButton.position = CGPoint(x: position.x, y: position.y * 1.15)
//        playButton.position = position
//        playButton.zPosition = 151
//        playButton.name = "playAgain"
//
//        let labelNode = SKLabelNode(fontNamed: "AvenirNext-Bold")
//        labelNode.color = .white
//        labelNode.verticalAlignmentMode = .center
//        labelNode.text = "Play"
//        labelNode.zPosition = 151
//        labelNode.name = "playAgain"
//
//        playButton.addChild(labelNode)
//    }
    
    func setPlayButton(size: CGSize, position: CGPoint){
        highscoreLabel = SKLabelNode(fontNamed: "Roboto")
        highscoreLabel.fontColor = .white
        //highscoreLabel.verticalAlignmentMode = .center
        highscoreLabel.text = "Highscore: x"
        highscoreLabel.position = CGPoint(x: position.x, y: position.y * 1.15)
        highscoreLabel.zPosition = 151
        highscoreLabel.name = "playAgain"
        
        
        tapToPlayLabel = SKLabelNode(fontNamed: "Roboto")
        tapToPlayLabel.fontColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.6)
        //highscoreLabel.verticalAlignmentMode = .center
        tapToPlayLabel.text = "Tap to Play"
        tapToPlayLabel.position = CGPoint(x: position.x, y: position.y * 0.95)
        tapToPlayLabel.zPosition = 151
        tapToPlayLabel.name = "playAgain"
        
        self.addChild(highscoreLabel)
        self.addChild(tapToPlayLabel)
    }
    
    //set play button with color, shape, position, and name
//    func setMainMenuButton(size: CGSize, position: CGPoint){
//        mainMenuButton = SKShapeNode(rectOf: CGSize(width: size.width * 0.3, height: size.height * 0.08), cornerRadius: 15)
//        mainMenuButton.fillColor = UIColor(red: 143/255, green: 183/255, blue: 36/255, alpha: 1)
//        mainMenuButton.strokeColor = .clear
//        mainMenuButton.position = CGPoint(x: position.x, y: position.y * 0.85)
//        mainMenuButton.zPosition = 151
//        mainMenuButton.name = "mainMenu"
//
//        let labelNode = SKLabelNode(fontNamed: "AvenirNext-Bold")
//        labelNode.color = .white
//        labelNode.verticalAlignmentMode = .center
//        labelNode.text = "Menu"
//        labelNode.zPosition = 151
//        labelNode.name = "mainMenu"
//
//        mainMenuButton.addChild(labelNode)
//    }
    
    //set background with color, shape, and position
    func setBg(size: CGSize, position: CGPoint){
        background = SKShapeNode(rectOf: CGSize(width: size.width, height: size.height), cornerRadius: 15)
        background.fillColor = .clear
        //background.fillColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.3)
        background.strokeColor = .clear
        background.position = position
        background.zPosition = 150
        background.name = "playAgain"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

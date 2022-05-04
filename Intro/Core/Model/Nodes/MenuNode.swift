//
//  GameOverNode.swift
//  Intro
//
//  Created by Gustavo da Silva Braghin on 17/01/22.
//  Copyright © 2022 Developer Academy UCB. All rights reserved.
//

import SpriteKit

class MenuNode: SKNode{
    
    //button in the gameOverNode
    var playButton = SKShapeNode()
    var mainMenuButton = SKShapeNode()
    var highscoreLabel = SKLabelNode()
    var tapToPlayLabel = SKLabelNode()
    var gameCenterButton = SKSpriteNode()
    
    //backgroundMask of gameOverNode
    var background = SKShapeNode()
    
    let highscore = UserDefaults.standard.integer(forKey: "highscore")
    
    init(size: CGSize, position: CGPoint) {
        super.init()
        
        //setting buttons and adding to the node
        setBg(size: size, position: position)
        setPlayButton(size: size, position: position)
        setGameCenterButton(size: size)
    }
    
    func setPlayButton(size: CGSize, position: CGPoint){
        highscoreLabel = SKLabelNode(fontNamed: "Avenir Next Bold")
        highscoreLabel.fontColor = .white
        //highscoreLabel.verticalAlignmentMode = .center
        highscoreLabel.text = "Highscore: \(highscore)"
        highscoreLabel.position = CGPoint(x: position.x, y: position.y * 1.05)
        highscoreLabel.zPosition = 151
        highscoreLabel.name = "playAgain"
        
        
        tapToPlayLabel = SKLabelNode(fontNamed: "Avenir Next Bold")
        tapToPlayLabel.fontColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.6)
        //highscoreLabel.verticalAlignmentMode = .center
        tapToPlayLabel.text = "Tap to Play"
        tapToPlayLabel.position = CGPoint(x: position.x, y: position.y * 0.85)
        tapToPlayLabel.zPosition = 151
        tapToPlayLabel.name = "playAgain"
        
        self.addChild(highscoreLabel)
        self.addChild(tapToPlayLabel)
    }
    
    func setGameCenterButton(size: CGSize){
        gameCenterButton = SKSpriteNode(imageNamed: "gamecenterimage")
        gameCenterButton.position = CGPoint(x: size.width * 0.88, y: size.height * 0.9)
        gameCenterButton.zPosition = 152
        gameCenterButton.setScale(0.089)
        gameCenterButton.name = "gameCenterButton"
        
        self.addChild(gameCenterButton)
    }
    
    //set background with color, shape, and position
    func setBg(size: CGSize, position: CGPoint){
        background = SKShapeNode(rectOf: CGSize(width: size.width, height: size.height), cornerRadius: 15)
        background.fillColor = .clear
        //background.fillColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.3)
        background.strokeColor = .clear
        background.position = position
        background.zPosition = 150
        background.name = "playAgain"
        
        self.addChild(background)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

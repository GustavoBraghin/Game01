//
//  GameScene.swift
//  Intro
//
//  Created by Marcos Morais on 31/03/19.
//  Copyright © 2019 Developer Academy UCB. All rights reserved.
//

// Importo a framework SpriteKit para desenvolvimento de Jogos 2D
import SpriteKit

// Declaração da minha classe GameScene, que herda de SKScene
class GameScene: SKScene {
    
    var player: Player
    var enemy: Enemy
    var menuNode: MenuNode
    
    let scoreLabel = SKLabelNode(fontNamed: "HelveticaNeue-CondensedBold")
    let lifeLabel = SKLabelNode(fontNamed: "HelveticaNeue-CondensedBold")
    var score: Int
    
    var presentedGameOverNode: Bool
    
    // First method called when scene is initialized
    override init(size: CGSize) {
        
        self.player = Player(spriteName: "astro-2", position: CGPoint(x: (size.width)/2, y: (size.height)*0.15))
        self.enemy = Enemy()
        self.score = 0
        self.menuNode = MenuNode(size: size, position: CGPoint(x: (size.width)/2, y: (size.height)/2))
        self.presentedGameOverNode = false
        super.init(size: size)
        
        // Methods for preparation of scene
        self.setPhysicsUp()
        self.createBackground(with: CGPoint(x: size.width*0.50, y: size.height*0.55))
        self.createScoreLabel(with: CGPoint(x: size.width*0.50, y: size.height*0.88))
        self.createWalls()
        self.createLifeLabel(with: CGPoint(x: size.width*0.20, y: size.height*0.89))
        
        //add contents in scene
        self.addChild(player)
    }
    
    // Esse método é chamado automaticamente após a cena ser criada (DEPOIS do método init(:size))
    override func didMove(to view: SKView) {
        createEnemy()
    }
    
    /**
     Método chamado assim que um toque é detectado na tela. O começo do toque.
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // Recupero a referência para o toque
        let touch = touches.first
        
        // Recupero a posição do toque com referência à minha scene. À minha tela.
        guard let touchLocation = touch?.location(in: self) else { return }
        
        // Procuro saber se existe um node na posição do toque.
        guard let node = self.nodes(at: touchLocation).first else { return }
        
        switch node.name {
            
            //in case of player is dead and want to play again (RESTART GAME)
            case "playAgain" :
            menuNode.removeFromParent()
            player.countLife = 3
            score = 0
            updateScoreLabel()
            player.position = CGPoint(x: (size.width)/2, y: (size.height)*0.15)
            self.addChild(player)
            enemy.isPaused = false
            presentedGameOverNode = false
            
            //not working right
            
        default:
            return
        }
    }
    
    /**
     Método chamado assim que o movimento de um toque é detectado na tela. O "meio" do toque.
     */
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first                                               //gets the first tuch position
        
        guard let touchLocation =  touch?.location(in: self) else { return }    //checks to stop nil values
        
        let location = CGPoint(x: touchLocation.x, y: touchLocation.y)              //sets the location to change only in x axis
        
        let move = SKAction.move(to: location,  duration: 0.15)                  //action to move the player
        
        player.run(move)
    }
    
    /**
     Método chamado assim que um toque deixa de existir na tela. O "fim" do toque.
     */
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    }
    
    /**
     Método chamado assim que um toque é cancelado. Exemplo: uma chamada telefônica interrompe o jogo.
     */
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    /**
     Método chamado até 60 vezes por segundo, em tempo real!
     */
    override func update(_ currentTime: TimeInterval) {
        // Chamado antes de cada frame ser renderizado na tela
        removeEnemyNode()
        updateLifeLabel()
        
        //when player dies, this function pause nodes and present gameOverNode
        isPlayerAlive()
    }
    
    func createEnemy(){
        
        //GENERATION OF ENEMIES
        let createEnemy = SKAction.run {
            let xPosition = CGFloat.random(in: self.size.width*0.08...self.size.width*0.92)
            let yPosition = CGFloat(self.size.height*1)
            let enemy = self.enemy.createEnemy(spriteName: "green", position: CGPoint(x: xPosition, y: yPosition))
            self.addChild(enemy)
        }
        
        let waitInBetween = SKAction.wait(forDuration: (TimeInterval.random(in: 0.55...1.5)))
        
        let sequence = SKAction.sequence([createEnemy, waitInBetween])
        
        let repeatForever = SKAction.repeatForever(sequence)
        
        self.run(repeatForever, withKey: "createEnemy")
    }
    
    /**
     Cria o sprite de background e o insere diretamente na nossa scene. Ele recebe um parâmetro de posição (X e Y).
     */
    func createBackground(with position: CGPoint) {
        
        for i in 0...3 {
            // Declaro minha constante de background. Um Sprite que vem do arquivo Background.png
            let background = SKSpriteNode(imageNamed: "Starfield2.png")
            
            background.name = ("background")
            // Insiro a Posição (X, Y) ao meu node.
            background.position = position
            background.position.y = position.y * CGFloat(i)
            
            background.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!)
            
            // A ZPosition (posição Z [profundidade]) é definida. Por ser um background, ele ficará atrás de tudo.
            background.zPosition = -1
            
            // Altero diretamente a escala X e Y (largura e altura) do nosso background para 275% do tamanho original
            background.setScale(2.0)
            
            // Retiro o Anti-Aliasing (redutor de serrilhado [por ser pixel art])
            //background.texture?.filteringMode = .nearest
            
            // Adiciono meu sprite (background) como filho da cena, para ele ser renderizado.
            self.addChild(background)
        }
    
    }
     
    //moves background
    func moveBackground(){
        self.enumerateChildNodes(withName: "background") { node, Error in
            node.position.y -= 2

            if node.position.y < -(self.scene?.size.height)!{
                node.position.y += (self.scene?.size.height)! * 3
            }

        }
    }
    
    //create wall that makes contact with player and enemies
    func createWalls(){
        let wallLeft = SKPhysicsBody(edgeFrom: CGPoint(x: 0, y: 0), to: CGPoint(x: 0, y: (self.scene?.size.height)!))
        let wallRight = SKPhysicsBody(edgeFrom: CGPoint(x: (self.scene?.size.width)!, y: 0), to: CGPoint(x: (self.scene?.size.width)!, y: (self.scene?.size.height)!))
        
        wallLeft.isDynamic = false
        wallRight.isDynamic = false
        
        let leftWall = SKSpriteNode()
        leftWall.physicsBody = wallLeft
        
        let rightWall = SKSpriteNode()
        rightWall.physicsBody = wallRight
        
        self.addChild(leftWall)
        self.addChild(rightWall)
    }
    
    //set scoreLabel patterns
    func createScoreLabel(with position: CGPoint){
        scoreLabel.text = "\(score)"
        scoreLabel.fontSize = 50
        scoreLabel.fontColor = .white
        scoreLabel.position = position
        scoreLabel.zPosition = 10
        
        self.addChild(scoreLabel)
    }
    
    //set lifeLabel patterns
    func createLifeLabel(with position: CGPoint){
        lifeLabel.text = "♥️ ♥️ ♥️"
        lifeLabel.fontSize = 25
        lifeLabel.fontColor = .white
        lifeLabel.position = position
        lifeLabel.zPosition = 10
        
        self.addChild(lifeLabel)
    }
    
    //updates lifeLabel checking the countLife of player
    func updateLifeLabel(){
        
        if player.countLife == 3 {
            lifeLabel.text = "♥️ ♥️ ♥️"
        }else if player.countLife == 2{
            lifeLabel.text = "♥️ ♥️"
        }else if player.countLife == 1{
            lifeLabel.text = "♥️"
        }else{
            lifeLabel.text = "Lose"
        }
    }
    
    //update scoreLabel
    func updateScoreLabel(){
        self.scoreLabel.text = ("\(score)")
    }
    
    //remove an enemy that collides with player or goes out the scene or removes all enemies when player dies
    func removeEnemyNode(){
        
        //if let enemy = childNode(withName: "enemy"){
        self.enumerateChildNodes(withName: "enemy") { node, Error in
            
            if(self.player.countLife == 0){
                node.removeFromParent()
            }

            if (node.intersects(self) == false) {
                node.removeFromParent()
                self.score += 1
                self.updateScoreLabel()
            }
            
            if node.intersects(self.player){
                node.removeFromParent()
                self.player.countLife -= 1
            }
        }
    }
    
    //check if player is alive and present gameOverNode
    func isPlayerAlive(){
        if(player.countLife == 0 && !presentedGameOverNode){
            self.addChild(menuNode)
            presentedGameOverNode = true
            player.removeFromParent()
            enemy.isPaused = true
            
            if let action = self.action(forKey: "createEnemy") {
                action.speed = 0
            }
            
        }else if(player.countLife != 0){
            moveBackground()
            
            if let action = self.action(forKey: "createEnemy") {
                    action.speed = 1
            }
        }
    }
    
    /************************************************
    // MARK: Other. Não será utilizado em nossa aula.
    ************************************************/
    
//    private lazy var explosionTextures: [SKTexture] = {
//        return self.getExplosionTextures()
//    }()
//    /*
//    lazy var windTextures: [SKTexture] = {
//        return self.getWindTextures()
//    }()
//    */
//    lazy var explosionSoundAction: SKAction = {
//        return SKAction.playSoundFileNamed("explosion_sound.wav", waitForCompletion: false)
//    }()
    
    func setPhysicsUp() {
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -6.8)
    }
    
//    func startWorldEvents(with sceneSize: CGSize) {
//        // Crio uma explosão. Esse método não faz parte da aula.
//        self.createExplosion(position: CGPoint(x: sceneSize.width/2, y: sceneSize.height/2))
//        //self.startWind(range: sceneSize)
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

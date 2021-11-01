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
    let scoreLabel = SKLabelNode(fontNamed: "HelveticaNeue-CondensedBold")
    let lifeLabel = SKLabelNode(fontNamed: "HelveticaNeue-CondensedBold")
    var score: Int
    
    // First method called when scene is initialized
    override init(size: CGSize) {
        self.player = Player(spriteName: "Astronaut1", position: CGPoint(x: (size.width)/2, y: (size.height)*0.15))
        self.enemy = Enemy()
        self.score = 0
        
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
        
        //enemyController.generateEnemy(timePerEnemy: 1, width: self.size.width, height: self.size.height, "green")
        
        //GENERATION OF ENEMIES
        let createEnemy = SKAction.run {
            let xPosition = CGFloat.random(in: self.size.width*0.08...self.size.width*0.92)
            let yPosition = CGFloat(self.size.height*1)
            //print to discover the value of y point on scene
            //print((self.scene?.size.height)!)
            let enemy = self.enemy.createEnemy(spriteName: "green", position: CGPoint(x: xPosition, y: yPosition))
            self.addChild(enemy)
        }
        
        let waitInBetween = SKAction.wait(forDuration: (TimeInterval.random(in: 0.55...1.5)))
        
        let sequence = SKAction.sequence([createEnemy, waitInBetween])
        
        let repeatForever = SKAction.repeatForever(sequence)
        
        self.run(repeatForever)
    }
    
    /**
     Método chamado assim que um toque é detectado na tela. O começo do toque.
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // Recupero a referência para o toque
        //let touch = touches.first
        
        // Recupero a posição do toque com referência à minha scene. À minha tela.
        //guard let touchLocation = touch?.location(in: self) else { return }
        
        // Procuro saber se existe um node na posição do toque.
        //guard let node = self.nodes(at: touchLocation).first else { return }
        
        
    }
    
    /**
     Método chamado assim que o movimento de um toque é detectado na tela. O "meio" do toque.
     */
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first                                               //gets the first tuch position
        //let previousPos = CGPoint(x: player.position.x, y: player.position.y)   //previous position of the player used to calculate the angle of rotation.
        
        guard let touchLocation =  touch?.location(in: self) else { return }    //checks to stop nil values
        
        let location = CGPoint(x: touchLocation.x, y: touchLocation.y)              //sets the location to change only in x axis
        
        let move = SKAction.move(to: location,  duration: 0.5)                  //action to move the player
        
        //let rotationAction = player.calculateAngle(playerPos: location.x, previousPlayerPos: previousPos)  //action to rotate the player accordingly to the direction
        
        //let group = SKAction.group([move, rotationAction])                      //creates a group of action since they start at the same time
        
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
        moveBackground()
        //this func removes the bombs that were not destroyed from scene
        removeEnemyNode()
        
        updateLifeLabel()
    }
    
    // MARK: Elements
    
    
    
    
    
    
    /**
     Cria o sprite de background e o insere diretamente na nossa scene. Ele recebe um parâmetro de posição (X e Y).
     */
    func createBackground(with position: CGPoint) {
        
        for i in 0...3 {
            // Declaro minha constante de background. Um Sprite que vem do arquivo Background.png
            let background = SKSpriteNode(imageNamed: "Starfield2.png")
            
            background.name = "background"
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
        
    func moveBackground(){
        self.enumerateChildNodes(withName: "background") { node, Error in
            node.position.y -= 2

            if node.position.y < -(self.scene?.size.height)!{
                node.position.y += (self.scene?.size.height)! * 3
            }

        }
    }
    
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
    
    //func to create the score label
    func createScoreLabel(with position: CGPoint){
        
        scoreLabel.text = "\(score)"
        scoreLabel.fontSize = 50
        scoreLabel.fontColor = .white
        scoreLabel.position = position
        scoreLabel.zPosition = 10
        
        self.addChild(scoreLabel)
    }
    
    //func to create the score label
    func createLifeLabel(with position: CGPoint){
        
        lifeLabel.text = "♥️ ♥️ ♥️"
        lifeLabel.fontSize = 25
        lifeLabel.fontColor = .white
        lifeLabel.position = position
        lifeLabel.zPosition = 10
        
        self.addChild(lifeLabel)
    }
    
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
    
    func updateScoreLabel(){
        
        self.scoreLabel.text = ("\(score)")
    }
    
    //func to remove bomb from scene if it wasn`t destroyed
    func removeEnemyNode(){
        if let enemy = childNode(withName: "enemy"){
            if enemy.intersects(self) == false || enemy.intersects(player){
                enemy.removeFromParent()
            }
            if enemy.intersects(self) == false {
                self.score += 1
                updateScoreLabel()
            }
            
            if enemy.intersects(player){
                player.countLife -= 1
            }
        }
    }
    
    /**
     Nosso método criador de uma bomba. Ele recebe como parâmetro uma posição (CGPoint).
     */
//    func createEnemy(position: CGPoint) {
//        
//        // Crio um novo node do tipo Sprite, com base na imagem Bomb_1.png 💣
//        let enemy = SKSpriteNode(imageNamed: "green.png")
//        
//        // Defino o tamanho do meu sprite como 75% do tamanho original
//        enemy.setScale(0.22)
//        
//        // Insiro a Posição (X, Y) ao meu node.
//        //bomb.position = CGPoint(x: size.width/2, y: size.height*0.5)
//        enemy.position = position
//        
//        // Defino um nome para minha bomba dentro da cena para fácil acesso posteriormente
//        enemy.name = "enemy"
//        
//        // A ZPosition (posição Z [profundidade]) é definida. Por ser uma bomba, ele ficará na frente do background.
//        enemy.zPosition = 1
//        
//        // Configuro a sprite para passar a receber interações de física.
//        enemy.setupDefaultPhysicsBody()
//        //enemy.physicsBody?.categoryBitMask = enemyCategory
//        // Adiciono minha bomba à minha cena (ela vira filha da minha cena)
//        self.addChild(enemy)
//
//        // Aplico uma ação de impulso para minha bomba (usando nosso sistema de física 😎)
//        self.applyImpulseTo(node: enemy)
//    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
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

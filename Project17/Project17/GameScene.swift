//
//  GameScene.swift
//  Project17
//
//  Created by Vishrut Vatsa on 19/04/21.
//

import SpriteKit

var starfield: SKEmitterNode!
var player: SKSpriteNode!


let possibleEnemies = ["ball","hammer","tv"]
var isGameOver = false
var gameTimer: Timer?
var gameOverLabel:SKLabelNode?

var timerLoop = 0
var timerInterval: Double = 1

var newGameLabel: SKLabelNode?
var scoreLabel: SKLabelNode!
var score = 0 {
    didSet {
        scoreLabel.text = "Score: \(score)"
    }
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        
        starfield = SKEmitterNode(fileNamed: "starfield")!
        starfield.position = CGPoint(x:1024, y:384)
        starfield.advanceSimulationTime(10)
        addChild(starfield)
        starfield.zPosition = -1
        
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x:100, y:384)
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.contactTestBitMask = 1
        addChild(player)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x:16, y:16)
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)
        
        score = 0
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
        
        
        
        
        
    }
    
    @objc func createEnemy() {
        
        guard let enemy = possibleEnemies.randomElement() else {return}
        let sprite = SKSpriteNode(imageNamed: enemy)
        
        sprite.position = CGPoint(x: 1200, y:Int.random(in: 50...736))
        addChild(sprite)
        
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.categoryBitMask = 1
        sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
        sprite.physicsBody?.angularDamping = 0
        sprite.physicsBody?.linearDamping = 0
        sprite.physicsBody?.angularVelocity = 5
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        for node in children {
            if node.position.x < -300 {
                node.removeFromParent()
            }
        }
     
        if !isGameOver {
            score += 1
        }
    
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {return}
        var location = touch.location(in: self)
        
        
        //making scorelabel overlap the game and same on the top to maintain symmetry
        
        if location.y < 100 {
            location.y = 100
        } else if location.y > 668 {
            location.y = 668
        }
        player.position = location
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let explosion = SKEmitterNode(fileNamed: "explosion")!
        explosion.position = player.position
        addChild(explosion)
        
        player.removeFromParent()
        
        isGameOver = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
       
        
        if !isGameOver {
            gameOver()
            return
        }
        
        //restart game option
        
        let location = touch.location(in: self)
        let objects = nodes(at: location)
        for object in objects {
            if object.name == "NewGame" {
                newGame()
            }
        }
    }
    
    func gameOver() {
           let explosion = SKEmitterNode(fileNamed: "explosion")!
           explosion.position = player.position
           addChild(explosion)
           
           player.removeFromParent()
           isGameOver = true
           
           // challenge 3
           gameTimer?.invalidate()
           
           // bonus: restart game option
           gameOverLabel = SKLabelNode(fontNamed: "Chalkduster")
           gameOverLabel?.position = CGPoint(x: 512, y: 384)
           gameOverLabel?.zPosition = 1
           gameOverLabel?.fontSize = 48
           gameOverLabel?.horizontalAlignmentMode = .center
           gameOverLabel?.text = "GAME OVER"
           addChild(gameOverLabel!)

           newGameLabel = SKLabelNode(fontNamed: "Chalkduster")
           newGameLabel?.position = CGPoint(x: 512, y: 324)
           newGameLabel?.zPosition = 1
           newGameLabel?.fontSize = 32
           newGameLabel?.horizontalAlignmentMode = .center
           newGameLabel?.text = "New Game"
           newGameLabel?.name = "NewGame"
           addChild(newGameLabel!)
       }
    
    func newGame() {
            guard isGameOver else { return }
            
            score = 0
            timerLoop = 0
            timerInterval = 1

            isGameOver = false
            
            if let gameOverLabel = gameOverLabel {
                gameOverLabel.removeFromParent()
            }
            if let newGameLabel = newGameLabel {
                newGameLabel.removeFromParent()
            }
            
            // remove remaining enemies
            for node in children {
                if node.name == "Enemy" {
                    node.removeFromParent()
                }
            }
            
            player.position = CGPoint(x: 100, y: 384)
            addChild(player)

            gameTimer = Timer.scheduledTimer(timeInterval: timerInterval, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)

        }
    
    
    
}

//
//  GameOverScene.swift
//  Karojiha
//
//  Created by Jina Park on 11/17/17.
//  Copyright © 2017 Macalester College. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene, SKPhysicsContactDelegate {
    
    let background = Background()
    var sound: Bool = true
    let music = Sound()
    
    let buttons = Buttons()
    
    init(size: CGSize, score: Int, fliesCount: Int) {
        
        super.init(size: size)
        
        //Set up background
        background.scene = self
        backgroundColor = SKColor.black
        background.createParallax()
        
        //Adds and loops the background sound
        self.addChild(music.backgroundSound1)
        music.backgroundSound1.autoplayLooped = true
        
        buttons.scene = self
        buttons.addRestartButton()
        buttons.addHomeButton(position: CGPoint(x: size.width/10, y: size.height/1.05))
        buttons.addSoundButton(position: CGPoint(x: size.width/3.8, y: size.height/1.05))
        
        
        let highScoreDefault = UserDefaults.standard
        var highScore = highScoreDefault.integer(forKey: "highScore")
        
        
        //Label for new high score
        let newHighScoreLabel = SKLabelNode(fontNamed: "Avenir-Light")
        newHighScoreLabel.text = "(New High Score)"
        newHighScoreLabel.fontSize = 15
        newHighScoreLabel.fontColor = SKColor.green
        newHighScoreLabel.position = CGPoint(x: size.width/2, y: size.height/1.65)
        newHighScoreLabel.zPosition = 10
        
        // If score is higher than highScore, change highScore to current score.
        if (score > highScore) {
            highScore = score
            highScoreDefault.setValue(highScore, forKey: "highScore")
            highScoreDefault.synchronize()
            addChild(newHighScoreLabel)
        }


        //Creates game over label
        let message = "Game Over"
        let gameOverLabel = SKLabelNode(fontNamed: "AvenirNextCondensed-DemiBold")
        gameOverLabel.text = message
        gameOverLabel.fontSize = 60
        gameOverLabel.fontColor = SKColor.white
        gameOverLabel.position = CGPoint(x: size.width/2, y: size.height/1.4)
        gameOverLabel.zPosition = 10
        addChild(gameOverLabel)
        
        //Creates score label from the past game.
        let scoreLabel = SKLabelNode(fontNamed: "Avenir-Light")
        scoreLabel.text = "Current Elevation: \(score) ft"
        scoreLabel.fontSize = 23
        scoreLabel.fontColor = SKColor.yellow
        scoreLabel.position = CGPoint(x: size.width/2, y: size.height/1.55)
        scoreLabel.zPosition = 10
        addChild(scoreLabel)
        
        //Creates label for highest score.
        let highScoreLabel = SKLabelNode(fontNamed: "Avenir-Light")
        highScoreLabel.fontSize = 25
        highScoreLabel.text = "Record: \(highScore) ft"
        highScoreLabel.fontColor = SKColor.orange
        highScoreLabel.position = CGPoint(x: size.width/2, y: size.height/9)
        highScoreLabel.zPosition = 10
        addChild(highScoreLabel)

    }
    
    //Takes you back to the GameScene when you touch the restart button
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            if buttons.restartBtn.contains(location) {
                run(music.buttonClickSound)
                let reveal = SKTransition.fade(withDuration: 0.5)
                let gameScene = GameScene(size: size)
                self.view?.presentScene(gameScene, transition: reveal)
            } else if buttons.homeBtn.contains(location) {
                run(music.buttonClickSound)
                let reveal = SKTransition.fade(withDuration: 0.5)
                let scene = MenuScene(size: size)
                self.view?.presentScene(scene, transition: reveal)
            } else if buttons.soundBtn.contains(location) {
                if sound {
                    buttons.soundBtn.texture = SKTexture(imageNamed: "soundOffButtonSmallSquare")
                    sound = false
                    music.backgroundSound1.run(SKAction.stop())
                } else {
                    buttons.soundBtn.texture = SKTexture(imageNamed: "soundButtonSmallSquare")
                    sound = true
                    music.backgroundSound1.run(SKAction.play())
                }
            }
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


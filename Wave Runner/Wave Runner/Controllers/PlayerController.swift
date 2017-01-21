//
//  PlayerController.swift
//  Wave Runner
//
//  Created by Duy Anh on 1/21/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import Foundation
import SpriteKit

class PlayerController: SingleControler {
    var player: View!
    var board: SKSpriteNode!
    var attacking : Bool = false
    var lightNode: SKLightNode!
    
    var attackAnimation = SKTextureAtlas(named: "goku_attack").toTextures()
    var laserAnimation = SKTextureAtlas(named: "goku_laser").toTextures()
    
    init() {
        super.init(view: View())
        self.player = View(image: #imageLiteral(resourceName: "goku_standing"))
        self.board = SKSpriteNode(image: #imageLiteral(resourceName: "hover_board"))
        
        view.addChild(player)
        view.addChild(board)
        view.setScale(3)
        view.zPosition = 3
        
        player.position = CGPoint(x: 10.05, y: 24.5)
        
        player.physicsBody = SKPhysicsBody(rectangleOf: player.frame.size.scale(by: 0.9))
        player.physicsBody?.categoryBitMask = Masks.PLAYER
        player.physicsBody?.collisionBitMask = 0
        
        lightNode = SKLightNode()
        lightNode.categoryBitMask = 1
        lightNode.falloff = 4
        player.addChild(lightNode)
    }
    
    override func config(position: CGPoint, parent: SKNode) {
        super.config(position: position, parent: parent)
        
        player.run(.repeatForever(.sequence([.run({
            self.fireLaser()
        }), SKAction.wait(forDuration: 3)])))
    }
    
    func fireLaser() {
        var anim = laserAnimation
        anim.append(SKTexture(image: #imageLiteral(resourceName: "goku_standing")))
        
        let animateAction = SKAction.animate(with: anim, timePerFrame: 0.1, resize: true, restore: false)
        let shootAction = SKAction.run { [unowned self] in
            let laser = LaserController(type: .straight)
            laser.config(position: CGPoint(x: laser.laser.width/2 + self.player.width*3/4, y: 0), parent: self.player)
            laser.move(speed: 1200)
        }
        let delay = SKAction.wait(forDuration: 0.2)
        let sequence = SKAction.sequence([delay, shootAction])
            
        player.run(.group([animateAction, sequence]))
    }


func attack() {
    if !attacking {
        var anim = attackAnimation
        anim.append(player.texture!)
        attacking = true
        let animateAction = SKAction.animate(with: anim, timePerFrame: 0.15, resize: true, restore: false)
        let endAttack = SKAction.run {
            self.attacking = false
        }
        self.player.run(.sequence([animateAction, endAttack]))
        self.kame()
    }
}


func kame() -> Void {
    let kameAction = SKAction.run{
        let waveController = WaveController.createWaveRight()
        waveController.config(position: self.view.position.add(other: self.player.position.multiply(factor: PLAYER_SCALE)), parent: self.parent)
    }
    
    self.view.run(.repeat(.sequence([kameAction, .wait(forDuration: 0.1)]), count: 3))
}
}

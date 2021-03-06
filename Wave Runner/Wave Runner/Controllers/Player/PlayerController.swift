//
//  PlayerController.swift
//  Wave Runner
//
//  Created by Duy Anh on 1/21/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import Foundation
import SpriteKit

enum AttackType {
    case SONIC
    case LAZER
    case PUSH
    case PULL
    case SHIELD
}

class PlayerController: SingleControler {
    var player: View!
    var board: SKSpriteNode!
    var attacking : Bool = false
    
    var lightNode: SKLightNode!
    
    
    let laserSkill = LaserSkill()
    let gravity = GravitySkill()
    let sonicSkill = SonicSkill()
    let shieldSkill = ShieldSkill()
    
    var lightController : LightController!
    
    var screamSound: SKAction!
    
    static var instance: PlayerController!
    
    var center : CGPoint {
        return self.view.position.add(other: self.player.position.multiply(factor: PLAYER_SCALE))
    }
    
    init() {
        super.init(view: View())
        self.player = View(image: #imageLiteral(resourceName: "goku_standing"))
        self.board = SKSpriteNode(image: #imageLiteral(resourceName: "hover_board"))
        
        view.addChild(player)
        view.addChild(board)
        view.setScale(3)
        view.zPosition = 3
        
        player.position = CGPoint(x: 10.05, y: 24.5)
        
        lightNode = SKLightNode()
        lightNode.categoryBitMask = 1
        lightNode.falloff = 4
        lightNode.isEnabled = false
        player.addChild(lightNode)
        
        lightController = LightController(jsonFile: "light")
        lightController.lightNode = self.lightNode
        
        configPhysics()
        
        screamSound = SKAction.playSoundFileNamed("player_scream.mp3", waitForCompletion: false)
    }
    
    @objc
    func activeShield() {
        shieldSkill.activeShield()
    }
    
    func configPhysics() -> Void {
        player.physicsBody = SKPhysicsBody(rectangleOf: player.frame.size.scale(by: 0.9))
        player.physicsBody?.categoryBitMask = Masks.PLAYER
        player.physicsBody?.contactTestBitMask = Masks.ENEMY | Masks.ENEMY_MISSLE
        player.physicsBody?.collisionBitMask = 0
        player.physicsBody?.fieldBitMask = 0
        
        player.handleContact = {
            other in
            if (other.physicsBody?.categoryBitMask)! & (Masks.ENEMY | Masks.ENEMY_MISSLE) != 0 {
                self.destroy()
            }
        }
    }
    
    override func run(parent: SKNode, time: TimeInterval) {
        super.run(parent: parent, time: time)
        lightController.run(parent: parent, time: time)
    }
    
    override func config(position: CGPoint, parent: SKNode) {
        super.config(position: position, parent: parent)
        laserSkill.playerController = self
        sonicSkill.playerController = self
        gravity.playerController = self
        shieldSkill.playerController = self
    }
    
    func shootLaser(at dest: CGPoint) {
        laserSkill.spawn(aimAt: dest)
    }
    
    override func destroy() {
        self.lightNode.isEnabled = false
        self.parent.run(.sequence([screamSound, .wait(forDuration: 0.5)])) {
                super.destroy()
                print("Player destroying")
        }
    }
    
    @objc
    func pushEnemies() {
       gravity.pushEnemies()
    }
    
    @objc
    func createGravityField() {
        gravity.createField()
    }
    
    @objc
    func sonicAttack() {
        sonicSkill.createWaves()
    }
}

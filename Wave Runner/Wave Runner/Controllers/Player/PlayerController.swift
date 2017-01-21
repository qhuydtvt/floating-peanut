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
    
    static let instance = PlayerController()
    
    var center : CGPoint {
        return self.view.position.add(other: self.player.position.multiply(factor: PLAYER_SCALE))
    }
    
    private init() {
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
        player.addChild(lightNode)
        
        
        
        configPhysics()
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
            print("Contacted")
        }
    }
    
    override func config(position: CGPoint, parent: SKNode) {
        super.config(position: position, parent: parent)
    }
    
    func shootLaser(at dest: CGPoint) {
        laserSkill.spawn(aimAt: dest)
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

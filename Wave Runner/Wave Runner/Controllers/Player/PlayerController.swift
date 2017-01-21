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
}

class PlayerController: SingleControler {
    var player: View!
    var board: SKSpriteNode!
    var attacking : Bool = false
    
    var lightNode: SKLightNode!
    var attackAnimation = SKTextureAtlas(named: "goku_attack").toTextures()
    
    let laserSkill = LaserSkill()
    
    let gravity = GravityFieldController()
    static let instance = PlayerController()
    
    private init() {
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
        player.physicsBody?.fieldBitMask = 0
        
        lightNode = SKLightNode()
        lightNode.categoryBitMask = 1
        lightNode.falloff = 4
        player.addChild(lightNode)
    }
    
    override func config(position: CGPoint, parent: SKNode) {
        super.config(position: position, parent: parent)
    }
    
    @objc
    func fireUpwardLaser() {
        laserSkill.spawn(type: .upward)
    }
    
    @objc
    func fireStraightLaser() {
        laserSkill.spawn(type: .straight)
    }
    
    func attack(attackType: AttackType) -> Void {
        if !attacking {
            switch attackType {
            case AttackType.SONIC:
                sonicAttack()
            case AttackType.LAZER: break
            default:
                break
            }
        }
    }
    
    @objc
    func pushEnemies() {
        gravity.gravityNode.removeFromParent()
        for enemy in EnemyControllerManager.shared.enemies {
            enemy.view.physicsBody?.velocity = CGVector(dx: 1200, dy: 0)
        }
    }
    
    @objc
    func createGravityField() {
        guard gravity.gravityNode.parent == nil else { return }
        let position = self.view.position.add(other: self.player.position.multiply(factor: 3)).add(dx: 150, dy: 0)
        gravity.config(position: position, parent: self.parent)
        
        for enemy in EnemyControllerManager.shared.enemies {
            enemy.view.physicsBody?.velocity = .zero
            let constraint = SKConstraint.positionX(SKRange(lowerLimit: position.x-20, upperLimit: .infinity))
            enemy.view.constraints = [constraint]
        }
        
        parent.run(.sequence([.wait(forDuration: 2),.run { [unowned self] in
            self.gravity.gravityNode.removeFromParent()
            }]))
    }
    
    @objc
    func sonicAttack() {
        guard attacking == false else { return }
        
        var anim = attackAnimation
        anim.append(SKTexture(image: #imageLiteral(resourceName: "goku_standing")))
        attacking = true
        let animateAction = SKAction.animate(with: anim, timePerFrame: 0.15, resize: true, restore: false)
        let endAttack = SKAction.run { [unowned self] in
            self.attacking = false
        }
        
        self.player.run(.sequence([animateAction, endAttack]))
        for _ in 0..<2 {
            self.scan(angle: CGFloat(M_PI_4 / 2))
            self.scan(angle: 0)
            self.scan(angle: -CGFloat(M_PI_4 / 2))
        }
    }
    
    func scan(angle: CGFloat) -> Void {
        let kameAction = SKAction.run { [unowned self] in
            let waveController = WaveController.create(angle: angle)
            waveController.config(position: self.view.position.add(other: self.player.position.multiply(factor: PLAYER_SCALE)), parent: self.parent)
        }
        
        self.view.run(.repeat(.sequence([kameAction, .wait(forDuration: 0.1)]), count: 3))
    }
}

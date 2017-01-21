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
    
    var attackAnimation = SKTextureAtlas(named: "goku_attack").toTextures()
    var laserStraightAnimation = SKTextureAtlas(named: "goku_laser_straight").toTextures()
    var lightNode: SKLightNode!
    var laserUpwardAnimation = SKTextureAtlas(named: "goku_laser_upward").toTextures()
    
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
        lightNode.isEnabled = false
        player.addChild(lightNode)
    }
    
    var center : CGPoint {
        return self.view.position.add(other: self.player.position.multiply(factor: PLAYER_SCALE))
    }
    
    override func config(position: CGPoint, parent: SKNode) {
        super.config(position: position, parent: parent)
    }
    
    func attack() {
        if !attacking {
            var anim = attackAnimation
            anim.append(player.texture!)
            attacking = true
            let animateAction = SKAction.animate(with: anim, timePerFrame: PLAYER_ANIMATION_TIME_FER_FRAME, resize: true, restore: false)
            let endAttack = SKAction.run {
                self.attacking = false
            }
            self.player.run(.sequence([animateAction, endAttack]))
            //            self.scan()
        }
    }
    
    @objc
    func fireUpwardLaser() {
        var anim = laserUpwardAnimation
        anim.append(SKTexture(image: #imageLiteral(resourceName: "goku_standing")))
        
        let animateAction = SKAction.animate(with: anim, timePerFrame: 0.1, resize: true, restore: false)
        let shootAction = SKAction.run { [unowned self] in
            let laser = LaserController(type: .upward)
            laser.config(position: CGPoint(x: laser.laser.width/2.5 + self.player.width/3, y: laser.laser.width / 4.2), parent: self.player)
            laser.move(speed: 1200)
        }
        let delay = SKAction.wait(forDuration: 0.2)
        let sequence = SKAction.sequence([delay, shootAction])
        player.run(.group([animateAction, sequence]))
    }
    
    @objc
    func fireStraightLaser() {
        var anim = laserStraightAnimation
        anim.append(SKTexture(image: #imageLiteral(resourceName: "goku_standing")))
        
        let animateAction = SKAction.animate(with: anim, timePerFrame: 0.1, resize: true, restore: false)
        let shootAction = SKAction.run { [unowned self] in
            let laser = LaserController(type: .straight)
            laser.config(position: CGPoint(x: laser.laser.width/2 + self.player.width/3, y: -0.5), parent: self.player)
            laser.move(speed: 1200)
        }
        let delay = SKAction.wait(forDuration: 0.2)
        let sequence = SKAction.sequence([delay, shootAction])
        player.run(.group([animateAction, sequence]))
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
            waveController.config(position: self.center, parent: self.parent)
        }
        
        self.view.run(.repeat(.sequence([kameAction, .wait(forDuration: 0.1)]), count: 3))
    }
}

//
//  EnemyController.swift
//  Wave Runner
//
//  Created by Apple on 1/21/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import SpriteKit

enum EnemyState {
    case NORMAL
    case ATTACKING
}

class EnemyController : SingleControler {
    var lastTimeUpdate : Double = -1
    var enemyState: EnemyState = EnemyState.NORMAL
    var attackTime: Int = 0
//    var textures = SKTextureAtlas(named: "enemy_1").toTextures()
    var textures: [SKTexture]!
    
    init(textures: [SKTexture]) {
        super.init(view: View(texture: textures[0]))
        self.textures = textures
    }
    
    override func config(position: CGPoint, parent: SKNode) {
        super.config(position: position, parent: parent)
        
        self.view.zPosition = 10
        //view.run(.moveTo(x: 0, duration: 5))
        view.physicsBody = SKPhysicsBody(rectangleOf: view.size)
        view.physicsBody?.collisionBitMask = 0
        view.physicsBody?.velocity = CGVector(dx: -Speed.ENEMY_VELOCITY, dy: 0)
        view.physicsBody?.linearDamping = 0
//        view.physicsBody?.affectedByGravity = false
        
        let animateAction = SKAction.animate(with: textures, timePerFrame: 0.15, resize: true, restore: false)
        
        self.view.run(.repeatForever(animateAction))
    }
    
    override func run(parent: SKNode, time: TimeInterval) {
        super.run(parent: parent, time: time)
        
        if self.view.position.x < 0 {
            self.view.removeFromParent()
        }
        
        if lastTimeUpdate == -1 {
            lastTimeUpdate = time
        }
        
        let delta = time - lastTimeUpdate
        
        switch self.enemyState {
        case EnemyState.NORMAL:
            if delta > 1 {
                self.enemyState = EnemyState.ATTACKING
                self.lastTimeUpdate = time
                self.attackTime = 0
            }
            break
        case EnemyState.ATTACKING:
            if (delta > 0.2) {
                self.attack()
                attackTime += 1
                lastTimeUpdate = time
                if (attackTime > 3) {
                    self.enemyState = EnemyState.NORMAL
                }
            }
            break
        }
    }
    
    func attack() -> Void {
//        let waveController = WaveController.createWaveLeft()
//        waveController.config(position: self.position, parent: self.parent)
    }
    
    static func create(type: Int) -> EnemyController {
        if type == 1 {
            return EnemyController(textures: SKTextureAtlas(named: "enemy_1").toTextures())
        } else if type == 2 {
            return EnemyController(textures: SKTextureAtlas(named: "enemy_4").toTextures())
        }
        return EnemyController(textures: SKTextureAtlas(named: "enemy_1").toTextures())
    }
}

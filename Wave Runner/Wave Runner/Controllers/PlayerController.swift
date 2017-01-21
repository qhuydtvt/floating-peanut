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
    
    func attack(attackType: AttackType) -> Void {
        if !attacking {
            var anim = attackAnimation
            anim.append(player.texture!)
            attacking = true
            let animateAction = SKAction.animate(with: anim, timePerFrame: 0.15, resize: true, restore: false)
            let endAttack = SKAction.run {
                self.attacking = false
            }
            
            self.player.run(.sequence([animateAction, endAttack]))
            switch attackType {
            case AttackType.SONIC:
                for _ in 0..<2 {
                    self.scan(angle: CGFloat(M_PI_4 / 2))
                    self.scan(angle: 0)
                    self.scan(angle: -CGFloat(M_PI_4 / 2))
                }
                break
            default:
                break
            }
        }
    }
    
    func scan(angle: CGFloat) -> Void {
        let kameAction = SKAction.run{
            let waveController = WaveController.create(angle: angle)
            waveController.config(position: self.view.position.add(other: self.player.position.multiply(factor: PLAYER_SCALE)), parent: self.parent)
        }
        
        self.view.run(.repeat(.sequence([kameAction, .wait(forDuration: 0.1)]), count: 3))
    }
}

//
//  ShieldSkill.swift
//  Wave Runner
//
//  Created by Duy Anh on 1/22/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import Foundation
import SpriteKit

class ShieldSkill {
    var coolDownTime: Double = CoolDown.SHIELD
    var isCoolingDown = false
    lazy var playerController = PlayerController.instance
    
    func activeShield() {
        guard isCoolingDown == false else { return }
        
        let shield = View(texture: Textures.shield)
        shield.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        shield.physicsBody?.categoryBitMask = Masks.SHIELD
        shield.physicsBody?.contactTestBitMask = Masks.ENEMY | Masks.ENEMY_WAVE
        shield.physicsBody?.collisionBitMask = 0
        shield.physicsBody?.fieldBitMask = 0
        shield.handleContact = {
            other in
            other.destroy?()
            shield.contacted = false
        }
        
        playerController.player.run(.sequence([.wait(forDuration: EffectTime.SHIELD), .run({
            shield.removeFromParent()
        })]))
        playerController.player.run(.sequence([.wait(forDuration: coolDownTime), .run({
            self.isCoolingDown = false
        })]))
        
        playerController.player.addChild(shield)
        self.isCoolingDown = true
        LabelsController.shared.startCountDown(type: .SHIELD)
    }
}

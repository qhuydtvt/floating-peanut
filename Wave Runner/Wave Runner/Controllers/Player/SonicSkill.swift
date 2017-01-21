//
//  SonicSkill.swift
//  Wave Runner
//
//  Created by Duy Anh on 1/21/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import Foundation
import SpriteKit

class SonicSkill {
    var coolDownTime: Double = 1
    var isCoolingDown = false
    lazy var playerController = PlayerController.instance
    
    func createWaves() {
        guard isCoolingDown == false else { return }
        
        var anim = Textures.attackAnimation
        anim.append(SKTexture(image: #imageLiteral(resourceName: "goku_standing")))
        isCoolingDown = true
        let animateAction = SKAction.animate(with: anim, timePerFrame: 0.15, resize: true, restore: false)
        let endAttack = SKAction.run { [unowned self] in
            self.isCoolingDown = false
        }
        
        playerController.player.run(animateAction)
        for _ in 0..<2 {
            self.scan(angle: CGFloat(M_PI_4 / 2))
            self.scan(angle: 0)
            self.scan(angle: -CGFloat(M_PI_4 / 2))
        }
        
        playerController.player.run(.sequence([.wait(forDuration: coolDownTime), endAttack]))
    }
    
    func scan(angle: CGFloat) -> Void {
        let kameAction = SKAction.run { [unowned self] in
            let waveController = WaveController.create(angle: angle)
            waveController.config(position: self.playerController.view.position.add(other: self.playerController.player.position.multiply(factor: PLAYER_SCALE)), parent: self.playerController.parent)
        }
        
        playerController.view.run(.repeat(.sequence([kameAction, .wait(forDuration: 0.1)]), count: 3))
    }
    
}

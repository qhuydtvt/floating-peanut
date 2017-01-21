//
//  PushSkill.swift
//  Wave Runner
//
//  Created by Duy Anh on 1/21/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import Foundation
import SpriteKit

class GravitySkill {
    var coolDownTime: Double = CoolDown.PUSH
    var isCoolingDown = false
    
    var gravityNode: SKFieldNode!
    var parent: SKNode!
    lazy var playerController = PlayerController.instance
    
    init() {
        gravityNode = SKFieldNode.radialGravityField()
        gravityNode.categoryBitMask = 1
        gravityNode.strength = 10
        gravityNode.falloff = 0
    }
    func config(position: CGPoint, parent: SKNode) {
        gravityNode.position = position
        self.parent = parent
        
        let emitter = SKEmitterNode(fileNamed: "GravityEmmiter")!
        gravityNode.addChild(emitter)
        parent.addChild(gravityNode)
    }
    
    func createField() {
        guard !isCoolingDown else { return }
        if self.gravityNode.parent != nil { gravityNode.removeFromParent() }
        
        let position = playerController.view.position.add(other: playerController.player.position.multiply(factor: 3)).add(dx: 300, dy: 0)
        self.config(position: position, parent: playerController.parent)
        
        for enemy in EnemyControllerManager.shared.enemies {
            enemy.view.physicsBody?.velocity = .zero
            let constraint = SKConstraint.positionX(SKRange(lowerLimit: position.x-20, upperLimit: .infinity), y: SKRange(lowerLimit: position.y - 300, upperLimit: position.y + 300))
            enemy.view.constraints = [constraint]
        }
        
        parent.run(.sequence([.wait(forDuration: coolDownTime),.run { [unowned self] in
            self.removeField()
            self.isCoolingDown = false
            }]))
        self.isCoolingDown = true
        LabelsController.shared.startCountDown(type: .PUSH)
    }
    
    func removeField() {
        gravityNode.removeFromParent()
        for enemy in EnemyControllerManager.shared.enemies {
            enemy.view.constraints?.removeAll()
        }
    }
    
    func pushEnemies() {
        guard isCoolingDown == false else { return }
        playerController.gravity.removeField()
        for enemy in EnemyControllerManager.shared.enemies {
            enemy.view.physicsBody?.velocity = CGVector(dx: 1200, dy: 0)
        }
        self.isCoolingDown = true
        DispatchQueue.main.asyncAfter(deadline: .now() + coolDownTime) {
            self.isCoolingDown = false
        }
        LabelsController.shared.startCountDown(type: .PUSH)
    }
}

//
//  PushSkill.swift
//  Wave Runner
//
//  Created by Duy Anh on 1/21/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import Foundation
import SpriteKit

class PushSkill {
    var coolDownTime: Double = 3
    var isCoolingDown = false
    lazy var playerController = PlayerController.instance
    
    func pushEnemies() {
        playerController.gravity.removeField()
        for enemy in EnemyControllerManager.shared.enemies {
            enemy.view.physicsBody?.velocity = CGVector(dx: 1200, dy: 0)
        }
    }
}

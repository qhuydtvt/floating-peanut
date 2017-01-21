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
    var coolDownTime: Double = CoolDown.PUSH
    var isCoolingDown = false
    lazy var playerController = PlayerController.instance
    
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

//
//  LaserController.swift
//  Wave Runner
//
//  Created by Duy Anh on 1/21/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import Foundation
import SpriteKit

enum LaserType {
    case straight, upward, downward
}

class LaserSkill {
    var coolDownTime: Double = 1
    var isCoolingDown = false
    lazy var playerController = PlayerController.instance
    
    func spawn(type: LaserType) {
        guard isCoolingDown == false else { return }
        switch type {
        case .straight:
            var anim = Textures.laserStraightAnimation
            anim.append(SKTexture(image: #imageLiteral(resourceName: "goku_standing")))
            
            let animateAction = SKAction.animate(with: anim, timePerFrame: 0.1, resize: true, restore: false)
            let shootAction = SKAction.run { [unowned self] in
                let laser = LaserController(type: .straight)
                laser.config(position: CGPoint(x: laser.laser.width/2 + self.playerController.player.width/3, y: -0.5), parent: self.playerController.player)
                laser.move(speed: 1200)
            }
            let delay = SKAction.wait(forDuration: 0.2)
            let sequence = SKAction.sequence([delay, shootAction])
            playerController.player.run(.group([animateAction, sequence]))
            
        case .upward:
            var anim = Textures.laserUpwardAnimation
            anim.append(SKTexture(image: #imageLiteral(resourceName: "goku_standing")))
            
            let animateAction = SKAction.animate(with: anim, timePerFrame: 0.1, resize: true, restore: false)
            let shootAction = SKAction.run { [unowned self] in
                let laser = LaserController(type: .upward)
                laser.config(position: CGPoint(x: laser.laser.width/2.5 + self.playerController.player.width/3, y: laser.laser.width / 4.2), parent: self.playerController.player)
                laser.move(speed: 1200)
            }
            let delay = SKAction.wait(forDuration: 0.2)
            let sequence = SKAction.sequence([delay, shootAction])
            playerController.player.run(.group([animateAction, sequence]))
        default: break
        }
        
        self.isCoolingDown = true
        DispatchQueue.main.asyncAfter(deadline: .now() + coolDownTime) {
            self.isCoolingDown = false
        }
    }
}

class LaserController: SingleControler {
    var type: LaserType!
    var cropNode: SKCropNode!
    var laser: View!
    
    init(type: LaserType) {
        super.init(view: View())
        self.type = type
        self.laser = View(image: #imageLiteral(resourceName: "laser"))
        self.cropNode = SKCropNode()
        cropNode.maskNode = SKSpriteNode(image: #imageLiteral(resourceName: "laser"))
        cropNode.addChild(laser)
        view.addChild(cropNode)
        
        laser.position = CGPoint(x: -laser.width, y: 0)
        
        if type == .upward {
            view.zRotation = view.zRotation + CGFloat.pi / 6
        }
    }
    
    override func config(position: CGPoint, parent: SKNode) {
        super.config(position: position, parent: parent)
    }
    
    func move(speed: CGFloat) {
        let distance = laser.width
        let time = distance / speed
        laser.run(.move(by: CGVector(dx: distance, dy: 0), duration: TimeInterval(time))) { [unowned self] in
            self.laser.run(.fadeAlpha(to: 0, duration: 0.15)) {
                self.view.removeFromParent()
            }
        }
    }
}

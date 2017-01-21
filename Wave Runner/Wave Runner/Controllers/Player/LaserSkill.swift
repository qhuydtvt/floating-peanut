//
//  LaserController.swift
//  Wave Runner
//
//  Created by Duy Anh on 1/21/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import Foundation
import SpriteKit

class LaserSkill {
    var coolDownTime: Double = CoolDown.LASER
    var isCoolingDown = false
    weak var playerController: PlayerController!
    var playSound: SKAction!
    
    init() {
        playSound = SKAction.playSoundFileNamed("lazer.mp3", waitForCompletion: false)
    }
    
    func spawn(aimAt dest: CGPoint) {
        guard isCoolingDown == false else { return }
        
        
        var anim = Textures.laserUpwardAnimation
        anim.append(SKTexture(image: #imageLiteral(resourceName: "goku_standing")))
        
        let animateAction = SKAction.animate(with: anim, timePerFrame: 0.05, resize: true, restore: false)
        let shootAction = SKAction.run { [unowned self] in
            let laser = LaserController()
            laser.config(position: .zero, parent: self.playerController.player)
            
            let vector = dest.subtract(other: self.playerController.center)
            if vector.dx > 0 {
            let angle = atan(vector.dy / vector.dx)
            laser.view.zRotation = CGFloat(angle)
            }
            
            laser.move(speed: 1200)
        }
        let delay = SKAction.wait(forDuration: 0.2)
        let sequence = SKAction.sequence([delay, shootAction])
        playerController.player.run(.group([animateAction, sequence]))
        playerController.player.run(playSound)
        
        self.isCoolingDown = true
        DispatchQueue.main.asyncAfter(deadline: .now() + coolDownTime) {
            self.isCoolingDown = false
        }
        LabelsController.shared.startCountDown(type: .LAZER)
    }
}

class LaserController: SingleControler {
    var cropNode: SKCropNode!
    var laser: View!
    
    init() {
        super.init(view: View())
        self.laser = View(image: #imageLiteral(resourceName: "laser"))
        self.cropNode = SKCropNode()
        cropNode.maskNode = SKSpriteNode(image: #imageLiteral(resourceName: "laser"))
        cropNode.addChild(laser)
        view.addChild(cropNode)
        
        cropNode.position = CGPoint(x: laser.width/2, y: 0)
        laser.position = CGPoint(x: -laser.width, y: 0)
        
        configPhysics()
    }
    
    func configPhysics() -> Void {
        self.laser.physicsBody = SKPhysicsBody(rectangleOf: self.laser.size)
        self.laser.physicsBody?.categoryBitMask = Masks.PLAYER_LAZER
        self.laser.physicsBody?.contactTestBitMask = Masks.ENEMY | Masks.ENEMY_MISSLE
        self.laser.physicsBody?.collisionBitMask = 0
        self.laser.lightingBitMask = 0
        
        self.laser.handleContact = { [unowned laser = self.laser!]
            other in
            other.destroy?()
            laser.contacted = false
        }
    }
    
    override func config(position: CGPoint, parent: SKNode) {
        super.config(position: position, parent: parent)
    }
    
    func move(speed: CGFloat) {
        let distance = laser.width
        let time = distance / speed
        laser.run(.move(by: CGVector(dx: distance, dy: 0), duration: TimeInterval(time))) { [unowned self] in
            self.laser.run(.fadeAlpha(to: 0, duration: 0.15)) { [unowned self] in
                self.view.removeFromParent()
            }
        }
    }
}

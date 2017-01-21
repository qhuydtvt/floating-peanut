//
//  LabelsController.swift
//  Wave Runner
//
//  Created by Duy Anh on 1/21/17.
//  Copyright © 2017 Techkids. All rights reserved.
//

import Foundation
import SpriteKit

class LabelsController {
    static var shared: LabelsController!
    let gameScene: SKScene
    
    let fontName = "Times New Roman"
    let fontSize: CGFloat = 68
    let zPosition: CGFloat = 5
    let distanceBetweenLabels: CGFloat = 8
    
    let barSize = CGSize(width: 900, height: 45)
    
    var sonicFill: SKSpriteNode!
    var laserFill: SKSpriteNode!
    var pushFill: SKSpriteNode!
    var pullFill: SKSpriteNode!
    
    init(scene: SKScene) {
        self.gameScene = scene
    }
    
    func startCountDown(type: AttackType) {
        switch type {
        case .LAZER:
            countDown(node: laserFill, duration: CoolDown.LASER)
        case .SONIC:
            countDown(node: sonicFill, duration: CoolDown.SONIC)
        case .PUSH:
            countDown(node: pushFill, duration: CoolDown.PUSH)
        case .PULL:
            countDown(node: pullFill, duration: CoolDown.PULL)
        }
    }
    
    private func countDown(node: SKNode, duration: TimeInterval) {
        node.position = CGPoint.zero.add(dx: -barSize.width, dy: 0)
        node.run(.move(by: CGVector(dx: barSize.width, dy: 0), duration: duration))
    }
    
    func addLabels() {
        let pullLabel = SKLabelNode(fontNamed: fontName)
        pullLabel.fontSize = fontSize
        pullLabel.horizontalAlignmentMode = .left
        pullLabel.verticalAlignmentMode = .bottom
        pullLabel.text = "Pull"
        pullLabel.zPosition = zPosition
        pullLabel.position = CGPoint(x: 8, y: 8)
        gameScene.addChild(pullLabel)
        
        let pullContainer = SKNode()
        let pullUnfill = SKSpriteNode(color: UIColor.init(colorLiteralRed: 53/255, green: 144/255, blue: 63/255, alpha: 1), size: barSize)
        pullFill = SKSpriteNode(color: UIColor.init(colorLiteralRed: 53/255, green: 183/255, blue: 126/255, alpha: 1), size: barSize)
        let pullCrop = SKCropNode()
        pullCrop.maskNode = SKSpriteNode(color: .white, size: barSize)
        pullCrop.addChild(pullFill)
        pullContainer.addChild(pullCrop)
        pullContainer.addChild(pullUnfill)
        pullContainer.position = pullLabel.position.add(dx: 200 + barSize.width / 2, dy: barSize.height / 2)
        pullContainer.zPosition = 5
        pullCrop.zPosition = 1
        
        let pushLabel = SKLabelNode(fontNamed: fontName)
        pushLabel.fontSize = fontSize
        pushLabel.horizontalAlignmentMode = .left
        pushLabel.verticalAlignmentMode = .bottom
        pushLabel.text = "Push"
        pushLabel.zPosition = zPosition
        pushLabel.position = pullLabel.position.add(dx: 0, dy: pullLabel.frame.height + distanceBetweenLabels)
        gameScene.addChild(pushLabel)
        
        let pushContainer = SKNode()
        let pushUnfill = SKSpriteNode(color: UIColor.init(colorLiteralRed: 207/255, green: 193/255, blue: 33/255, alpha: 1), size: barSize)
        pushFill = SKSpriteNode(color: UIColor.init(colorLiteralRed: 222/255, green: 209/255, blue: 119/255, alpha: 1), size: barSize)
        let pushCrop = SKCropNode()
        pushCrop.maskNode = SKSpriteNode(color: .white, size: barSize)
        pushCrop.addChild(pushFill)
        pushContainer.addChild(pushCrop)
        pushContainer.addChild(pushUnfill)
        pushContainer.position = pushLabel.position.add(dx: 200 + barSize.width / 2, dy: barSize.height / 2)
        pushContainer.zPosition = 5
        pushCrop.zPosition = 1
        
        let laserLabel = SKLabelNode(fontNamed: fontName)
        laserLabel.fontSize = fontSize
        laserLabel.horizontalAlignmentMode = .left
        laserLabel.text = "Laser"
        laserLabel.zPosition = zPosition
        laserLabel.position = pushLabel.position.add(dx: 0, dy: pushLabel.frame.height + distanceBetweenLabels)
        gameScene.addChild(laserLabel)
        
        let laserContainer = SKNode()
        let laserUnfill = SKSpriteNode(color: UIColor.init(colorLiteralRed: 123/255, green: 37/255, blue: 114/255, alpha: 1), size: barSize)
        laserFill = SKSpriteNode(color: UIColor.init(colorLiteralRed: 185/255, green: 71/255, blue: 173/255, alpha: 1), size: barSize)
        let laserCrop = SKCropNode()
        laserCrop.maskNode = SKSpriteNode(color: .white, size: barSize)
        laserCrop.addChild(laserFill)
        laserContainer.addChild(laserCrop)
        laserContainer.addChild(laserUnfill)
        laserContainer.position = laserLabel.position.add(dx: 200 + barSize.width / 2, dy: barSize.height / 2)
        laserContainer.zPosition = 5
        laserCrop.zPosition = 1
        
        gameScene.addChild(laserContainer)
        
        let sonicLabel = SKLabelNode(fontNamed: fontName)
        sonicLabel.fontSize = fontSize
        sonicLabel.horizontalAlignmentMode = .left
        sonicLabel.text = "Sonic"
        sonicLabel.zPosition = zPosition
        sonicLabel.position = laserLabel.position.add(dx: 0, dy: laserLabel.frame.height + distanceBetweenLabels)
        gameScene.addChild(sonicLabel)
        
        let sonicContainer = SKNode()
        let sonicUnfill = SKSpriteNode(color: UIColor.init(colorLiteralRed: 23/255, green: 76/255, blue: 163/255, alpha: 1), size: barSize)
        sonicFill = SKSpriteNode(color: UIColor.init(colorLiteralRed: 38/255, green: 134/255, blue: 208/255, alpha: 1), size: barSize)
        let sonicCrop = SKCropNode()
        sonicCrop.maskNode = SKSpriteNode(color: .white, size: barSize)
        sonicCrop.addChild(sonicFill)
        sonicContainer.addChild(sonicCrop)
        sonicContainer.addChild(sonicUnfill)
        sonicContainer.position = sonicLabel.position.add(dx: 200 + barSize.width / 2, dy: barSize.height / 2)
        sonicContainer.zPosition = 5
        sonicCrop.zPosition = 1
    }
}

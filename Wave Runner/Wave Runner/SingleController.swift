////
////  SingleController.swift
////  Wave Runner
////
////  Created by Apple on 1/21/17.
////  Copyright © 2017 Techkids. All rights reserved.
////
//
//import SpriteKit
//typealias DidDestroyType = () -> ()
//
//class SingleControler : Controller {
//    
//    let view: View
//    var didDestroy: DidDestroyType?
//    
//    init(view aView: View) {
//        self.view = aView
//    }
//    
//    override func config(position: CGPoint, parent: SKNode) {
//        self.view.position = position
//        if self.view.parent != nil {
//            self.view.removeFromParent()
//        }
//        parent.addChild(self.view)
//        
//        self.view.destroy = self.destroy
//        super.config(position: position, parent: parent)
//    }
//    
//    func move(vector: CGVector) {
//        view.position = view.position.add(vector: vector)
//    }
//    
//    func move(dx: CGFloat, dy: CGFloat) -> Void {
//        view.position = view.position.add(dx: dx, dy: dy)
//    }
//    
//    func moveTowards(destination: CGPoint, speed: CGFloat) -> Bool {
//        let distance = self.view.position.distance(other: destination)
//        
//        if distance < speed {
//            return false
//        } else {
//            let (vector, angle) = self.position.towards(other: destination, speed: speed)
//            self.view.position = self.view.position.add(vector: vector)
//            self.view.zRotation = angle
//            return true
//        }
//    }
//    
//    override var position : CGPoint {
//        get {
//            return self.view.position
//        }
//        set {
//            self.view.position = newValue
//        }
//    }
//    
//    var width: CGFloat {
//        get {
//            return self.view.frame.width
//        }
//    }
//    
//    var height: CGFloat {
//        get {
//            return self.view.frame.height
//        }
//    }
//    
//    var size : CGSize {
//        get  {
//            return self.view.frame.size
//        }
//    }
//    
//    var isHidden : Bool {
//        get {
//            return self.view.isHidden
//        }
//        set {
//            self.view.isHidden = newValue
//        }
//    }
//    
//    var viewDetached : Bool {
//        get {
//            return self.view.parent == nil
//        }
//    }
//    
//    var texture : SKTexture? {
//        get {
//            return self.view.texture
//        } set {
//            self.view.texture = newValue
//        }
//    }
//    
//    var zRotation : CGFloat {
//        get {
//            return self.view.zRotation
//        }
//        set {
//            self.view.zRotation = newValue
//        }
//    }
//    
//    override func destroy() -> Void {
//        self.removeFromParent()
//        super.destroy()
//        self.didDestroy?()
//    }
//    
//    func removeFromParent() -> Void {
//        self.view.removeAllActions()
//        self.view.removeAllChildren()
//        self.view.removeFromParent()
//    }
//    
//    func removeAllActions() -> Void {
//        self.view.removeAllActions()
//    }
//    
//    func log(tag: String, message: String) -> Void {
//        print(tag, ":" ,message)
//    }
//}

//
//  File.swift
//  Hackathon
//
//  Created by Developer on 12/6/16.
//  Copyright © 2016 Developer. All rights reserved.
//
import SpriteKit
import Foundation

extension CGPoint {
    func add(vector: CGVector) -> CGPoint {
        return CGPoint(x: self.x + vector.dx, y: self.y + vector.dy)
    }
    
    func add(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: self.x + dx, y: self.y + dy)
    }
    
    func add(other: CGPoint) -> CGPoint {
        return CGPoint(x: self.x + other.x, y: self.y + other.y)
    }
    
    func subtract(other: CGPoint) -> CGVector {
        return CGVector(dx: self.x - other.x, dy: self.y - other.y)
    }
    
    func subtract(dx: CGFloat, dy: CGFloat) -> CGVector {
        return CGVector(dx: self.x - dx, dy: self.y - dy)
    }
    
    func towards(other: CGPoint, speed: CGFloat) -> (CGVector, CGFloat) {
        let vector =  other.subtract(other: self)
        
        let angle = atan2(vector.dy, vector.dx)
        let dx = cos(angle) * speed
        let dy = sin(angle) * speed
        
        return (CGVector(dx: dx, dy: dy), angle - CGFloat(M_PI_2))
    }
    
    func distance(other: CGPoint) -> CGFloat {
        let dx = self.x - other.x
        let dy = self.y - other.y
        return sqrt(dx * dx + dy * dy)
    }
    
    func from(vector: CGVector) -> CGPoint {
        return CGPoint(x: vector.dx, y: vector.dy)
    }
    
    func multiply(factor: CGFloat) -> CGPoint {
        return CGPoint(x: self.x * factor, y: self.y * factor)
    }
}



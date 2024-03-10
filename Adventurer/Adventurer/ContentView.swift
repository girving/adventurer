//
//  ContentView.swift
//  Adventurer
//
//  Created by Geoffrey Irving on 3/3/24.
//

import SwiftUI
import SpriteKit

// Useful example: https://www.hackingwithswift.com/quick-start/swiftui/how-to-integrate-spritekit-using-spriteview

class GameScene: SKScene {
  var ocean: Lookup?
  var lila_land: SKTexture?
  var lila_water: SKTexture?
  var lila: SKSpriteNode?
  var offset: CGSize?
  
  override func didMove(to view: SKView) {
    ocean = Lookup(SKTexture(imageNamed: "village-mask"))
    
    let background = SKSpriteNode(imageNamed: "background")
    background.position = CGPoint(x: size.width / 2, y: size.height / 2)
    background.size = frame.size
    background.zPosition = -1
    addChild(background)
    
    lila_land = SKTexture(imageNamed: "lila-on-land")
    lila_water = SKTexture(imageNamed: "lila-in-water")
    let lila = SKSpriteNode(texture: lila_land!)
    lila.position = CGPoint(x: 0.52, y: 0.55)
    lila.size = CGSize(width: 0.15, height: 0.15)
    lila.zPosition = 1
    addChild(lila)
    self.lila = lila
    lilaUpdate()
  }
  
  func oceanAt(_ location: CGPoint) -> SKColor {
    guard let ocean = self.ocean else { return .red }
    return ocean.at(location)
  }
  
  func lilaUpdate() {
    guard let lila = self.lila else { return }
    let info = oceanAt(lila.position)
    lila.texture = info.cgColor.alpha > 0.5 ? lila_land : lila_water
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let lila = self.lila,
          let touch = touches.first else { return }
    let location = touch.location(in: self)
    if lila.contains(location) {
      offset = location - lila.position
    }
  }

  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let lila = self.lila,
          let offset = offset,
          let touch = touches.first else { return }
    let location = touch.location(in: self)
    lila.position = location - offset
    lilaUpdate()
  }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    offset = nil
  }

  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    touchesEnded(touches, with: event)
  }
}

struct ContentView: View {
  var scene: SKScene {
    let scene = GameScene()
    scene.scaleMode = .aspectFit
    return scene
  }
  var body: some View {
    SpriteView(scene: scene)
      .ignoresSafeArea()
  }
}

#Preview {
  ContentView()
}

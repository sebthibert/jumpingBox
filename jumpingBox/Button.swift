import SpriteKit

class Button: SKSpriteNode {
  init() {
    super.init(texture: nil, color: .clear, size: CGSize(width: 0, height: 0))
    self.texture = SKTextureAtlas(named: "HUD").textureNamed("button")
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}


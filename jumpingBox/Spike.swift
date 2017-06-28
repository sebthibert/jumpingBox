import SpriteKit

class Spike: SKSpriteNode {
  var initialSize = CGSize(width: 30, height: 30)
  var textureSprite = SKTextureAtlas(named: "Environment").textureNamed("spike")
  
  init() {
    super.init(texture: textureSprite, color: .clear, size: initialSize)
    self.physicsBody = SKPhysicsBody(texture: textureSprite, size: self.size)
    self.physicsBody?.isDynamic = false
    self.physicsBody?.affectedByGravity = false
    self.physicsBody?.categoryBitMask = PhysicsCategory.spike.rawValue
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}


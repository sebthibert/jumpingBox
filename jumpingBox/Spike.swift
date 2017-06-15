import SpriteKit

class Spike: SKSpriteNode {
  var initialSize = CGSize(width: 30, height: 30)
  var textureAtlas = SKTextureAtlas(named: "Environment")
  
  init() {
    super.init(texture: nil, color: .clear, size: initialSize)
    self.name = "spike"
    self.texture = textureAtlas.textureNamed("spike")
    self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
    self.physicsBody?.isDynamic = false
    self.physicsBody?.affectedByGravity = false
    self.physicsBody?.categoryBitMask = PhysicsCategory.spike.rawValue
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}


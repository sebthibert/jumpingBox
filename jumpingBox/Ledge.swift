import SpriteKit

class Ledge: SKSpriteNode {
  var initialSize = CGSize(width: 200, height: 30)
  var textureAtlas = SKTextureAtlas(named: "Environment")
  
  init() {
    super.init(texture: nil, color: .clear, size: initialSize)
    self.name = "ledge"
    self.texture = textureAtlas.textureNamed("ledge")
    self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
    self.physicsBody?.isDynamic = false
    self.physicsBody?.affectedByGravity = false
    self.physicsBody?.categoryBitMask = PhysicsCategory.ledge.rawValue
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

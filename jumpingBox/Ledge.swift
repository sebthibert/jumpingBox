import SpriteKit

class Ledge: SKSpriteNode {
  var initialSize = CGSize(width: 200, height: 30)
  var textureSprite = SKTextureAtlas(named: "Environment").textureNamed("ledge")
  
  init() {
    super.init(texture: textureSprite, color: .clear, size: initialSize)
    self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
    self.physicsBody?.isDynamic = false
    self.physicsBody?.affectedByGravity = false
    self.physicsBody?.categoryBitMask = PhysicsCategory.ledge.rawValue
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

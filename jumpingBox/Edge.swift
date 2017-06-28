import SpriteKit

class Edge: SKSpriteNode {
  var initialSize = CGSize(width: 0.5, height: 29)
  var textureSprite = SKTextureAtlas(named: "Environment").textureNamed("edge")
  
  init() {
    super.init(texture: textureSprite, color: .clear, size: initialSize)
    self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
    self.physicsBody?.isDynamic = false
    self.physicsBody?.affectedByGravity = false
    self.physicsBody?.categoryBitMask = PhysicsCategory.edge.rawValue
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}



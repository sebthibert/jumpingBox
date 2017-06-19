import SpriteKit

class Edge: SKSpriteNode {
  var initialSize = CGSize(width: 0.5, height: 29)
  var textureAtlas = SKTextureAtlas(named: "Environment")
  
  init() {
    super.init(texture: nil, color: .clear, size: initialSize)
    self.name = "edge"
    self.texture = textureAtlas.textureNamed("edge")
    self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
    self.physicsBody?.isDynamic = false
    self.physicsBody?.affectedByGravity = false
    self.physicsBody?.categoryBitMask = PhysicsCategory.edge.rawValue
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}



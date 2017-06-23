import SpriteKit

class Coin: SKSpriteNode {
  var initialSize = CGSize(width: 25, height: 25)
  var textureAtlas = SKTextureAtlas(named: "Environment")
  
  init() {
    super.init(texture: nil, color: .clear, size: initialSize)
    self.name = "coin"
    self.texture = textureAtlas.textureNamed("coin")
    self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
    self.physicsBody?.isDynamic = false
    self.physicsBody?.affectedByGravity = false
    self.physicsBody?.categoryBitMask = PhysicsCategory.coin.rawValue
  }
  
  func collect() {
    self.physicsBody?.categoryBitMask = 0
    
    let collectAnimation = SKAction.group([
      SKAction.fadeAlpha(to: 0, duration: 0.2),
      SKAction.scale(to: 1.5, duration: 0.2),
      SKAction.move(by: CGVector(dx: 0, dy: 25),
                    duration: 0.2)
      ])
    
    let resetAfterCollected = SKAction.run {
      self.position.y = 5000
      self.alpha = 1
      self.xScale = 1
      self.yScale = 1
      self.physicsBody?.categoryBitMask = PhysicsCategory.coin.rawValue
    }
    
    let collectSequence = SKAction.sequence([collectAnimation, resetAfterCollected])
    self.run(collectSequence)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}




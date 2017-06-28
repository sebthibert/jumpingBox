import SpriteKit

class Coin: SKSpriteNode {
  var initialSize = CGSize(width: 25, height: 25)
  var textureSprite = SKTextureAtlas(named: "Environment").textureNamed("coin")
  
  init() {
    super.init(texture: textureSprite, color: .clear, size: initialSize)
    self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
    self.physicsBody?.isDynamic = false
    self.physicsBody?.affectedByGravity = false
    self.physicsBody?.categoryBitMask = PhysicsCategory.coin.rawValue
  }
  
  func collect() {
    self.physicsBody?.categoryBitMask = 0
    let fade = SKAction.fadeAlpha(to: 0, duration: 0.2)
    let scale = SKAction.scale(to: 1.5, duration: 0.2)
    let move = SKAction.move(by: CGVector(dx: 0, dy: 25), duration: 0.2)
    let collectAnimation = SKAction.group([fade, scale, move])
    
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




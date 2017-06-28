import SpriteKit

class Ground: SKSpriteNode {
  
  var textureSprite = SKTextureAtlas(named: "Environment").textureNamed("ground")
  var jumpWidth = CGFloat()
  var jumpCount = CGFloat(1)
  
  func createChildren() {
    var tileCount: CGFloat = 0
    let tileSize = CGSize(width: 35, height: 300)
    
    while tileCount * tileSize.width < self.size.width {
      let tileNode = SKSpriteNode(texture: textureSprite)
      tileNode.size = tileSize
      tileNode.position.x = tileCount * tileSize.width
      tileNode.anchorPoint = CGPoint(x: 0, y: 0.99)
      self.addChild(tileNode)
      tileCount += 1
      self.physicsBody?.categoryBitMask = PhysicsCategory.ground.rawValue
      self.physicsBody?.collisionBitMask = 0
    }
    
    let pointTopLeft = CGPoint(x: 0, y: 0)
    let pointTopRight = CGPoint(x: size.width, y: 0)
    self.physicsBody = SKPhysicsBody(edgeFrom: pointTopLeft, to: pointTopRight)
    jumpWidth = tileSize.width * floor(tileCount / 3)
  }
  
  func checkForReposition(playerProgress:CGFloat) {
    let groundJumpPosition = jumpWidth * jumpCount
    
    if playerProgress >= groundJumpPosition {
      self.position.x += jumpWidth
      jumpCount += 1
    }
  }
}

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
  
  let ground = Ground()
  let player = Player()
  let hud = HUD()
  let encounterManager = EncounterManager()
  let cam = SKCameraNode()
  var playerProgress = CGFloat(0)
  let initialPlayerPosition = CGPoint(x: 75, y: 200)
  var nextEncounterSpawnPosition = CGFloat(150)
  
  override func didMove(to view: SKView) {
    dead = false
    
    self.physicsWorld.contactDelegate = self
    self.backgroundColor = .gray
    encounterManager.addEncountersToScene(gameScene: self)
    
    ground.position = CGPoint(x: -self.size.width * 2, y: 30)
    ground.size = CGSize(width: self.size.width * 6, height: 0)
    ground.createChildren()
    self.addChild(ground)
    
    player.position = initialPlayerPosition
    self.addChild(player)
    
    self.camera = cam
    self.addChild(self.camera!)
    
    hud.createHudNodes(screenSize: self.size)
    self.camera!.addChild(hud)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    for touch in (touches) {
      let location = touch.location(in: self)
      let nodeTouched = atPoint(location)
      
      if nodeTouched.name == "pauseGame" {
        if self.view?.isPaused == true { return }
        if dead { return }
        nodeTouched.isHidden = true
        hud.playButton.isHidden = false
        self.isPaused = true
      } else if nodeTouched.name == "playGame" {
        if self.view?.isPaused == true { return }
        if dead { return }
        nodeTouched.isHidden = true
        hud.pauseButton.isHidden = false
        self.isPaused = false
      } else if nodeTouched.name == "restartGame" {
        restart()
      } else {
        if dead { return }
        if player.jumping { return }
        player.jump()
      }
    }
  }
  
  override func didSimulatePhysics() {
    self.camera!.position = CGPoint(x: player.position.x + 300, y: ground.position.y + 160)
    playerProgress = player.position.x - initialPlayerPosition.x
    ground.checkForReposition(playerProgress: playerProgress)

    if player.position.x > nextEncounterSpawnPosition {
      encounterManager.placeNextEncounter(
        currentXPos: nextEncounterSpawnPosition)
      nextEncounterSpawnPosition += 900
    }
  }
  
  override func update(_ currentTime: TimeInterval) {
    if self.view?.isPaused == true { return }
    playerScore = Int(playerProgress / 100)
    hud.setScoreDisplay(newScore: playerScore)
    player.update()
  }
  
  func didBegin(_ contact: SKPhysicsContact) {
    let otherBody: SKPhysicsBody
    let playerMask = PhysicsCategory.player.rawValue
    if (contact.bodyA.categoryBitMask & playerMask) > 0 { otherBody = contact.bodyB }
    else { otherBody = contact.bodyA }
    
    switch otherBody.categoryBitMask {
    case PhysicsCategory.spike.rawValue:
      if dead { return }
      player.die()
      hud.showDeadNodes()
    case PhysicsCategory.edge.rawValue:
      if dead || player.physicsBody!.velocity.dy > 0 { return }
      player.die()
      hud.showDeadNodes()
    default: break
    }
  }
  
  func restart() {
    self.view?.presentScene(GameScene(size: self.size))
  }
}

enum PhysicsCategory:UInt32 {
  case player = 1
  case ground = 2
  case spike = 4
  case ledge = 8
  case edge = 16
}

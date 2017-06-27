import GameKit

public var dead = false
public var newLife = false
public var playerProgress = CGFloat(0)
public var playerDeathPosition = CGPoint(x: 0, y: 0)
public var highScore = UserDefaults.standard.object(forKey: "HighScore") as? CGFloat ?? 0
public var coinsCollected = UserDefaults.standard.object(forKey: "CoinsCollected") as? Int ?? 0
public let fontSizeSmall = CGFloat(25)
public let fontSizeMedium = CGFloat(40)
public let fontSizeLarge = CGFloat(60)
public let font = "AvenirNext-BoldItalic"

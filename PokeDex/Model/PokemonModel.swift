import Foundation

// MARK: Parent Struct
struct Pokemon: Decodable {
    
    // MARK: @Properties
    let name: String
    let id: Int
    let sprites: Sprite
    
    /**©-----------------------------©*/
    // MARK: Child Struct
    struct Sprite: Decodable {
        
        // MARK: @Properties
        let classicSprite: URL
        
        // Coding keys enum
        enum CodingKeys: String, CodingKey {
            case classicSprite = "front_default"
        }
        
    }
    /**©-----------------------------©*/
}

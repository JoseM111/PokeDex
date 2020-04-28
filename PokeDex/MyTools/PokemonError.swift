import Foundation

// MARK: _@LocalizedError
// A specialized error that provides localized
// messages describing the error and why it occurred.

enum PokemonError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
            case .invalidURL:
                return "Unable to reach the server."
            case .thrownError(let error):
                return error.localizedDescription
            case .noData:
                return "The server responded with no data"
            case .unableToDecode:
                return "The server responded with bad data"
        }
    }
}

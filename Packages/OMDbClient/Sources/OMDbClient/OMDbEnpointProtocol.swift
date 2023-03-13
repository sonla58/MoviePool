import Foundation

import BaseAPIClient

public protocol OMDbEnpointProtocol: APIRequestCompatible {
    var path: String { get }
    var queryParams: APIParameterCompatible? { get }
}

extension OMDbEnpointProtocol {
    var url: URLConvertible {
        func buildURL() throws -> URL {
            guard var url = URL(string: OMDbClient.baseURL) else {
                throw URLError(URLError.Code.badURL)
            }
            url.appendPathComponent(path)
            guard var urlComponent = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
                throw URLError(URLError.Code.badURL)
            }
            let queryItems = queryParams?.parammeters.map { (item) -> URLQueryItem in
                URLQueryItem(name: item.key, value: "\(item.value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
            }
            urlComponent.queryItems = queryItems
            return try urlComponent.asURL()
        }
        do {
            return try buildURL()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    public var timeout: TimeInterval {
        60
    }
    
    public var urlBodyParams: APIBodyCompatible? {
        nil
    }
    
    public var headers: APIHeaderCompatible {
        [:]
    }
    
    public var cachePolicy: URLRequest.CachePolicy {
        .useProtocolCachePolicy
    }
}

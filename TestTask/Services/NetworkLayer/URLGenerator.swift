import Foundation

protocol URLRequestBuilder {
    func request(endpoint: String, queryItems: [URLQueryItem]) -> URLRequest?
}

class URLGenerator: URLRequestBuilder {
    let baseURL = "https://api.nasa.gov/mars-photos/api/v1/rovers/"
    let apiKey = "BmMXeHAWtQdygov7xTfKgiL4H3xRIKMTpblKOsBr"
    
    func request(endpoint: String, queryItems: [URLQueryItem]) -> URLRequest? {
        var queryItem = queryItems
        guard let baseURL = URL(string: baseURL) else { return nil }
        var components = URLComponents(url: baseURL.appendingPathComponent(endpoint), resolvingAgainstBaseURL: true)
        
        let defaultQueryItem = [URLQueryItem(name: "api_key", value: apiKey)]
        queryItem.append(contentsOf: defaultQueryItem)

        
        components?.queryItems = queryItem
        
        guard let url = components?.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}

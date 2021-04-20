import Foundation
import UIKit

enum NetworkError: Error {
    case domainError
    case decodingError
    case invalidData
    case requestError
}

final class APIService {    
    static func get(request: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let resp = response as? HTTPURLResponse {
                let statusCode = resp.statusCode
                //300 Redirection messages
                //400 Client error responses
                //500 Server error responses
                if  statusCode >= 300 {
                    completion(.failure(NetworkError.requestError))
                    return
                }
            }
            guard let data = data  else {
                completion(.failure(NetworkError.invalidData))
                return
            }
            completion(.success(data))
        }.resume()
    }
    
    static func readJSONFromFile(fileName: String) -> Any? {
        var json: Any?
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                json = try? JSONSerialization.jsonObject(with: data)
            } catch {
                // Handle error here
            }
        }
        return json
    }
}

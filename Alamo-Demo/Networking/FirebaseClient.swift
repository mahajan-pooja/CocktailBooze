import Foundation
import Firebase
import SwiftKeychainWrapper

class FirebaseClient {
    static func getFavorites(completion: @escaping (Result<[String], NetworkError>) -> Void) {
        Firestore.firestore().collection("RecipeCollection").getDocuments { querySnapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(.failure(.requestError))
            } else {
                if let querySnapshot = querySnapshot {
                    for document in querySnapshot.documents {
                        let favoritesArray = document.data()["regions"] as! [String]
                        completion(.success(favoritesArray))
                    }
                }
            }
        }
    }
    
    static func removeFavorites(data: String, completion: @escaping () -> Void) {
        let user = Auth.auth().currentUser
        var email: String!
        var ref: DocumentReference!

        if let user = user {
            email = user.email
        } else {
            email = KeychainWrapper.standard.string(forKey: "user-email")
        }
        ref = Firestore.firestore().collection("RecipeCollection").document(email)

        ref.updateData([
            "regions": FieldValue.arrayRemove([data])
        ])
        completion()
    }
}

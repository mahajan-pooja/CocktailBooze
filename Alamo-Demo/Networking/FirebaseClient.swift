import Foundation
import Firebase
import SwiftKeychainWrapper

class FirebaseClient {
    static func getActiveUserEmail() -> String {
        let user = Auth.auth().currentUser
        var email: String!

        if let user = user {
            email = user.email
        } else {
            email = KeychainWrapper.standard.string(forKey: "user-email")
        }
        return email
    }
    
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
    
    static func getRecipes(completion: @escaping (Result<[[String: Any]], NetworkError>) -> Void) {
        let email = getActiveUserEmail()
        var downloadedRecipe = [[String: Any]]()
        
        Firestore.firestore().collection(email).getDocuments { querySnapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(.failure(.invalidData))
            } else {
                for document in querySnapshot!.documents {
                    downloadedRecipe.append(document.data())
                }
                completion(.success(downloadedRecipe))
            }
        }
    }
    
    static func getRecipeDetails(selectedRecipe: RecipeModel, completion: @escaping (Result<[String: Any], NetworkError>) -> Void ) {
        let email = getActiveUserEmail()
        var recipeDetails = [String : Any]()
        Firestore.firestore().collection(email).getDocuments { querySnapshot, err in

            if let err = err {
                print("Error getting documents: \(err)")
                completion(.failure(.invalidData))
            } else {
                for document in querySnapshot!.documents where document.documentID == selectedRecipe.recipeName {
                    recipeDetails = document.data()
                }
                completion(.success(recipeDetails))
            }
        }
    }
    
    static func removeFavorites(data: String, completion: @escaping () -> Void) {
        var ref: DocumentReference!
        let email = getActiveUserEmail()
        ref = Firestore.firestore().collection("RecipeCollection").document(email)

        ref.updateData([
            "regions": FieldValue.arrayRemove([data])
        ])
        completion()
    }
}

import Foundation


class Request{
    
    }
    
    
    enum logInError: Error{
        case badURL
        case badResponse
    }
    
    
    
    func getAllUsers(endpoint: String
                        ,completion: @escaping (Result<[String], Error>) -> Void){
       
        
        
        guard let url = URL(string: "https://superapi.netlify.app/" + endpoint) else {
            completion(.failure(logInError.badURL))
            return
        }
        
        let request = URLRequest(url: url)
        
        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
           DispatchQueue.main.async {
                guard let unWrappedResponse = response as? HTTPURLResponse else{
                    completion(.failure(logInError.badResponse))
                    return
            }

                print(unWrappedResponse.statusCode)
                print("succes get Users")

            }

            
            if let unwrappedData = data{
                print(unwrappedData)
            
                do{
                    let json = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                    

                    if let users = try? JSONDecoder().decode([String].self, from: unwrappedData){

                        completion(.success(users))



                    }
                                
                }catch{
                   completion(.failure(error))
                    print("estoy aqui")
                }
            }
        }
        session.resume()
        
        
}



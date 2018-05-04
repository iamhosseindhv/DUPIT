class Service {
    
    //to access methods of this Singleton
    static let sharedInstance = Service()
    
    //downloads data from given url and returns the url of saved model in file manager
    func dowloadData(url: String, completion: @escaping ((URL) ->()) ){
        
        guard let url = URL(string: url) else {
            print("Error: invalid url to be downloaded")
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print("Error: model downloading failed")
                return
            }
            
            DispatchQueue.main.async {
                guard let mydata = data else {
                    print("Error: model downloading failed")
                    return
                }
                
                //successfully downloaded, now write it to the file Manager
                let fileManager = FileManager.default
                let address = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
                let path = address?.appendingPathComponent("mymodel.obj")
                print(path!)
                try? mydata.write(to: path!)
                
                completion(path!)
            }
        }).resume()
        
    }
    
}




//Service.sharedInstance.dowloadData(url: urlString, completion: { (filePath) in
//                
//})







"https://firebasestorage.googleapis.com/v0/b/dupme-2692d.appspot.com/o/KmVeMWDlmvfe6TnJkvmQsqqt4O33%2FED901CFB-5E64-4F6B-B714-7DA361B98870%2FKmVeMWDlmvfe6TnJkvmQsqqt4O33_ED901CFB-5E64-4F6B-B714-7DA361B98870_14.jpg?alt=media&token=0724f707-c5f4-44ca-98c7-19b65315c099"

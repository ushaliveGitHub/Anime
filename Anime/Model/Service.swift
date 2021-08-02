//
//  Service.swift
//  Anime
//
//  Created by Usha Natarajan on 7/30/21.
//

import Foundation

import Foundation

protocol Service {
    func didGetData(data: Data)
    func didGetError(error: Error)
}

/**
 # The service class for Rest Api requests.
 # How it works - Service is initialized by passing the url endpoint. getData() attempts to fetch data from Rest api endpoint.
 */
class ApiService {
    private var endpoint: String
    var delegate: Service?
    
    init(endpoint: String){
        self.endpoint = endpoint
    }
    
    private func createSession()-> URLRequest? {
        guard let url = URL(string: endpoint) else {
            let error = NSError(domain: "",
                                code: -999,
                                userInfo: [NSLocalizedDescriptionKey : "Unable to initalize URL!"])
            delegate?.didGetError(error:error)
            return nil
        }
        return URLRequest(url: url)
    }
    
    func getData(){
        guard let request = createSession() else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { [weak self] (data, response, error) in
            guard  error == nil ,
                   let httpResponse = response as? HTTPURLResponse,
                   httpResponse.statusCode == 200 else { // assumption - Only code 200 is success
                       let apiError = error ?? NSError(domain: "",
                                                       code: -999,
                                                       userInfo: [NSLocalizedDescriptionKey : "Http response error!"])
                       self?.delegate?.didGetError(error: apiError)
                       return
                   }
            guard let data = data else {
                self?.delegate?.didGetError(error: NSError(domain: "",
                                                           code: -999,
                                                           userInfo: [NSLocalizedDescriptionKey : "No data found!"]))
                return
            }
            self?.delegate?.didGetData(data: data)
        }
        task.resume()
    }
}

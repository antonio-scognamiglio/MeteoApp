//
//  WeatherError.swift
//  Meteo-exercise
//
//  Created by Antonio Scognamiglio on 14/07/23.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidUrl
    
    case missingRequiredFields(String)
    
    case invalidParameters(operation: String, parameters: [Any])
    
    case badRequest
    
    case unauthorized
    
    case paymentRequired
    
    case forbidden
    
    case notFound
    
    case requestEntityTooLarge

    case unprocessableEntity
    
    case http(httpResponse: HTTPURLResponse, data: Data)
    
    case invalidResponse(Data)
    
    case deleteOperationFailed(String)
    
    case network(URLError)
    
    case unknown(Error?)
}

func mapResponse(response: (data: Data, response: URLResponse)) throws -> Data {
    guard let httpResponse = response.response as? HTTPURLResponse else {
        return response.data
    }
    
    switch httpResponse.statusCode {
    case 200..<300:
        return response.data
    case 400:
        throw NetworkError.badRequest
    case 401:
        throw NetworkError.unauthorized
    case 402:
        throw NetworkError.paymentRequired
    case 403:
        throw NetworkError.forbidden
    case 404:
        throw NetworkError.notFound
    case 413:
        throw NetworkError.requestEntityTooLarge
    case 422:
        throw NetworkError.unprocessableEntity
    default:
        throw NetworkError.http(httpResponse: httpResponse, data: response.data)
    }
}

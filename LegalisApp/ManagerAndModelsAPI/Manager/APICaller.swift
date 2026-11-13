//
//  APICaller.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 9/11/26.
//

import Foundation

enum APIError: LocalizedError {
  
  case invalidURL
  case invalidResponse
  case serverError(Int)
  case decodingError
  case networkError
  
  var errorDescription: String? {
    
    switch self {
      case .invalidURL:
        return "La dirrección de la API no es valida"
      
      case .invalidResponse:
        return "La respuesta del servidor no es válida."

      case .serverError(let code):
        return "Error del servidor. Código: \(code)"
      
      case .decodingError:
        return "No se pudieron interpretar los datos recibidos."
      
      case .networkError:
        return "No fue posible conectar con el servidor."
    }
  }
}

final class APICaller {
  
  static let shared = APICaller()//Permite acceder a una única instancia de APICaller.
  
  private init() {}
  
  func getUser() async throws -> [UserModel] {//async throws Permite ejecutar solicitudes asíncronas y manejar errores.
    
    guard let url = URL(string: APIEndopoint.users) else {
      throw APIError.invalidURL
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    do {
      let (data, response) = try await URLSession.shared.data(for: request)
      
      guard let httpResponse = response as? HTTPURLResponse else {
        throw APIError.invalidResponse
      }
      
      guard (200...299).contains(httpResponse.statusCode) else {
        throw APIError.serverError(httpResponse.statusCode)
      }
      
      let decoder = JSONDecoder()//Convierte JSON en modelos Swift
      decoder.keyDecodingStrategy = .convertFromSnakeCase//Convierte identity_card en identityCard
      
      return try decoder.decode([UserModel].self, from: data)
      
    } catch let error as APIError {
      throw error
    } catch let error as DecodingError {
      print("Error de decodificación: \(error)")
      throw APIError.decodingError
    } catch {
      print("Error de conexión: \(error)")
      throw APIError.networkError
    }
    
  }
  
  
  //MARK: - REGISTRAR USUARIO
  func registerUser(user: UserRegistrationModel) async throws -> UserModel {
    
    guard let url = URL(string: APIEndopoint.users) else {
      throw APIError.invalidURL
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    do {
      // Convertir el modelo Swift a JSON
      let encoder = JSONEncoder()
      encoder.keyEncodingStrategy = .convertToSnakeCase
      request.httpBody = try encoder.encode(user)
      
      // Enviar la petición al backend
      let (data, response) = try await URLSession.shared.data(for: request)
      
      guard let httpResponse = response as? HTTPURLResponse else {
        throw APIError.invalidResponse
      }
      
      // Comprobar la respuesta del servidor
      guard (200...299).contains(httpResponse.statusCode) else {
        print("Error del servidor:")
        print(String(data: data, encoding: .utf8) ?? "Sin información")
        throw APIError.serverError(httpResponse.statusCode)
      }
      
      // Convertir la respuesta JSON a UserModel
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      
      return try decoder.decode(UserModel.self, from: data)
      
    } catch let error as APIError {
      throw error
    } catch let error as EncodingError {
      print("Error al convertir los datos: \(error)")
      throw APIError.decodingError
    } catch let error as DecodingError {
      print("Error al interpretar la respuesta: \(error)")
      throw APIError.decodingError
    } catch {
      print("Error de conexión: \(error)")
      throw APIError.networkError
    }
    
  }
  
  
}

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
  
  // MARK: - REGISTRAR PAGO
  func registerPayment(payment: PaymentCreateModel) async throws -> PaymentResponseModel {

      guard let url = URL(string: APIEndopoint.payments) else {
          throw APIError.invalidURL
      }

      var request = URLRequest(url: url)
      request.httpMethod = "POST"
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")

      do {
          let encoder = JSONEncoder()
          encoder.keyEncodingStrategy = .convertToSnakeCase

          request.httpBody = try encoder.encode(payment)

          let (data, response) = try await URLSession.shared.data(for: request)

          guard let httpResponse = response as? HTTPURLResponse else {
              throw APIError.invalidResponse
          }

          guard httpResponse.statusCode == 201 else {
              print("Error del servidor:", String(data: data, encoding: .utf8) ?? "")

              throw APIError.serverError(httpResponse.statusCode)
          }

          let decoder = JSONDecoder()
          decoder.keyDecodingStrategy = .convertFromSnakeCase

          return try decoder.decode(PaymentResponseModel.self, from: data)

      } catch let error as APIError {
          throw error

      } catch let error as DecodingError {
          print("Error de decodificación: \(error)")
          throw APIError.decodingError

      } catch let error as EncodingError {
          print("Error de codificación: \(error)")
          throw APIError.decodingError

      } catch {
          print("Error de conexión: \(error)")
          throw APIError.networkError
      }
  }
  
  // MARK: - DISPONIBILIDAD DEL ABOGADO
  func getLawyerAvailability(lawyerId: Int, date: String) async throws -> LawyerAvailabilityModel {

      guard let url = URL(
          string: APIEndopoint.lawyerAvailability(lawyerId: lawyerId,date: date)
      ) else {
          throw APIError.invalidURL
      }

      do {
          let (data, response) = try await URLSession.shared.data(
              from: url
          )

          guard let httpResponse = response as? HTTPURLResponse else {
              throw APIError.invalidResponse
          }

          guard (200...299).contains(httpResponse.statusCode) else {
              throw APIError.serverError(httpResponse.statusCode)
          }

          let decoder = JSONDecoder()
          decoder.keyDecodingStrategy = .convertFromSnakeCase
          decoder.dateDecodingStrategy = .iso8601

          return try decoder.decode(
              LawyerAvailabilityModel.self,
              from: data
          )

      } catch let error as APIError {
          throw error
      } catch let error as DecodingError {
          print("Error decodificando disponibilidad: \(error)")
          throw APIError.decodingError
      } catch {
          print("Error consultando disponibilidad: \(error)")
          throw APIError.networkError
      }
  }
  
  // MARK: - HORARIOS SEMANALES DEL ABOGADO
  func getLawyerSchedules(lawyerId: Int) async throws -> [LawyerScheduleModel] {

      guard let url = URL(string: APIEndopoint.lawyerSchedules(lawyerId: lawyerId)) else {
          throw APIError.invalidURL
      }

      do {
          let (data, response) = try await URLSession.shared.data(from: url)

          guard let httpResponse = response as? HTTPURLResponse else {
              throw APIError.invalidResponse
          }

          guard (200...299).contains(httpResponse.statusCode) else {
              throw APIError.serverError(httpResponse.statusCode)
          }

          let decoder = JSONDecoder()
          decoder.keyDecodingStrategy = .convertFromSnakeCase

          return try decoder.decode(
              [LawyerScheduleModel].self,
              from: data
          )

      } catch let error as APIError {
          throw error

      } catch let error as DecodingError {
          print("Error decodificando horarios: \(error)")
          throw APIError.decodingError

      } catch {
          print("Error consultando horarios: \(error)")
          throw APIError.networkError
      }
  }
  
  
// MARK: - CONSULTAR TODOS LOS ABOGADOS
  func getLawyers() async throws -> [LawyerResponseModel] {

      guard let url = URL(string: APIEndopoint.lawyers) else {
          throw APIError.invalidURL
      }

      do {

          let (data, response) = try await URLSession.shared.data(
              from: url
          )

          guard let httpResponse = response as? HTTPURLResponse else {
              throw APIError.invalidResponse
          }

          guard (200...299).contains(httpResponse.statusCode) else {

              print(
                  "Error del servidor:",
                  String(data: data, encoding: .utf8) ?? ""
              )

              throw APIError.serverError(httpResponse.statusCode)
          }

          let decoder = JSONDecoder()

          decoder.keyDecodingStrategy = .convertFromSnakeCase

          return try decoder.decode(
              [LawyerResponseModel].self,
              from: data
          )

      } catch let error as APIError {

          throw error

      } catch let error as DecodingError {

          print("Error decodificando abogados:", error)

          throw APIError.decodingError

      } catch {

          print("Error consultando abogados:", error)

          throw APIError.networkError

      }
  }

  // MARK: - CREAR CITA

  func createAppointment(appointment: AppointmentCreateModel) async throws -> AppointmentResponseModel {

      guard let url = URL( string: APIEndopoint.appointments) else {
          throw APIError.invalidURL
      }

      var request = URLRequest(url: url)

      request.httpMethod = "POST"

      request.setValue("application/json", forHTTPHeaderField: "Content-Type")

      do {

          // Convertir los datos de Swift al formato de FastAPI
          let encoder = JSONEncoder()

          encoder.keyEncodingStrategy = .convertToSnakeCase
          encoder.dateEncodingStrategy = .iso8601

          request.httpBody = try encoder.encode(appointment)

          let (data, response) = try await URLSession.shared.data(
              for: request
          )

          guard let httpResponse = response as? HTTPURLResponse else {
              throw APIError.invalidResponse
          }

          guard httpResponse.statusCode == 201 else {

              // Mostrar el motivo real del rechazo de FastAPI
              if let errorResponse = try? JSONDecoder().decode(
                  AppointmentAPIErrorResponse.self,
                  from: data
              ) {

                  throw NSError(
                      domain: "LegalisApp.Appointments",
                      code: httpResponse.statusCode,
                      userInfo: [
                          NSLocalizedDescriptionKey: errorResponse.detail
                      ]
                  )

              }

              throw APIError.serverError(httpResponse.statusCode)

          }

          let decoder = JSONDecoder()

          decoder.keyDecodingStrategy = .convertFromSnakeCase

          // Admitir fechas ISO 8601 con y sin segundos fraccionarios
          decoder.dateDecodingStrategy = .custom { decoder in

              let container = try decoder.singleValueContainer()
              let value = try container.decode(String.self)

              let formatter = ISO8601DateFormatter()

              formatter.formatOptions = [
                  .withInternetDateTime,
                  .withFractionalSeconds
              ]

              if let date = formatter.date(from: value) {
                  return date
              }

              formatter.formatOptions = [.withInternetDateTime]

              if let date = formatter.date(from: value) {
                  return date
              }

              throw DecodingError.dataCorruptedError(
                  in: container,
                  debugDescription: "Fecha inválida: \(value)"
              )

          }

          return try decoder.decode(
              AppointmentResponseModel.self,
              from: data
          )

      } catch let error as APIError {

          throw error

      } catch let error as DecodingError {

          print("Error decodificando cita:", error)

          throw APIError.decodingError

      } catch {

          print("Error creando cita:", error)

          throw error

      }

  }
  
}

// MARK: - Mensajes de error de FastAPI

private struct AppointmentAPIErrorResponse: Decodable {
    let detail: String
}

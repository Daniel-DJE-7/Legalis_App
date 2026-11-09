//
//  FavoritesClientCoordinator.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 8/9/26.
//

import UIKit

protocol FavoritesClientCoordinatorDelegate: AnyObject {
    func favoritesCoordinatorDidRequestAppointmentsTab(
        _ coordinator: FavoritesClientCoordinator
    )
}

class FavoritesClientCoordinator: Coordinator {

  var navigationController: UINavigationController?
  private var bookingCoordinator: BookingCoordinator?
  weak var delegate: FavoritesClientCoordinatorDelegate?
  
  init(navigationController: UINavigationController? = nil) {
    self.navigationController = navigationController
  }
  
  func start() {
    if let favoriteVC = navigationController?.viewControllers.first as? FavoriteCollectionViewController {
      favoriteVC.coordinator = self
    }
  }
  
  func goToLawyerDescriptionProfile() {
    let profileVC = ProfileLawyerCollectionViewController()
    
    bookingCoordinator = BookingCoordinator(navigationController: navigationController)
    //booking le avisa a favoritos cuando termine el flujo de pago con exito
    bookingCoordinator?.delegate = self
    
    profileVC.coordinator = bookingCoordinator
    
    navigationController?.pushViewController(profileVC, animated: true)
    
  }
  
}

extension FavoritesClientCoordinator: BookingCoordinatorDelegate {
  
  //aqui FavoritesClientCoordinator le avisa a MainClientTabBarCoordinator que quiere ir a citas en el tabar
  func bookingCoordinatorDidFinishWithSuccess(_ coordinator: BookingCoordinator) {
    delegate?.favoritesCoordinatorDidRequestAppointmentsTab(self)
  }
  
  
}
/*
 //MARK: - VISTA AGENDAR CITAS DESDE EL HOME CLIENTES
 - agregar pantalla de escribir reseña del cliente sobre el servicio del abogado, crear un endpoint tipo post (perfil, foto, nombre, descripcion, calificacion de 1 a 5)
 - crear un endpoint tipo get, para obtener las calificaciones del abogado promediada
 - agregar llenar perfil del abogado tipo linkin: crear endpoint tipo post para crear el perfil del abogado (foto, especialidad, perfil profesional, contacto y tarifa)
 - crear un endpoint tipo post para agendar citas que debe tener la fecha, la hora, si es presencial o virtual (bool), tipo de consulta a realizar.
 - crear un endpoint tipo get para obtener un tipo de consulta
 - crear un endpoint tipo get para que se proyecte las fechas y la hora en la pantalla del calendario.
 - crear visualmente un objeto de selección en la pantalla de agendar citas para colocar el tipo de consulta a realizar el abogado.
 - en la vista "metodo de pago" crear un endpoint tipo post que almacene la fecha, el tipo de pago (efectivo o tarjeta), el precio total, id de transaccion, id cita, pago, fecha de pago, fecha de cita, abogado, especialidad de derecho, las horas.
 
 //MARK: - VISTA CITAS
 - crear un endpoint tipo GET para ver la fecha de la cita
 - crear un endpoint tipo GET ALL para ver el historial de las citas concretadas.
 - crear un endpoint tipo patch para poder actualizar o reagendar citas
 - crear un endpoint tipo delete para cancelar la cita, DEVOLUCION DE DINERO
 - crear endpoint GET para obtener todas las citas
 
 //MARK: - VISTA CHATS
 - crear un endpoint tipo get para crear el chat obteiendo la info del cliente y abogado
 - crear un endpoint tipo post para guardar los mensajes enviados y tipo de usuario (enviar documentos, fotos, nota de voz)
 - crear un endpoint tipo put o patch para poder editar el mensaje
 - crear endpoint de abogados para seleccionar el abogado con el cual quiero conversar en el chat
 
 //MARK: - VISTA PERFIL
 - crear un endpoint tipo GET para obtener la informacion del usuario
 - crear un endpoint tipo patch O PUT para CAMBIAR LA FOTO DEL PERFIL
 - crear un endpoint tipo delete para poder eliminar la cuenta
 */

/*
 //MARK: - VISTA AGENDAR CITAS DESDE EL HOME ABOGADOS
 - crear un endpoint tipo POST para crear el perfil abogado
 - crear un endpoint tipo GET ALL citas para ver el historial de las citas concretadas desde el abogado.
 - crear un endpoint tipo patch para poder actualizar o reagendar citas
 - crear un endpoint tipo delete para cancelar la cita, DEVOLUCION DE DINERO
 
 //MARK: - VISTA CHATS
 - crear un endpoint tipo get para crear el chat obteiendo la info del cliente y abogado
 - crear un endpoint tipo post para guardar los mensajes enviados y tipo de usuario (enviar documentos, fotos, nota de voz)
 - crear un endpoint tipo put o patch para poder editar el mensaje
 - crear endpoint de abogados para seleccionar el abogado con el cual quiero conversar en el chat
 
 //MARK: - VISTA PERFIL
 - crear un endpoint tipo GET para obtener la informacion del usuario
 - crear un endpoint tipo patch O PUT para CAMBIAR LA FOTO DEL PERFIL
 - crear un endpoint tipo delete para poder eliminar la cuenta
 */

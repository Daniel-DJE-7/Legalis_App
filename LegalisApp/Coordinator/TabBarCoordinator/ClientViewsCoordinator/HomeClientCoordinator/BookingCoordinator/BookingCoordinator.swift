//
//  BookingCoordinator.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 11/9/26.
//

import UIKit


protocol BookingCoordinatorDelegate: AnyObject {
  // Método para avisarle al Home que el pago fue exitoso y queremos ir a Mis Citas
  func bookingCoordinatorDidFinishWithSuccess(_ coordinator: BookingCoordinator)
}

class BookingCoordinator: Coordinator {

  var chilCoordinators: [Coordinator] = []
  var navigationController: UINavigationController?
  weak var delegate: BookingCoordinatorDelegate?
  //propiedad para recibir las categorias desde el home
  var categorySelected: CategoriesModel?
  
  //variable interna que guarda el Navigation de la tarjeta flotante de pago
  private var paymentSheetNavigation: UINavigationController?
  
  init(navigationController: UINavigationController?) {
    self.navigationController = navigationController
  }
  
  // MARK: - START method
  func start() {
    //Mostrar pantalla de categorias
    let lawyerListVC = LawyersCategoriesListCollectionViewController()
    lawyerListVC.categories = categorySelected
    //conectamos el metodo con DipTapWatchLawyerProfile
    lawyerListVC.coordinator = self
    navigationController?.pushViewController(lawyerListVC, animated: true)
  }
  
  func goToLawyerDescriptionProfile() {
    
    let profileVC = ProfileLawyerCollectionViewController()
    profileVC.coordinator = self
    navigationController?.pushViewController(profileVC, animated: true)
    
  }
  
  func goToSelectDate() {
    
    let scheduleVC = AppointmentScheduleCollectionViewController()
    scheduleVC.coordinator = self
    navigationController?.pushViewController(scheduleVC, animated: true)
    
  }
  
  //MARK: - Resumen del pago
  func goToPaymentSummary() {
    
    let paymentSummaryVC = PaymentSummaryCollectionViewController()
    paymentSummaryVC.coordinator = self
    
    let nav = UINavigationController(rootViewController: paymentSummaryVC)
        nav.modalPresentationStyle = .pageSheet
        //get the sheet
        if let sheet = nav.sheetPresentationController{
          sheet.detents = [.custom { context in
            return context.maximumDetentValue * 0.8}
          ]
          sheet.prefersScrollingExpandsWhenScrolledToEdge = true
          sheet.prefersGrabberVisible = true
          sheet.preferredCornerRadius = 30
        }
    // Guardamos la referencia para usarla en los siguientes métodos de pago
        self.paymentSheetNavigation = nav
        navigationController?.present(nav, animated: true)
    
  }
  
  //MARK: - seleccionar metodo de pago para pagar (efectivo-tarjeta)
  func goToSelectPaymentMethod() {
    
    let selectPaymentMethodVC = PaymentMethodCollectionViewController()
    selectPaymentMethodVC.coordinator = self
    paymentSheetNavigation?.pushViewController(selectPaymentMethodVC, animated: true)
    
  }
  
  
  //llenar formulario de la tarjeta débito o crédito
  func goToFillCardInformationPaymentMethod() {
    
    let cardPaymentInformationVC = CardDetailsCollectionViewController()
    cardPaymentInformationVC.coordinator = self
    paymentSheetNavigation?.pushViewController(cardPaymentInformationVC, animated: true)
    
  }
  
  //MARK: - PAGO CON TARJETA EXITOSO
  func goToPayWithYourCardNowSuccessfull() {
    
    let payNowVC = SuccessPaymentAppointmentCollectionViewController()
    payNowVC.coordinator = self
    paymentSheetNavigation?.pushViewController(payNowVC, animated: true)
    
  }
  
  // MARK: - IR A MIS CITAS
  //cuando el usuario selecciona ir a mis citas, lo redirecciona al TabBar Appointments
  func userDidTapGoToMyAppointments() {
    
    //Cerramos por completo la tarjeta flotante del 80% de forma animada
    paymentSheetNavigation?.dismiss(animated: true) { [weak self] in
      guard let self = self else { return }
      /* Una vez cerrada la tarjeta, le avisamos al HomeClientCoordinator (el padre)
      para que haga el popToRoot, cambie de pestaña y nos borre del pizarrón de memoria (nil)*/
      self.delegate?.bookingCoordinatorDidFinishWithSuccess(self)
    }
    
  }
  
  func goToPendingCashPayment(appointmentId: Int, pendingAmount: Int) {

      let vc = PendingCashPaymentCollectionViewController()

      vc.coordinator = self
      vc.appointmentId = appointmentId
      vc.pendingAmount = pendingAmount

    paymentSheetNavigation?.pushViewController(vc, animated: true)
  }
  
}


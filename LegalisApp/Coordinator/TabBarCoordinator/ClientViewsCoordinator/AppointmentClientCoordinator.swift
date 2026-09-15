//
//  AppointmentClientCoordinator.swift
//  LegalisApp
//
//  Created by Daniel Figueredo on 8/9/26.
//

import UIKit

protocol AppointmentClientCoordinatorDelegate: AnyObject {
  func appointmentsCoordinatorDidRequestReSchedule(_ coordinator: AppointmentClientCoordinator)
}


class AppointmentClientCoordinator: Coordinator {

  var navigationController: UINavigationController?
  private var bookingCoordinator: BookingCoordinator?
  weak var delegate: AppointmentClientCoordinatorDelegate?
  
  
  init(navigationController: UINavigationController? = nil) {
    self.navigationController = navigationController
  }
  
  func start() {
    if let appointmentVC = navigationController?.viewControllers.first as? AppointmentNavItemCollectionViewController {
      appointmentVC.coordinator = self
    }
  }
  
  func goToSelectDate() {
    
    let scheduleVC = AppointmentScheduleCollectionViewController()
    
    bookingCoordinator = BookingCoordinator(navigationController: navigationController)
    bookingCoordinator?.delegate = self
    scheduleVC.coordinator = bookingCoordinator
    navigationController?.pushViewController(scheduleVC, animated: true)
    
  }
  
}

extension AppointmentClientCoordinator: BookingCoordinatorDelegate {
  
  func bookingCoordinatorDidFinishWithSuccess(_ coordinator: BookingCoordinator) {
    delegate?.appointmentsCoordinatorDidRequestReSchedule(self)
  }
  
  
}

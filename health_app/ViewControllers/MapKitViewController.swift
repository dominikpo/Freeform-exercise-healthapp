//
//  MapKitViewController.swift
//  health_app
//
//  Created by Dominik Polzer on 22.12.20.
//  Copyright © 2020 Dominik Polzer. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import HealthKit

class MapKitViewController: UIViewController {
    
    
    @IBOutlet weak var mapContainer: UIView!
    @IBOutlet weak var mapLabel: MKMapView!
    @IBOutlet weak var dauerLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var startButtonLabel: UIButton!
    @IBOutlet weak var stopButtonLabel: UIButton!
    @IBOutlet weak var schritteZählerLabel: UILabel!
    @IBOutlet weak var schrittezählerButton: UIButton!
    @IBOutlet weak var countdownView: UIView!
    @IBOutlet weak var countdownLabel: UILabel!
    
    
    private var run: Run?
    private let locationManager = LocationManager.shared
    private var seconds = 0
    private var timer : Timer?
    private var countDownTimer: Timer?
    private var distance = Measurement(value: 0, unit: UnitLength.meters)
    private var locationList: [CLLocation] = []
    private let healthStore = HKHealthStore()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapContainer.isHidden = false
        
        let healthKitTypes: Set = [HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!]
        healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { (success, error) in
            
            if(success){
                self.getSteps { (result) in
                    DispatchQueue.main.async {
                        let stepCount = Int(result)
                        self.schritteZählerLabel.text = "Schritte: \(stepCount)"
                    }
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        locationManager.stopUpdatingLocation()
        navigationController?.setNavigationBarHidden(false, animated: true)
        var overlays = self.mapLabel.overlays
        self.mapLabel.removeOverlays(overlays)
    }

    
    // MARK: - Buttons
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        startARun()
        if let userLocation = locationManager.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 500, longitudinalMeters: 500)
            mapLabel.setRegion(viewRegion, animated: false)
        }
        
        self.countdownLabel.text = ""
        self.countdownView.isHidden = false
        self.countdownView.alpha = 0
        self.countdownLabel.alpha = 0
        
        UIView.animate(withDuration: 0.5){
            self.countdownView.alpha = 1
            self.countdownLabel.alpha = 1
        }
        
        if countdownLabel.alpha == 1 {
            var count = 5
            countDownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {_ in
                if count >= 0 {
                    self.countdownLabel.text = String(count)
                    count -= 1
                    
                }else {
                    self.countdownLabel.text = "GO!"
                    self.countDownTimer?.invalidate()
                    UIView.animate(withDuration: 1.0){
                        self.countdownLabel.alpha = 0
                        self.countdownLabel.alpha = 0
                        self.countdownView.isHidden = true
                        self.updateDisplay()
                        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {_ in
                            self.eachSpeed()
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Lauf beenden?", message: "Möchtest du den Lauf beenden?", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            self.stopRun()
            self.saveRun()
            self.performSegue(withIdentifier: "details", sender: nil)

            
        }
        
        let discardAction = UIAlertAction(title: "Discard", style: .destructive) { _ in
            self.stopRun()
            self.dauerLabel.text = "00:00:00"
            self.paceLabel.text = "00:00"
            self.distanceLabel.text = "0,00"
            
            var overlays = self.mapLabel.overlays
            self.mapLabel.removeOverlays(overlays)

        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        alertController.addAction(discardAction)
        
        present(alertController, animated: true)
        
    }
    
    
    @IBAction func savedRunButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "savedRuns", sender: nil)
    }
    
    
    @IBAction func stepCounterOverview(_ sender: Any) {
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "details"){
            let destination = segue.destination as! DetailedRunViewController
            destination.run = run
        }
    }
    
    // MARK: - Functions
    
    
    func getSteps(completion: @escaping (Double) -> Void) {
        let quantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let start = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        var interval = DateComponents()
        interval.day = 1
        
        guard let stepsQuantityType = quantityType else {
            return
        }
        
        let query = HKStatisticsCollectionQuery(quantityType: stepsQuantityType, quantitySamplePredicate: nil, options: [.cumulativeSum], anchorDate: startOfDay, intervalComponents: interval)
        
        query.initialResultsHandler = { _ , result, error in
            var resultCount = 0.0
            guard let result = result else {
                return
            }
            result.enumerateStatistics(from: startOfDay, to: now) { (statistics, _) in
                if let sum = statistics.sumQuantity() {
                    resultCount = sum.doubleValue(for: HKUnit.count())
                }
                DispatchQueue.main.async {
                    completion(resultCount)
                }
            }
            if let error = error {
                print(error)
            }
        }
        query.statisticsUpdateHandler = {
            query, statistics, collection, error in
            if let sum = statistics?.sumQuantity() {
                let resultCount = sum.doubleValue(for: HKUnit.count())
                DispatchQueue.main.async {
                    completion(resultCount)
                }
            }
        }
        healthStore.execute(query)
    }
    
    private func startARun(){
        startButtonLabel.isHidden = true
        stopButtonLabel.isHidden = false
        mapLabel.removeOverlays(mapLabel.overlays)
        seconds = 0
        distance = Measurement(value: 0, unit: UnitLength.meters)
        locationList.removeAll()
        //        updateDisplay()
        //        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {_ in
        //            self.eachSpeed()
        //        }
        startLocationUpdates()
    }
    
    private func stopRun(){
        startButtonLabel.isHidden = false
        stopButtonLabel.isHidden = true
        locationManager.stopUpdatingLocation()
        timer?.invalidate()
    }
    
    
    func eachSpeed(){
        seconds += 1
        updateDisplay()
    }
    
    private func updateDisplay(){
        let formattedDistance = FormatDisplay.distance(distance)
        let formattedTime = FormatDisplay.time(seconds)
        let formattedPace = FormatDisplay.pace(distance: distance, seconds: seconds, outputUnit: UnitSpeed.minutesPerKilometer)
        
        distanceLabel.text = formattedDistance
        dauerLabel.text = formattedTime
        paceLabel.text = formattedPace
    }
    
    private func startLocationUpdates(){
        locationManager.delegate = self
        locationManager.activityType = .fitness
        locationManager.distanceFilter = 10
        locationManager.startUpdatingLocation()
    }
    
    private func saveRun() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let newRun = Run(context: managedObjectContext)
        newRun.distance = distance.value
        newRun.duration = Int16(seconds)
        newRun.timestamp = Date()
        
        for location in locationList {
            let locationObject = Location(context: managedObjectContext)
            locationObject.timestamp = location.timestamp
            locationObject.latitude = location.coordinate.latitude
            locationObject.longitude = location.coordinate.longitude
            newRun.addToLocations(locationObject)
        }
        
        do{
            try managedObjectContext.save()
        } catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        run = newRun
    }
}


// MARK: - Extensions

extension MapKitViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for newLocation in locations {
            let howRecent = newLocation.timestamp.timeIntervalSinceNow
            guard newLocation.horizontalAccuracy < 20 && abs(howRecent) < 10 else { continue }
            
            if let lastLocation = locationList.last {
                let delta = newLocation.distance(from: lastLocation)
                distance = distance + Measurement(value: delta, unit: UnitLength.meters)
                let coordinates = [lastLocation.coordinate, newLocation.coordinate]
                mapLabel.addOverlay(MKPolyline(coordinates: coordinates, count: 2))
                let region = MKCoordinateRegion(center: newLocation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
                mapLabel.setRegion(region, animated: true)
            }
            locationList.append(newLocation)
        }
    }
}

extension MapKitViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyline = overlay as? MKPolyline else {
            return MKOverlayPathRenderer(overlay: overlay)
        }
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = .blue
        renderer.lineWidth = 3
        return renderer
    }
}



//
//  StepForOneWeekViewController.swift
//  health_app
//
//  Created by Dominik Polzer on 23.01.21.
//  Copyright © 2021 Dominik Polzer. All rights reserved.
//

import UIKit
import HealthKit
import Charts

class StepForOneWeekViewController: UIViewController {
    
    
    @IBOutlet weak var titelLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var statisticsContainer: UIView!
    
    private var healthStore = HKHealthStore()
    private var query: HKStatisticsCollectionQuery?
    private var steps: [Step] = [Step]()
    private var stepsCounterArray: [Double] = []
    private var barChart = BarChartView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titelLabel.text = "Statistics"
        durationLabel.text = "From the past 7 Days"
        
        let healthKitTypes: Set = [HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!]
        healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { (success, error) in
            
            if(success) {
                self.getSteps { (statisicsCollection) in
                    if let statisicsCollection = statisicsCollection {
                        // Update UI
                        let startDate = Calendar.current.date(byAdding: .day, value: -6 ,to: Date())
                        let endDate = Date()
                        
                        statisicsCollection.enumerateStatistics(from: startDate!, to: endDate) { (statistics, stop) in
                            let count = statistics.sumQuantity()?.doubleValue(for: .count())
                            
                            let step = Step(count: Double(count ?? 0), date: statistics.startDate)
                            self.steps.append(step)
                            self.stepsCounterArray.append(step.count)
                        }
                    }
                }
            }else if let error = error {
                print(error)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        barChart.frame = CGRect(x: 0, y: 0, width: self.statisticsContainer.frame.width, height: self.statisticsContainer.frame.height)
        //        barChart.center = view.center
        statisticsContainer.addSubview(barChart)
        var entries = [BarChartDataEntry]()
        for x in 0..<steps.count {
            entries.append(BarChartDataEntry(x: Double(x + 1), y: stepsCounterArray[x]))
        }
        let set = BarChartDataSet(entries: entries, label: "Steps from the past 7 days")
        set.colors = ChartColorTemplates.joyful()
        let data = BarChartData(dataSet: set)
        barChart.data = data
    }
    
    func getSteps(completion: @escaping (HKStatisticsCollection?) -> Void) {
        let quantityType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
        
        let startDate = Calendar.current.date(byAdding: .day, value: -6 ,to: Date())
        let anchorDate = Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        let daily = DateComponents(day:1)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
        
        guard let stepsQuantityType = quantityType else {
            return
        }
        
        query = HKStatisticsCollectionQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate, intervalComponents: daily)
        query!.initialResultsHandler = { query, statisticsCollection, error in
            completion(statisticsCollection!)
        }
        if let query = self.query {
            healthStore.execute(query)
        }
    }
}

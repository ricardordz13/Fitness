//  HealthStore.swift
//  Fitness
//
//  Created by Ricardo Jorge Rodriguez Trevino on 21/11/23.
//

import Foundation
import HealthKit
import WidgetKit
import Observation

extension Date {
    static var startOfDay: Date {
        Calendar.current.startOfDay(for: Date())
    }
}

@Observable
class HealthStore {
    
    var steps: [Step] = []
    var healthStore = HKHealthStore()
            
    // New Stuff
    var stepCountToday: Int = 0
    var stepCountYesterday: Int = 0

    var caloriesBurnedToday: Int = 0
    var thisWeekSteps: [Int: Int] = [1: 0,
                                     2: 0,
                                     3: 0,
                                     4: 0,
                                     5: 0,
                                     6: 0,
                                     7: 0]

    func requestAuthorization() {
      let toReads = Set([
        HKObjectType.quantityType(forIdentifier: .stepCount)!,
        HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
        // HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
      ])
      guard HKHealthStore.isHealthDataAvailable() else {
        print("health data not available!")
        return
      }
      healthStore.requestAuthorization(toShare: nil, read: toReads) {
        success, error in
        if success {
          self.fetchAllDatas()
        } else {
          print("\(String(describing: error))")
        }
      }
    }
    
    func fetchAllDatas() {
      print("Attempting to fetch all Datas")
      readStepCountYesterday()
      readStepCountToday()
      readCalorieCountToday()
      readStepCountThisWeek()

      print("DATAS FETCHED: ")
      print("\(stepCountToday) steps today")
      print("\(caloriesBurnedToday) calories today")
      
      UserDefaults(suiteName: "group.iWalker")?.set(stepCountToday, forKey: "widgetStep")
      
      WidgetCenter.shared.reloadAllTimelines()
    }
    
    // Steps from yesterday
    func readStepCountYesterday() {
      guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
        return
      }

      let calendar = Calendar.current
      let yesterday = calendar.date(byAdding: .day, value: -1, to: Date())
      let startDate = calendar.startOfDay(for: yesterday!)
      let endDate = calendar.startOfDay(for: Date())
      let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)

      print("attempting to get step count from \(startDate)")

      let query = HKStatisticsQuery(
        quantityType: stepCountType,
        quantitySamplePredicate: predicate,
        options: .cumulativeSum
      ) {
        _, result, error in
        guard let result = result, let sum = result.sumQuantity() else {
          print("failed to read step count: \(error?.localizedDescription ?? "UNKNOWN ERROR")")
          return
        }

        let steps = Int(sum.doubleValue(for: HKUnit.count()))
        print("Fetched your steps yesterday: \(steps)")
        self.stepCountYesterday = steps
      }
      healthStore.execute(query)
    }
    
    // Steps from Today
    func readStepCountToday() {
      guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
        return
      }

      let now = Date()
      let startDate = Calendar.current.startOfDay(for: now)
      let predicate = HKQuery.predicateForSamples(
        withStart: startDate,
        end: now,
        options: .strictStartDate
      )
        // print("attempting to get step count from \(startDate)")

      let query = HKStatisticsQuery(
        quantityType: stepCountType,
        quantitySamplePredicate: predicate,
        options: .cumulativeSum
      ) {
        _, result, error in
        guard let result = result, let sum = result.sumQuantity() else {
          print("failed to read step count: \(error?.localizedDescription ?? "UNKNOWN ERROR")")
          return
        }

        let steps = Int(sum.doubleValue(for: HKUnit.count()))
        // print("Fetched your steps today: \(steps)")
        self.stepCountToday = steps
      }
      healthStore.execute(query)
    }
    
    // Calories from Today
    func readCalorieCountToday() {
      guard let calorieType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else {
        return
      }
      let now = Date()
      let startDate = Calendar.current.startOfDay(for: now)

      let predicate = HKQuery.predicateForSamples(
        withStart: startDate,
        end: now,
        options: .strictStartDate
      )

      print("attempting to get calories burned from \(startDate)")

      let query = HKSampleQuery(sampleType: calorieType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, results, _ in
        guard let samples = results as? [HKQuantitySample], let firstSample = samples.first else {
          print("No calorie burn samples found.")
          return
        }

        // Retrieve the total calories burned for today
        let totalCalories = samples.reduce(0.0) { $0 + $1.quantity.doubleValue(for: HKUnit.kilocalorie()) }

        // Process the total calories burned
        // print("Total calories burned today: \(totalCalories) kcal")
        self.caloriesBurnedToday = Int(totalCalories)
      }

      healthStore.execute(query)
    }
    
    // Steps from this week
    func readStepCountThisWeek() {
      guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
        return
      }
      let calendar = Calendar.current
      let today = calendar.startOfDay(for: Date())
      // Find the start date (Monday) of the current week
      guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)) else {
        print("Failed to calculate the start date of the week.")
        return
      }
      // Find the end date (Sunday) of the current week
      guard let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek) else {
        print("Failed to calculate the end date of the week.")
        return
      }

      print("Attempting to get stepcount from \(startOfWeek) to \(endOfWeek)")

      let predicate = HKQuery.predicateForSamples(
        withStart: startOfWeek,
        end: endOfWeek,
        options: .strictStartDate
      )

      let query = HKStatisticsCollectionQuery(
        quantityType: stepCountType,
        quantitySamplePredicate: predicate,
        options: .cumulativeSum,
        anchorDate: startOfWeek,
        intervalComponents: DateComponents(day: 1)
      )

      query.initialResultsHandler = { _, result, error in
        guard let result = result else {
          if let error = error {
            print("An error occurred while retrieving step count: \(error.localizedDescription)")
          }
          return
        }

  //      print("---> ---> ATTEMPTING TO GET WEEK's STEPS")
        result.enumerateStatistics(from: startOfWeek, to: endOfWeek) { statistics, _ in
          if let quantity = statistics.sumQuantity() {
            let steps = Int(quantity.doubleValue(for: HKUnit.count()))
            let day = calendar.component(.weekday, from: statistics.startDate)
            print("for day \(day) u have \(steps) steps!")
            self.thisWeekSteps[day] = steps
          }
        }

        print("\(self.thisWeekSteps)")
      }
      healthStore.execute(query)
    }

    // Steps from this week (old)
    func calculateSteps() async throws {
        
        let calendar = Calendar(identifier: .gregorian)
        let startDate = calendar.date(byAdding: .day, value: -7, to: Date())
        let endDate = Date()
        
        let stepType = HKQuantityType(.stepCount)
        let everyDay = DateComponents(day: 1)
        
        let thisWeek = HKQuery.predicateForSamples(withStart: startDate, end: .startOfDay)
        let stepsThisWeek = HKSamplePredicate.quantitySample(type: stepType, predicate: thisWeek)
        
        let sumOfStepsQuery = HKStatisticsCollectionQueryDescriptor(predicate: stepsThisWeek, options: .cumulativeSum, anchorDate: endDate, intervalComponents: everyDay)
        
        let stepsCount = try await sumOfStepsQuery.result(for: healthStore)
        
        guard let startDate = startDate else { return }
        
        stepsCount.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            let step = Step(count: Int(count ?? 0), date: statistics.startDate)
            if step.count > 0 {
                // add the step in step collection
                self.steps.append(step)
            }
        }
    }
    
    func calculateCalories() {
        
    }
}

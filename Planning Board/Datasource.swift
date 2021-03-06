//
//  Datasource.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 2/11/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

struct Global {
    // Data
    static var segmentArray = [Segment]()
    static var memberArray = [Member]()
    static var arrayOfServices: [Service] = [Service]()
    static var serviceFilePath: String = "PlanningBoardServices.json"
    
    // Icons
    static var arrayOfIcons: [UIImage] = [
        UIImage(named:"bible_icon")!,
        UIImage(named:"clock")!,
        UIImage(named:"door_icon")!,
        UIImage(named:"fire_icon")!,
        UIImage(named:"giving")!,
        UIImage(named:"meeting_icon")!,
        UIImage(named:"mike_icon")!,
        UIImage(named:"movie_icon")!,
        UIImage(named:"plan_icon")!,
        UIImage(named:"prayer_hands")!,
        UIImage(named:"speaking_icon")!,
        UIImage(named:"party")!,
        UIImage(named:"unload")!,
        UIImage(named:"groceries")!,
        UIImage(named:"dedications")!,
        UIImage(named:"clapperBoard")!,
        UIImage(named:"candy")!,
        UIImage(named:"baptisms")!,
        UIImage(named:"balloons")!]
}

class Datasource {
    
    func fillSegmentData() {
        if let data = UserDefaults.standard.object(forKey: "SegmentList") as? NSData {
            Global.segmentArray = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! [Segment]
        }
    }
    
    func fillMemberData() {
        print("Filling Members")
        if let data = UserDefaults.standard.object(forKey: "MemberList") as? NSData {
            Global.memberArray = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! [Member]
        }
    }
    
    func uploadSegment() {
        let data = NSKeyedArchiver.archivedData(withRootObject: Global.segmentArray)
        UserDefaults.standard.set(data, forKey: "SegmentList")
        print("Segments Saved")
    }
    
    func uploadMember() {
        let data = NSKeyedArchiver.archivedData(withRootObject: Global.memberArray)
        UserDefaults.standard.set(data, forKey: "MemberList")
        print("Members Saved")
    }
    
    func getServiceData() {
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = DocumentDirURL.appendingPathComponent(Global.serviceFilePath)
        
        do {
            let readString: String = try String(contentsOf: fileURL)
            let readStringData = readString.data(using: .utf8)
            
            var services = try JSONDecoder().decode([Service].self, from: readStringData!)
            services = orderServiceArrayByDate(array: &services)
            
            Global.arrayOfServices = services
        } catch let error as NSError {
            print("Failed to read from services file...", error)
            Global.arrayOfServices = []
        }
    }
    
    func saveServicesToFile(services: [Service]) {
        let dataToWrite = try? JSONEncoder().encode(services)
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = DocumentDirURL.appendingPathComponent(Global.serviceFilePath)
        
        do {
            try dataToWrite?.write(to: fileURL)
        } catch let error as NSError {
            print("Failed to write to the file....", error)
        }
    }
    
    func orderServiceArrayByDate(array:inout [Service]) -> [Service] {
        array = array.sorted(by: {
            $0.date!.compare($1.date!) == .orderedDescending
        })
        return array
    }
    
    func fillMockData() {
//        let service1: Service = Service(title: "Awakening Night")
//        service1.date = "2018-10-19T01:44:37"
//        service1.type = "Awakening"
//
//        let service2: Service = Service(title: "Unstoppable Is Our Nature")
//        service2.date = "2018-11-28T01:44:37"
//        service2.type = "Sunday Morning"
//        let service3: Service = Service(title: "Expectation Is Our Approach")
//        service3.date = "2018-11-19T01:44:37"
//        service3.type = "Sunday Morning"
//
//
//        let segmentOne = Segment(title: "Worship")
//        let componentOne = ServiceComponent(type: .segment(segmentOne))
//        service1.components = [componentOne]
        
        //Global.arrayOfServices = [service1, service2, service3]
    }
}

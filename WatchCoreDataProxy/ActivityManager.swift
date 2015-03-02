//
//  ActivityManager.swift
//  ActivityBuilder
//
//  Created by Lindsay Thurmond on 2/26/15.
//  Copyright (c) 2015 Make and Build. All rights reserved.
//

import CoreData

public class ActivityManager: NSObject {
    
    public static let entityName = "Activity"
    
    //This approach supports lazy initialization because Swift lazily initializes class constants (and variables), and is thread safe by the definition of let.
    static let sharedInstance = ActivityManager()
    
    
    
    public class func createActivity(name: String, category: String, details: String, steps:NSSet?) -> Activity {
    
        let newActivity: Activity = NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: DataManager.getContext()) as! Activity
        
        newActivity.name = name
        newActivity.category = category
        newActivity.detail = details
        if steps != nil {
            newActivity.steps = steps!
        }
        
        DataManager.saveManagedContext()
        
        return newActivity
    }
    
    public class func fetchActivities() -> [Activity] {
        let fetchRequest = NSFetchRequest(entityName: entityName)
        
        // Create a sort descriptor object that sorts on the "name"
        // property of the Core Data object
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        // Set the list of sort descriptors in the fetch request,
        // so it includes the sort descriptor
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        var error: NSError? = nil
        
        if let activities:[Activity] = DataManager.getContext().executeFetchRequest(fetchRequest, error: &error) as? [Activity] {
            return activities
        }
        else {
            return [Activity]()
        }
    }
    
    public class func deleteActivity(activity:Activity) {
        DataManager.deleteManagedObject(activity)
    }

}

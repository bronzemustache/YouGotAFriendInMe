
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // Below is a graph the app starts out with, which I did
        // to make it easier to see what the app does.  Comment 
        // out the code below if you want to make a graph
        // from scratch.
        
        // people
        let bob = Person("Bob")
        let john = Person("John")
        let larry = Person("Larry")
        let mary = Person("Mary")
        let michelle = Person("Michelle")
        let tom = Person("Tom")
        let tony = Person("Tony")
        
        // subjects
        let autoRepair = Subject("auto repair")
        let cooking = Subject("cooking")
        let java = Subject("java")
        let landscaping = Subject("landscaping")
        let plumbing = Subject("plumbing")
        let tile = Subject("tile")
        
        // who is an expert in what
        bob.addSubject(landscaping)
        bob.addSubject(tile)
        john.addSubject(landscaping)
        larry.addSubject(java)
        mary.addSubject(cooking)
        mary.addSubject(plumbing)
        michelle.addSubject(autoRepair)
        michelle.addSubject(cooking)
        tony.addSubject(cooking)
        
        // friendships
        bob.makeFriend(john)
        bob.makeFriend(mary)
        mary.makeFriend(john)
        mary.makeFriend(larry)
        john.makeFriend(tony)
        michelle.makeFriend(tom)

        
        return true
    }

}


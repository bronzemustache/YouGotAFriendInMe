
import XCTest
@testable import YouGotAFriendInMe

class YouGotAFriendInMeTests: XCTestCase {
    
    func testFindPath() {

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
        
        // shorter path is returned instead of longer one
        XCTAssert(tony.pathToSubject(java) == [tony, john, mary, larry])
        XCTAssert(larry.pathToSubject(cooking) == [larry, mary])
        
        // no path
        XCTAssert(tom.pathToSubject(java) == [])
        XCTAssert(john.pathToSubject(autoRepair) == [])
        
        // one element path when person is expert in subject
        XCTAssert(john.pathToSubject(landscaping) == [john])
        XCTAssert(tony.pathToSubject(cooking) == [tony])
    }
}

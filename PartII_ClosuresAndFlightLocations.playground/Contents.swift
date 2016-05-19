/*:
 # Part II&mdash;Closures and Flight Locations
 
 In this part, you will write a function that takes a flight and returns a function. The function it returns will itself be a function that calculates the estimated position of the flight.
 
 ## Directions
 
 Part II A) 1 pt. One line in the function estimatedPosition is wrong. Fix it and two of the test failures will go away.
 
 Part II B) 3 pts. One line in the function estimatedFlightPositionFunction is wrong. Fix it and the rest of the test failures will go away.
 */
import CoreLocation

struct Flight {
    let startTime: CFAbsoluteTime
    let duration: CFTimeInterval
    let startingAirportLocation: CLLocation
    let endingAirportLocation: CLLocation
}

// This function does the "hard" work of estimating the location. It is mostly written. Only one line in the implementation is wrong! For Part II A you just need to find and fix the line.
func estimatedPosition(startingLocation startingLocation: CLLocation, endingLocation: CLLocation, startTime: CFAbsoluteTime, duration: CFTimeInterval, currentTime: CFAbsoluteTime) -> CLLocation {
    guard currentTime > startTime else { return startingLocation }
    guard currentTime < startTime + duration else { return endingLocation }
    let fraction = (currentTime - startTime) / duration
    let startingLongitude = startingLocation.coordinate.longitude
    let startingLatitude = startingLocation.coordinate.latitude
    let endingLongitude = endingLocation.coordinate.longitude
    let endingLatitude = endingLocation.coordinate.latitude
    let estimatedLongitude = startingLongitude + fraction * (endingLongitude - startingLongitude)
    let estimatedLatitude = startingLatitude + fraction * (endingLatitude - startingLatitude)
    let locationResult = CLLocation(latitude: 0, longitude: 0)
    return locationResult
}

// This is the function you are implementing for Part II B. This function takes a flight. It returns a function that returns a position.
func estimatedFlightPositionFunction(flight: Flight) -> (CFAbsoluteTime) -> CLLocation {
    // You can fix this function by changing only one line if you use the function you fixed in Part II A!
    func functionToReturn(currentTime: CFAbsoluteTime) -> CLLocation {
        let locationResult = CLLocation(latitude: 0, longitude: 0)
        return locationResult
    }
    return functionToReturn
}

/*:
 ## Unit Tests
  */
import XCTest

let startingAirportLocation = CLLocation(latitude: 38.0, longitude: 121.0)
let endingAirportLocation = CLLocation(latitude: 50.0, longitude: 123.0)

let flight = Flight(startTime: 12345000, duration: 7200, startingAirportLocation: startingAirportLocation, endingAirportLocation: endingAirportLocation)

let flightPositionFunction = estimatedFlightPositionFunction(flight)

class FlightPositionsTestSuite: XCTestCase {
    
    func testEstimatedPosition() {
        let currentTime: CFAbsoluteTime = 12347678
        let startTime: CFAbsoluteTime = 12345678
        let duration: CFTimeInterval = 6000
        let startingLocation = CLLocation(latitude: 38.0, longitude: 120.0)
        let endingLocation = CLLocation(latitude: 50.0, longitude: 123.0)
        let expectedResult = CLLocation(latitude: 42.0, longitude: 121.0)
        let result = estimatedPosition(startingLocation: startingLocation, endingLocation: endingLocation, startTime: startTime, duration: duration, currentTime: currentTime)
        XCTAssertEqual(expectedResult.coordinate.latitude, result.coordinate.latitude, "Latitude should be one-third of way.")
        XCTAssertEqual(expectedResult.coordinate.longitude, result.coordinate.longitude, "Longitude should be one-third of way.")
    }
    
    func testBeforeBeginningOfFlight() {
        let currentTime: CFAbsoluteTime = 12340000
        let expectedResult = startingAirportLocation
        let result = flightPositionFunction(currentTime)
        XCTAssertEqual(expectedResult, result, "Flight should be at starting airport.")
    }
    
    func testBeginningOfFlight() {
        let currentTime: CFAbsoluteTime = 12345000
        let expectedResult = startingAirportLocation
        let result = flightPositionFunction(currentTime)
        XCTAssertEqual(expectedResult, result, "Flight should still be at starting airport.")
    }
    
    func testHalfWay() {
        let currentTime: CFAbsoluteTime = 12348600
        let expectedResult = CLLocation(latitude: 44.0, longitude: 122.0)
        let result = flightPositionFunction(currentTime)
        XCTAssertEqual(expectedResult.coordinate.latitude, result.coordinate.latitude, "Flight latitude should be halfway.")
        XCTAssertEqual(expectedResult.coordinate.longitude, result.coordinate.longitude, "Flight longitude should be halfway.")
    }

}

class PlaygroundTestObserver : NSObject, XCTestObservation {
    @objc func testCase(testCase: XCTestCase, didFailWithDescription description: String, inFile filePath: String?, atLine lineNumber: UInt) {
        print("Test failed on line \(lineNumber): \(description)")
    }
}

XCTestObservationCenter.sharedTestObservationCenter().addTestObserver(PlaygroundTestObserver())

FlightPositionsTestSuite.defaultTestSuite().runTest()


/*:
 # Part IV&mdash;Factorial Generator
 
 ## Directions
 
 In this playground your job is to implement the class FactorialGenerator. Its next() method has not been implemented.
 
 ## Example

 In my intermediate-swift repo, I wrote up one of Eidhof and Velocity's generator examples. It was the FibonacciGenerator, and it is a good example to keep in mind when you are writing the FactorialGenerator.
 */
class FibonacciGenerator: GeneratorType {
    var state = (previous: 0, current: 1)
    func next() -> Int? {
        let newPrevious = state.current
        let newCurrent = state.previous + state.current
        state = (newPrevious, newCurrent)
        return state.current
    }
}
/*:
 ## Factorial Generator
 
 You need to implement next().
 */
class FactorialGenerator: GeneratorType {
    var state = (result: 1, multiplier: 1)
    // NOTE: When you are implementing this. Don't use somebody else's factorial function.
    // The whole point is to calculate each factorial result simply from the previous one.
    // E.g., if you have n! and you want (n+1)!, all your code has to do is multiple by n+1.
    // HINT: I made this a ton easier by supplying the FibonacciGenerator example. It's
    // like a template for a good solution.
}

let aFactorialGenerator = FactorialGenerator()

/*:
 ## Unit Tests
 */
import XCTest

class FactorialGeneratorTestSuite: XCTestCase {
    
    func testCallTheGeneratorOnce() {
        let aFactorialGenerator = FactorialGenerator()
        let result = aFactorialGenerator.next()
        let expectedResult = 1
        XCTAssertEqual(result, expectedResult, "1! should be 1")
    }
    
    func testCallTheGeneratorThreeTimes() {
        let aFactorialGenerator = FactorialGenerator()
        var result: Int? = nil
        for _ in 0..<3 {
            result = aFactorialGenerator.next()
        }
        let expectedResult = 6
        XCTAssertEqual(result, expectedResult, "3! should be 6")
    }
    
    func testCallTheGeneratorFiveTimes() {
        let aFactorialGenerator = FactorialGenerator()
        var result: Int? = nil
        for _ in 0..<5 {
            result = aFactorialGenerator.next()
        }
        let expectedResult = 120
        XCTAssertEqual(result, expectedResult, "5! should be 120")
    }
}

class PlaygroundTestObserver : NSObject, XCTestObservation {
    @objc func testCase(testCase: XCTestCase, didFailWithDescription description: String, inFile filePath: String?, atLine lineNumber: UInt) {
        print("Test failed on line \(lineNumber): \(description)")
    }
}

XCTestObservationCenter.sharedTestObservationCenter().addTestObserver(PlaygroundTestObserver())

FactorialGeneratorTestSuite.defaultTestSuite().runTest()


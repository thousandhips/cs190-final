/*:
 # Part V&mdash;Factorial Exceptions
 
 ## Directions
 
In this playground your job is to implement saferFactorial(). It should handle the n=0 special case correctly, and it should throw exceptions in the cases it can't handle.

In the lecture three weeks ago, we learned about exceptions, and I made [a playground on exceptions]( https://github.com/brianhill/generics-enumerations-exceptions ). You could look at that playground if you don't quite remember the syntax for throwing an exception.
 */

func factorial(n: Int) -> Int {
    var result = 1
    for idx in 1...n {
        result *= idx
    }
    return result
}

/*:
## Issues
 
The above function has three issues.

(1) It should return 1 when n = 0. Instead it causes the program to crash.

(2) It should throw an exception if you give it a negative n. Instead negative n also causes the program to crash.

(3) It should throw an exception if you give it too large an n. The maximum acceptable value is 20. The program crashes if you give it n=21.
 
So let's define the error types that will be thrown in the cases it can't handle:
 */
enum FactorialError: ErrorType {
    case TooLarge
    case Meaningless
}

// And here is the function for you to implement:

func saferFactorial(n: Int) throws -> Int   {
    return 1
}

/*:
 ## Unit Tests
 */
import XCTest

class SaferFactorialTestSuite: XCTestCase {
    
    func testCallItWithZero() {
        let result = try? saferFactorial(0)
        let expectedResult = 1
        XCTAssertEqual(result, expectedResult, "0! should be 1")
    }
    
    func testCallItWithFive() {
        let result = try? saferFactorial(5)
        let expectedResult = 120
        XCTAssertEqual(result, expectedResult, "5! should be 120")
    }
    
    func testCallItWithNegativeShouldThrow() {
        let result = try? saferFactorial(-10)
        XCTAssertNil(result, "(-10)! is actually definable, but as far as this program is concerned, it is meaningless.")
    }
    
    func testCallItWithFiftyShouldThrow() {
        let result = try? saferFactorial(50)
        XCTAssertNil(result, "50! is too large")
    }
    
}

class PlaygroundTestObserver : NSObject, XCTestObservation {
    @objc func testCase(testCase: XCTestCase, didFailWithDescription description: String, inFile filePath: String?, atLine lineNumber: UInt) {
        print("Test failed on line \(lineNumber): \(description)")
    }
}

XCTestObservationCenter.sharedTestObservationCenter().addTestObserver(PlaygroundTestObserver())

SaferFactorialTestSuite.defaultTestSuite().runTest()



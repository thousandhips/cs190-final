/*:
 
 # Part I&mdash;Bezier Curves
 
 ## Scoring
 
 5 pts total. When you get it right, the five failures will go away.
 
 ## Directions
 
 There's a lot of stuff in this playground that I had to code to make it work. The only place you are going to have to make modifications is in test6Choose2 and exampleCurve.
 
 First, just find the test case titled test6Choose2 and fix it.
 
 Second, look at the start I made on the function exampleCurve. It's supposed to do an example from Wolfram's documentation. However, it is missing a few lines. You need to fix the function exampleCurve.
 
 To do the second part, you might want to understand what Wolfram wrote on this page: [Bezier Curves]( http://mathworld.wolfram.com/BezierCurve.html ).
 
 ## Binomial Coefficient
 
 We need the binomial coefficent (sometimes called "n choose k").
 
 */

import CoreFoundation

// Here is Swift code for the binomial coefficient.

func binomialCoefficient(n: Int, _ k: Int) -> Int {
    var result = 1
    for i in 0..<k {
        result *= n - i
        result /= i + 1
    }
    return result
}

/*:
 
 ## Bernstein Polynomials
 
 You can see the Bernstein polynomials by going to Wolfram's website: [Bernstein Polynomials]( http://mathworld.wolfram.com/BernsteinPolynomial.html ).
 
 */

typealias ScalarFunction = (Float) -> Float

// Here is a function that produces the Bernstein polynomials:

func bernsteinPolynomial(i: Int, _ n: Int) -> ScalarFunction! {
    
    guard i >= 0 else { return nil }
    guard i <= n else { return nil }
    
    func B_i_n(t: Float) -> Float {
        return Float(binomialCoefficient(n, i)) * pow(t, Float(i)) * pow(1 - t, Float(n - i))
    }
    
    return B_i_n
}

/*:
 
 The advanced part of the above is that bernsteinPolynomial is a function that returns functions! E.g., you supply the function an i and an n, and what you get back is the corresponding Bernstein polynomial.
 
 ## Bezier Curves
 
 The Bernstein polynomials can be used to make Bezier curves!
 
 Wolfram's page on Bezier Curves shows an example with five points &mdash; P0, P1, P2, P3 and P4 &mdash; and a Bezier curve flowing between those points.

 */

// Here are the five points:

typealias Point = (x: Float, y: Float)

let P0: Point = (0, 3)
let P1: Point = (2, 5)
let P2: Point = (4, 0)
let P3: Point = (6, 2)
let P4: Point = (5, 4)

// And here is (a start on) the Bezier curve:

func exampleCurve(t: Float) -> Point {
    let b0 = bernsteinPolynomial(0, 4)(t)
    let b1 = bernsteinPolynomial(1, 4)(t)
    
    // This function is off to a good start, but it is going to take a few more lines to finish it. When you have finished it correctly. the other four test case failures will go away.
    
    return (b0 * P0.x + b1 * P1.x, b0 * P0.y + b1 * P1.y)
}

/*:
 ## Unit Tests
 */

import XCTest

class BezierTestSuite: XCTestCase {
    
    func test6Choose3() {
        let expectedResult = 20
        let result = binomialCoefficient(6, 3)
        XCTAssertEqual(expectedResult, result, "Mismatch in result for binomialCoefficient(6, 3).")
    }
    
    func test6Choose2() {
        XCTAssertEqual(1, 2, "Obviously this will always fail. Replace it with the right test. The previous test is a good example. When you have the right test, one test case failure should go away.")
    }
    
    func testExampleCurveAtEnd() {
        let result = exampleCurve(1)
        let expectedResult: Point = (5, 4)
        XCTAssertEqual(result.x, expectedResult.x, "x-component of result is wrong")
        XCTAssertEqual(result.y, expectedResult.y, "y-component of result is wrong")
    }
    
    func testExampleCurveNearEnd() {
        let result = exampleCurve(0.8)
        let expectedResult: Point = (5.2, 2.6)
        XCTAssertEqualWithAccuracy(result.x, expectedResult.x, accuracy: 0.1, "x-component of result is wrong")
        XCTAssertEqualWithAccuracy(result.y, expectedResult.y, accuracy: 0.1, "y-component of result is wrong")
    }
    
}

class PlaygroundTestObserver : NSObject, XCTestObservation {
    @objc func testCase(testCase: XCTestCase, didFailWithDescription description: String, inFile filePath: String?, atLine lineNumber: UInt) {
        print("Test failed on line \(lineNumber): \(description)")
    }
}

XCTestObservationCenter.sharedTestObservationCenter().addTestObserver(PlaygroundTestObserver())

BezierTestSuite.defaultTestSuite().runTest()




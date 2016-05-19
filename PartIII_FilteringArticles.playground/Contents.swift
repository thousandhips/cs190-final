/*:
 # Part III&mdash;Filtering Articles
 
 Three teams had apps that would have gotten search functions as one of their next features. Let's imagine we we're adding search to the Collegian Online app.
 
 The search text would be taken from a UITextField. It would look something like:
 
    @IBOutlet weak var searchTextField: UITextField!
    let titleContainsSearchWord = titleContainsWordFunction(searchTextField.text)
 
 Below you build titleContainsWordFunction and use it to filter the articles.
 
 ## Directions
 
 Part III A) 2 pts. Finish the function titleContainsWord that takes a CollegianArticle and returns true if and only if the article's title contains the word.
 
 Part III B) 2 pts. Use filter and the function you just made to filter allArticles into annualsOnly.
 
 HINT: title is a String, and Apple's Foundation code has a method on String called containsString that will do almost all the work. If you use that method you have very little code to write.
  */
import Foundation

struct CollegianArticle {
    let title: String
    let date: String
    let teaserText: String
}

func titleContainsWordFunction(word: String) -> (CollegianArticle) -> Bool {
    func titleContainsWord(collegianArticle: CollegianArticle) -> Bool {
        // ===> The following line is broken. This is where you do the work for Part III A. <===
        return true
    }
    return titleContainsWord
}

let titleContainsAnnual = titleContainsWordFunction("Annual")

let annualSpringConcert = CollegianArticle(title: "Annual Spring Concert takes place in Moraga Commons", date: "May 3, 2016", teaserText: "Whether it was the food trucks, summer weather, face painting, or catchy music, Moraga Commons was the place to…")
let annualOneActFestival = CollegianArticle(title: "Annual One Act Festival goes off-road with the Car Plays", date: "May 3, 2016", teaserText: "This weekend concluded the Theatre Program’s One Act Festival, titled The Car Plays, performed over a series of dates…")
let willinghamSpeaksOut = CollegianArticle(title: "Willingham speaks out against mistreatment of college athletes", date: "May 3, 2016", teaserText: "In Claeys Lounge Monday evening, a movie that depicted college athletes getting no education stunned the audience. How can students…")
let editorialReflectingBack = CollegianArticle(title: "Editorial: Reflecting back on four years at the Collegian", date: "May 3, 2016", teaserText: "As cliché as it is, I must start by saying that I cannot believe this is my last piece in…")

let allArticles = [annualSpringConcert, annualOneActFestival, willinghamSpeaksOut, editorialReflectingBack]

titleContainsAnnual(annualSpringConcert)

// ===> The following line is broken. This is where you do the work for Part III B. <===
let annualsOnly = allArticles

/*:
 ## Unit Tests
 */
import XCTest

class FilteringArticlesTestSuite: XCTestCase {
    
    func testContainsAnnualTrue() {
        XCTAssertTrue(titleContainsAnnual(annualSpringConcert), "annualSpringConcert contains \"Annual\".")
    }
    
    func testContainsAnnualFalse() {
        XCTAssertFalse(titleContainsAnnual(willinghamSpeaksOut), "willinghamSpeaksOut doesn't contain \"Annual\".")
    }
    
    func testAnnualsOnly() {
        XCTAssertEqual(2, annualsOnly.count, "Expected to get two articles in the annualsOnly array.")
    }
    
}

class PlaygroundTestObserver : NSObject, XCTestObservation {
    @objc func testCase(testCase: XCTestCase, didFailWithDescription description: String, inFile filePath: String?, atLine lineNumber: UInt) {
        print("Test failed on line \(lineNumber): \(description)")
    }
}

XCTestObservationCenter.sharedTestObservationCenter().addTestObserver(PlaygroundTestObserver())

FilteringArticlesTestSuite.defaultTestSuite().runTest()


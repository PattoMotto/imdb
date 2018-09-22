//Pat

import XCTest

class IMDBUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSearchBatmanShouldSeeMovieListWithDetails() {
        //        TODO: clear recent search
        /**
         on search screen
         search with Batman
         tap search button
         loading show
         success show
         on movie screen
         movie title exist
         movie release date exist
         movie overview exist
         movie poster exist
         */
    }
    
    func testSearchBatmanAndScrollTo30thCell() {
        //        TODO: clear recent search
        /**
         on search screen
         search with Batman
         tap search button
         loading show
         success show
         on movie screen
         scroll to 30th cell
         */
    }
    
    func testSearchWithNotExistMovieShouldShowError() {
        //        TODO: clear recent search
        /**
         on search screen
         search with zzzzz
         tap search button
         loading show
         error show
         on search screen
         recent search not contain zzzzz
         */
    }
    
    func testDifferenceSearch10TimesAndCheckRecentSearch() {
        //        TODO: clear recent search
        /**
         on search screen
         search with batman / super man / iron man / wonder woman / spider man / x men / flash / doctor / marvel / dc
         tap search button
         on movie screen
         tap back
         
         on search screen
         tap search field
         recent search contain batman / super man / iron man / wonder woman / spider man / x men / flash / doctor / marvel / dc
         */
        
    }
    
    func testSearchFromRecentSearch() {
        //        TODO: clear recent search
        //        TODO: mock recent search batman
        /**
         on search screen
         tap search field
         recent search contain batman
         */
    }
}

//
//  ListLaunchesViewControllerTests.swift
//  SpaceXTests
//
//  Created by Eric Granger on 09/02/2021.
//

@testable import SpaceX
import XCTest

class ListLaunchesViewControllerTests: XCTestCase {
    // MARK: - Subject under test
    
    var sut: ListLaunchesViewController!
    var window: UIWindow!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupListLaunchesViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupListLaunchesViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "ListLaunchesViewController") as? ListLaunchesViewController
        sut.fetchLaunches()
    }
    
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: - Test doubles
    
    class ListLaunchesBusinessLogicSpy: ListLaunchesBusinessLogic {
        var launches: [Launch]?
        
        // MARK: Method call expectations
        
        var fetchLaunchesCalled = false
        
        // MARK: Spied methods
        
        func fetchLaunches(request: ListLaunches.FetchLaunches.Request) {
            fetchLaunchesCalled = true
        }
    }
    
    class TableViewSpy: UITableView {
        // MARK: Method call expectations
        
        var reloadDataCalled = false
        
        // MARK: Spied methods
        
        override func reloadData() {
            reloadDataCalled = true
        }
    }
    
    // MARK: - Tests
    
    func testShouldDisplayFetchedLaunches() {
        // Given
        let tableViewSpy = TableViewSpy()
        sut.tableView = tableViewSpy
        
        // When
        let displayedLaunches = [ListLaunches.FetchLaunches.ViewModel.DisplayedLaunch(name: "flacon", date: "Feb, 4 2021", successText: "SUCCESS", successColor: .green, details: "this is the details", flickr: "https://flickr", patch: "https://patch", youtubeId: "abcdefg")]
        let viewModel = ListLaunches.FetchLaunches.ViewModel(displayedLaunches: displayedLaunches)
        sut.displayFetchedLaunches(viewModel: viewModel)
        
        // Then
        XCTAssert(tableViewSpy.reloadDataCalled, "Displaying fetched launches should reload the table view")
    }
    
    func testNumberOfSectionsInTableViewShouldAlwaysBeOne() {
        // Given
        _ = sut.view
        let tableView = sut.tableView
        
        // When
        let numberOfSections = sut.numberOfSections(in: tableView!)
        
        // Then
        XCTAssertEqual(numberOfSections, 1, "The number of table view sections should always be 1")
    }
    
    func testNumberOfRowsInAnySectionShouldEqualNumberOfLaunchesToDisplay() {
        // Given
        _ = sut.view
        let tableView = sut.tableView
        let testDisplayedLaunches = [ListLaunches.FetchLaunches.ViewModel.DisplayedLaunch(name: "flacon", date: "Feb, 4 2021", successText: "SUCCESS", successColor: .green, details: "this is the details", flickr: "https://flickr", patch: "https://patch", youtubeId: "abcdefg")]
        sut.displayedLaunches = testDisplayedLaunches
        
        // When
        let numberOfRows = sut.tableView(tableView!, numberOfRowsInSection: 0)
        
        // Then
        XCTAssertEqual(numberOfRows, testDisplayedLaunches.count, "The number of table view rows should equal the number of launches to display")
    }
    
    func testShouldConfigureTableViewCellToDisplayLaunch() {
        // Given
        _ = sut.view
        let tableView = sut.tableView
        let testDisplayedLaunches = [ListLaunches.FetchLaunches.ViewModel.DisplayedLaunch(name: "flacon", date: "Feb, 4 2021", successText: "SUCCESS", successColor: .green, details: "this is the details", flickr: "https://flickr", patch: "https://patch", youtubeId: "abcdefg")]
        sut.displayedLaunches = testDisplayedLaunches
        
        // When
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView(tableView!, cellForRowAt: indexPath) as! LaunchTableViewCell
        
        // Then
        XCTAssertEqual(cell.nameLabel.text, "flacon", "A properly configured table view cell should display the launch name")
    }
}

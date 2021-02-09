//
//  SpaceXAPITests.swift
//  SpaceXTests
//
//  Created by Eric Granger on 09/02/2021.
//

@testable import SpaceX
import XCTest

class SpaceXAPITests: XCTestCase
{
  // MARK: - Subject under test
  
  var sut: SpaceXAPI!
  var testLaunches: [Launch]!
  
  // MARK: - Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupLaunchesAPI()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: - Test setup
  
  func setupLaunchesAPI()
  {
    sut = SpaceXAPI()
    
    testLaunches = [Seeds.Launches.falcon, Seeds.Launches.starlink]
  }
  
  // MARK: - Test CRUD operations - Optional error
  
  func testFetchLaunchesShouldReturnListOfLaunches_OptionalError()
  {
    // Given
    
    // When
    
    // Then
  }
}

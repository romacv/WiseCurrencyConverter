//
//  WiseCurrencyConverterTests.swift
//  WiseCurrencyConverterTests
//
//  Created by Roman Resenchuk on 17-08-2023.
//

import XCTest
@testable import WiseCurrencyConverter

class MockCurrencyConverterNetworkManager: CurrencyConverterNetworkManager {
    func convertCurrency(from: String, to: String, amount: Double) async throws -> Double {
        return 1.1 // Return dummy conversion rate
    }

    func availableCurrencies() async throws -> [Currency] {
        return [] // Return empty array or dummy currency array
    }
}

class CurrencyConverterNetworkManagerTests: XCTestCase {
    var manager: CurrencyConverterNetworkManager!

    override func setUp() {
        super.setUp()
        manager = MockCurrencyConverterNetworkManager()
    }

    override func tearDown() {
        manager = nil
        super.tearDown()
    }

    func testConvertCurrency() async throws {
        let conversionRate = try await manager.convertCurrency(from: "USD", to: "EUR", amount: 1.0)
        XCTAssertEqual(conversionRate, 1.1)
    }

    func testAvailableCurrencies() async throws {
        let currencies = try await manager.availableCurrencies()
        XCTAssertTrue(currencies.isEmpty) // Verify currencies matches mock response
    }
}

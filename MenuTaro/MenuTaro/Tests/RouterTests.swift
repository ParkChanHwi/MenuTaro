//
//  RouterTests.swift
//  MenuTaro
//
//  Created by mac mini on 10/1/25.
//


import XCTest
@testable import MenuTaro

final class RouterTests: XCTestCase {
    @MainActor
    func testPushPopAndPopToRoot() {
        let router = Router()
        XCTAssertTrue(router.persistedIdentifiers.isEmpty)

        router.push(.bookmarkList(category: nil))
        XCTAssertEqual(router.persistedIdentifiers.count, 1)

        router.push(.snackFortune(step: .selection))
        XCTAssertEqual(router.persistedIdentifiers.count, 2)

        router.pop()
        XCTAssertEqual(router.persistedIdentifiers.count, 1)

        router.popToRoot()
        XCTAssertTrue(router.persistedIdentifiers.isEmpty)
    }

    @MainActor
    func testPopToSpecificRoute() {
        let router = Router()
        router.push(.snackFortune(step: .selection))
        router.push(.snackFortune(step: .opening))
        router.push(.snackFortune(step: .reveal))

        router.pop(to: .snackFortune(step: .selection))
        XCTAssertEqual(router.persistedIdentifiers.map(\.value), [SnackFortuneStep.selection.rawValue])
    }

    @MainActor
    func testGuardedNavigation() {
        let router = Router()
        router.navigateIf({ true }, success: .push(.bookmarkList(category: nil)))
        router.navigateIf({ false }, success: .push(.snackFortune(step: .selection)), failure: .popToRoot)

        XCTAssertEqual(router.persistedIdentifiers.count, 1)
    }

    @MainActor
    func testAsyncCompletion() {
        let expectation = expectation(description: "async navigation executed")
        let router = Router()

        router.onAsyncCompletion {
            try? await Task.sleep(nanoseconds: 50_000_000)
            return .push(.snackFortune(step: .selection))
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            if router.persistedIdentifiers.first?.value == SnackFortuneStep.selection.rawValue {
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 1)
    }

    @MainActor
    func testRestoreFromIdentifiers() {
        let router = Router()
        let identifiers = [
            AppRoute.snackFortune(step: .selection).identifier,
            AppRoute.bookmarkList(category: .korean).identifier
        ]

        router.restore(using: identifiers)
        XCTAssertEqual(router.persistedIdentifiers, identifiers)
    }
}

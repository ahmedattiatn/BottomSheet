
@testable import BottomSheet
import XCTest

@MainActor
final class BottomSheetViewModelTests: XCTestCase {
    // MARK: Internal

    // MARK: - SnapToNearestDetent Tests

    /// Ensures the sheet snaps **from closed to open** when the upward velocity
    /// exceeds the defined velocity threshold.
    func test_snapToNearestDetent_closedToOpen_dueToHighVelocity() throws {
        let behavior = twoDetentsBehavior()
        let result = sut.snapToNearestDetent(
            behavior: behavior,
            sheetHeight: 160,
            availableHeight: availableHeight,
            translation: -100,
            velocity: -(behavior.drag.velocityThreshold + 1) // negative => UP direction
        )

        XCTAssertEqual(result, behavior.detents.values.last)
    }

    /// Ensures the sheet stays **closed** when the upward velocity
    /// is below the defined velocity threshold.
    func test_snapToNearestDetent_closedToClosed_dueToLowVelocity() throws {
        let behavior = twoDetentsBehavior()
        let result = sut.snapToNearestDetent(
            behavior: behavior,
            sheetHeight: 160,
            availableHeight: availableHeight,
            translation: -100,
            velocity: -(behavior.drag.velocityThreshold - 1) // negative => UP direction
        )

        XCTAssertEqual(result, behavior.detents.values.first)
    }

    /// Ensures the sheet stays **closed** when translation distance
    /// is too small to trigger a detent change.
    func test_snapToNearestDetent_closedToClosed_dueToSmallTranslation() throws {
        let behavior = twoDetentsBehavior()
        let sheetHeightClosed = behavior.detents.values.first!.toAbsolute(for: availableHeight)
        let translation = (availableHeight * 0.4) - sheetHeightClosed
        let sheetHeight = sheetHeightClosed

        let result = sut.snapToNearestDetent(
            behavior: behavior,
            sheetHeight: sheetHeight,
            availableHeight: availableHeight,
            translation: -translation,
            velocity: 0
        )

        XCTAssertEqual(result, behavior.detents.values.first)
    }

    /// Ensures the sheet snaps **from closed to open** when translation distance
    /// is large enough, even with zero velocity.
    func test_snapToNearestDetent_closedToOpen_dueToLargeTranslation() throws {
        let behavior = twoDetentsBehavior()
        let sheetHeightClosed = behavior.detents.values.first!.toAbsolute(for: availableHeight)
        let translation = (availableHeight * 0.7) - sheetHeightClosed
        let sheetHeight = sheetHeightClosed

        let result = sut.snapToNearestDetent(
            behavior: behavior,
            sheetHeight: sheetHeight,
            availableHeight: availableHeight,
            translation: -translation,
            velocity: 0
        )

        XCTAssertEqual(result, behavior.detents.values.last)
    }

    // MARK: - SheetHeight Tests

    /// Ensures sheet height is calculated **without resistance**
    /// when dragging within the range of defined detents.
    func test_sheetHeight_withoutResistance_betweenDetents() throws {
        let behavior = twoDetentsBehavior()
        let translation: CGFloat = -100
        let sheetHeightClosed = behavior.detents.values.first!.toAbsolute(for: availableHeight)

        let result = sut.sheetHeight(
            availableHeight: availableHeight,
            translation: translation,
            behavior: behavior
        )

        XCTAssertEqual(result, sheetHeightClosed - translation)
    }

    /// Ensures sheet height is calculated **with resistance**
    /// when dragging below the lowest detent.
    func test_sheetHeight_withResistance_belowMinimumDetent() throws {
        let behavior = twoDetentsBehavior()
        let translation: CGFloat = 10 // Below the first detent
        let sheetHeightClosed = behavior.detents.values.first!.toAbsolute(for: availableHeight)

        let result = sut.sheetHeight(
            availableHeight: availableHeight,
            translation: translation,
            behavior: behavior
        )

        XCTAssertEqual(result, sheetHeightClosed - (translation * 0.2))
    }

    // MARK: Private

    // MARK: - Helpers

    /// System under test: an instance of `BottomSheetViewModel`.
    private lazy var sut = BottomSheetViewModel()

    /// Simulated available screen height used in tests.
    private let availableHeight: CGFloat = 800.0

    /// Creates a `SheetBehavior` with two detents:
    /// - A small relative detent (`0.1`)
    /// - A full-height relative detent (`1.0`)
    private func twoDetentsBehavior() -> SheetBehavior {
        let heights: [SheetDetentHeight] = [.relative(0.1), .relative(1)]
        return .init(
            drag: .defaultValue,
            width: .absolute(200),
            detents: .init(values: heights, current: heights.first),
            alignment: .center
        )
    }
}

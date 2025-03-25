import SwiftUI

func withoutAnimation(action: @escaping () -> Void, completion: @escaping () -> Void = {}) {
    var transaction = Transaction()
    transaction.disablesAnimations = true
    transaction.addAnimationCompletion(criteria: .removed, completion)
    withTransaction(transaction) {
        action()
    }
}

import SwiftUI

extension Transaction {
    static func with<Result>(animation: Animation? = .default,
                     body: @escaping () throws -> Result,
                     completion: @escaping () -> Void = {}
    ) rethrows -> Result {
        var transaction = Transaction()
        transaction.animation = animation
        transaction.disablesAnimations = animation == nil
        transaction.addAnimationCompletion(criteria: .removed, completion)
        return try withTransaction(transaction, body)
    }
}

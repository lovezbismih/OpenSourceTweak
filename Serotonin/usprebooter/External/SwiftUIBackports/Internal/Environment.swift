import SwiftUI
//

/*
 The following code is for debugging purposes only!
 */

#if DEBUG
extension EnvironmentValues: CustomDebugStringConvertible {
    public var debugDescription: String {
        "\(self)"
            .trimmingCharacters(in: .init(["[", "]"]))
            .replacingOccurrences(of: "EnvironmentPropertyKey", with: "")
            .replacingOccurrences(of: ", ", with: "\n")
    }
}

struct EnvironmentOutputModifier: ViewModifier {
    @Environment(\.self) private var environment

    func body(content: Content) -> some View {
        content
    }
}
extension View {
    func printEnvironment() -> some View {
        modifier(EnvironmentOutputModifier())
    }
}
#endif

import SwiftUI

/// The label (icon + optional text) shown in the macOS menu bar.
///
/// Uses custom SVG artwork from the app asset catalog (template-rendered
/// so macOS tints for light/dark menu bars automatically).
public struct MenuBarLabelView: View {
    @Bindable var viewModel: MenuBarViewModel

    /// Asset catalog name for the idle menu-bar icon.
    public static let idleIconName = "MenuBarIcon"

    /// Asset catalog name for the recording menu-bar icon.
    public static let recordingIconName = "MenuBarIconRecording"

    public init(viewModel: MenuBarViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        HStack(spacing: 4) {
            menuBarIcon
            if case let .nextMeeting(title, time) = viewModel
                .iconState
            {
                Text("\(title) \u{2013} \(time)")
                    .font(.caption)
                    .monospacedDigit()
            }
        }
    }

    private var menuBarIcon: some View {
        let name = viewModel.iconState == .recording
            ? Self.recordingIconName
            : Self.idleIconName
        return Image(name, bundle: .main)
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 18)
    }
}

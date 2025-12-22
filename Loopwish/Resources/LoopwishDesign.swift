import Foundation

public enum LoopwishTheme: String {
    case light
    case dark
}

public enum LoopwishColorRole: String, CaseIterable {
    case textPrimary = "color.text.primary"
    case textSecondary = "color.text.secondary"
    case textOnAccent = "color.text.onAccent"

    case surfaceCanvas = "color.surface.canvas"
    case surfaceElevated = "color.surface.elevated"
    case surfaceAccent = "color.surface.accent"

    case borderDefault = "color.border.default"
    case borderFocus = "color.border.focus"

    case actionPrimaryBackground = "color.action.primary.bg"
    case actionPrimaryForeground = "color.action.primary.fg"
    case actionSecondaryForeground = "color.action.secondary.fg"

    case stateHover = "color.state.hover"
    case statePressed = "color.state.pressed"
    case stateDisabled = "color.state.disabled"
}

public enum LoopwishDesign {
    public static func tagline() -> String {
        TokensCache.shared.tokens?.content.tagline ?? "Ønsk. Del. Få. Sammen."
    }

    public static func hex(_ role: LoopwishColorRole, theme: LoopwishTheme = .light) -> String {
        guard let tokens = TokensCache.shared.tokens else {
            return Defaults.hex(role: role)
        }

        let rawValue: String?
        switch theme {
        case .light:
            rawValue = tokens.semantic.light[role.rawValue]
        case .dark:
            rawValue = tokens.semantic.dark[role.rawValue]
        }

        guard let rawValue else {
            return Defaults.hex(role: role)
        }

        if let resolved = TokenResolver.resolve(rawValue, tokens: tokens) {
            return resolved
        }

        return Defaults.hex(role: role)
    }
}

private struct TokensFile: Decodable {
    struct Primitives: Decodable {
        let colors: [String: String]
    }

    struct Semantic: Decodable {
        let light: [String: String]
        let dark: [String: String]
    }

    struct Content: Decodable {
        let tagline: String
    }

    let primitives: Primitives
    let semantic: Semantic
    let content: Content
}

private enum TokenResolver {
    static func resolve(_ raw: String, tokens: TokensFile) -> String? {
        if raw.hasPrefix("#") {
            return raw
        }

        // Supports aliases like: {primitives.colors.textDark}
        if raw.hasPrefix("{") && raw.hasSuffix("}") {
            let start = raw.index(after: raw.startIndex)
            let end = raw.index(before: raw.endIndex)
            let path = String(raw[start..<end])

            // Minimal resolver for v1: primitives.colors.<key>
            let prefix = "primitives.colors."
            guard path.hasPrefix(prefix) else {
                return nil
            }
            let key = String(path.dropFirst(prefix.count))
            return tokens.primitives.colors[key]
        }

        return nil
    }
}

private enum Defaults {
    static func hex(role: LoopwishColorRole) -> String {
        switch role {
        case .textPrimary:
            return "#2C3E50"
        case .textSecondary:
            return "#7F8C8D"
        case .textOnAccent:
            return "#FFFFFF"
        case .surfaceCanvas, .surfaceElevated:
            return "#FFFFFF"
        case .surfaceAccent:
            return "#5DADE2"
        case .borderDefault:
            return "#7F8C8D"
        case .borderFocus:
            return "#AF7AC5"
        case .actionPrimaryBackground:
            return "#5DADE2"
        case .actionPrimaryForeground:
            return "#FFFFFF"
        case .actionSecondaryForeground:
            return "#AF7AC5"
        case .stateHover:
            return "#AF7AC5"
        case .statePressed:
            return "#5DADE2"
        case .stateDisabled:
            return "#7F8C8D"
        }
    }
}

private final class TokensCache {
    static let shared = TokensCache()

    let tokens: TokensFile?

    private init() {
        self.tokens = TokensCache.loadTokens()
    }

    private static func loadTokens() -> TokensFile? {
        guard let url = Bundle.module.url(forResource: "tokens", withExtension: "json", subdirectory: "vendor/shared/design-tokens") else {
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(TokensFile.self, from: data)
        } catch {
            return nil
        }
    }
}

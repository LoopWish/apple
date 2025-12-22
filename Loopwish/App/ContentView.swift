import SwiftUI
import LoopwishResources

struct ContentView: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        let theme: LoopwishTheme = colorScheme == .dark ? .dark : .light

        ZStack {
            Color(hex: LoopwishDesign.hex(.surfaceCanvas, theme: theme))
                .ignoresSafeArea()

            VStack(spacing: 12) {
                Text("Loopwish")
                    .font(.system(size: 34, weight: .semibold))
                    .foregroundStyle(Color(hex: LoopwishDesign.hex(.textPrimary, theme: theme)))

                Text(LoopwishDesign.tagline())
                    .font(.system(size: 17))
                    .foregroundStyle(Color(hex: LoopwishDesign.hex(.textSecondary, theme: theme)))

                Button(action: {}) {
                    Text("Kom i gang")
                        .font(.system(size: 17, weight: .semibold))
                        .padding(.horizontal, 18)
                        .padding(.vertical, 10)
                }
                .background(Color(hex: LoopwishDesign.hex(.actionPrimaryBackground, theme: theme)))
                .foregroundStyle(Color(hex: LoopwishDesign.hex(.actionPrimaryForeground, theme: theme)))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .padding(.top, 12)

                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color(hex: LoopwishDesign.hex(.surfaceElevated, theme: theme)))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(Color(hex: LoopwishDesign.hex(.borderDefault, theme: theme)), lineWidth: 1)
                    )
                    .frame(height: 120)
                    .overlay(
                        Text("Dette er en liten demo-skjerm for design tokens")
                            .multilineTextAlignment(.center)
                            .padding(16)
                            .foregroundStyle(Color(hex: LoopwishDesign.hex(.textPrimary, theme: theme)))
                    )
                    .padding(.top, 8)
            }
            .padding(24)
            .frame(maxWidth: 520)
        }
    }
}

private extension Color {
    init(hex: String) {
        let cleaned = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        let value = UInt64(cleaned, radix: 16) ?? 0

        let r, g, b: Double
        if cleaned.count == 6 {
            r = Double((value >> 16) & 0xFF) / 255.0
            g = Double((value >> 8) & 0xFF) / 255.0
            b = Double(value & 0xFF) / 255.0
        } else {
            r = 0
            g = 0
            b = 0
        }

        self.init(.sRGB, red: r, green: g, blue: b, opacity: 1)
    }
}

# BlinkZo - SwiftHack

A comprehensive iOS application for smart planning, expense management, and pantry intelligence.

## Features

- **Occasion Planning**: Intelligent event planning with AI-powered recommendations
- **Smart Fridge**: Pantry analysis and recipe suggestions based on available ingredients
- **Expense Tracking**: Split expenses and settlement management
- **AI Reasoning**: Foundation model-powered insights and planning assistance
- **Home Dashboard**: Quick access to key features and recommendations
- **User Profile**: Family management and personalized settings

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

## Project Structure

```
Gather/
├── Sources/
│   ├── App/              # Application entry point
│   ├── Components/       # Reusable UI components
│   ├── DesignSystem/     # Theme and design tokens
│   ├── Models/           # Data models
│   ├── Services/         # Business logic and API
│   ├── ViewModels/       # MVVM view models
│   └── Views/            # Screen implementations
├── Info.plist            # App configuration
└── project.yml           # XcodeGen project definition
```

## Setup Instructions

1. Clone the repository
2. Navigate to the `Gather` directory
3. Generate Xcode project:
   ```bash
   xcodegen generate
   ```
4. Open `Gather.xcodeproj` in Xcode
5. Build and run on simulator or device

## Architecture

- **MVVM Pattern**: Separation of UI, business logic, and data
- **Service Layer**: Centralized API and business logic
- **Design System**: Consistent theming with `Color+Extensions` and `Typography`
- **Component-Based**: Modular, reusable UI components

## License

Private Project
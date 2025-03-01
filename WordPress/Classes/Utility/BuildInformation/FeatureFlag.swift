/// FeatureFlag exposes a series of features to be conditionally enabled on
/// different builds.
@objc
enum FeatureFlag: Int, CaseIterable, OverrideableFlag {
    case bloggingPrompts
    case bloggingPromptsEnhancements
    case bloggingPromptsSocial
    case jetpackDisconnect
    case debugMenu
    case readerCSS
    case homepageSettings
    case unifiedPrologueCarousel
    case todayWidget
    case milestoneNotifications
    case bloggingReminders
    case siteIconCreator
    case weeklyRoundup
    case weeklyRoundupStaticNotification
    case weeklyRoundupBGProcessingTask
    case domains
    case timeZoneSuggester
    case mediaPickerPermissionsNotice
    case notificationCommentDetails
    case siteIntentQuestion
    case landInTheEditor
    case statsNewAppearance
    case statsNewInsights
    case siteName
    case quickStartForExistingUsers
    case qrLogin
    case betaSiteDesigns
    case featureHighlightTooltip
    case jetpackPowered
    case jetpackPoweredBottomSheet
    case contentMigration
    case newJetpackLandingScreen
    case newWordPressLandingScreen
    case newCoreDataContext
    case jetpackMigrationPreventDuplicateNotifications
    case jetpackFeaturesRemovalPhaseOne
    case jetpackFeaturesRemovalPhaseTwo
    case jetpackFeaturesRemovalPhaseThree
    case jetpackFeaturesRemovalPhaseFour
    case jetpackFeaturesRemovalPhaseNewUsers
    case jetpackFeaturesRemovalPhaseSelfHosted
    case wordPressSupportForum
    case jetpackIndividualPluginSupport
    case blaze

    /// Returns a boolean indicating if the feature is enabled
    var enabled: Bool {
        if let overriddenValue = FeatureFlagOverrideStore().overriddenValue(for: self) {
            return overriddenValue
        }

        switch self {
        case .bloggingPrompts:
            return AppConfiguration.isJetpack
        case .bloggingPromptsEnhancements:
            return AppConfiguration.isJetpack
        case .bloggingPromptsSocial:
            return false
        case .jetpackDisconnect:
            return BuildConfiguration.current == .localDeveloper
        case .debugMenu:
            return BuildConfiguration.current ~= [.localDeveloper, .a8cBranchTest, .a8cPrereleaseTesting]
        case .readerCSS:
            return false
        case .homepageSettings:
            return true
        case .unifiedPrologueCarousel:
            return true
        case .todayWidget:
            return true
        case .milestoneNotifications:
            return true
        case .bloggingReminders:
            return true
        case .siteIconCreator:
            return BuildConfiguration.current != .appStore
        case .weeklyRoundup:
            return true
        case .weeklyRoundupStaticNotification:
            // This may be removed, but we're feature flagging it for now until we know for sure we won't need it.
            return false
        case .weeklyRoundupBGProcessingTask:
            return true
        case .domains:
            // Note: when used to control access to the domains feature, you should also check whether
            // the current AppConfiguration and blog support domains.
            // See BlogDetailsViewController.shouldShowDomainRegistration for an example.
            return true
        case .timeZoneSuggester:
            return true
        case .mediaPickerPermissionsNotice:
            return true
        case .notificationCommentDetails:
            return true
        case .siteIntentQuestion:
            return true
        case .landInTheEditor:
            return false
        case .statsNewAppearance:
            return AppConfiguration.showsStatsRevampV2
        case .statsNewInsights:
            return AppConfiguration.showsStatsRevampV2
        case .siteName:
            return false
        case .quickStartForExistingUsers:
            return true
        case .qrLogin:
            return true
        case .betaSiteDesigns:
            return false
        case .featureHighlightTooltip:
            return true
        case .jetpackPowered:
            return true
        case .jetpackPoweredBottomSheet:
            return true
        case .contentMigration:
            return true
        case .newJetpackLandingScreen:
            return true
        case .newWordPressLandingScreen:
            return true
        case .newCoreDataContext:
            return true
        case .jetpackMigrationPreventDuplicateNotifications:
            return true
        case .jetpackFeaturesRemovalPhaseOne:
            return false
        case .jetpackFeaturesRemovalPhaseTwo:
            return false
        case .jetpackFeaturesRemovalPhaseThree:
            return false
        case .jetpackFeaturesRemovalPhaseFour:
            return false
        case .jetpackFeaturesRemovalPhaseNewUsers:
            return false
        case .jetpackFeaturesRemovalPhaseSelfHosted:
            return false
        case .wordPressSupportForum:
            return false
        case .jetpackIndividualPluginSupport:
            return false
        case .blaze:
            return false
        }
    }

    var disabled: Bool {
        return enabled == false
    }

    /// This key must match the server-side one for remote feature flagging
    var remoteKey: String? {
        switch self {
        case .jetpackFeaturesRemovalPhaseOne:
            return "jp_removal_one"
        case .jetpackFeaturesRemovalPhaseTwo:
            return "jp_removal_two"
        case .jetpackFeaturesRemovalPhaseThree:
            return "jp_removal_three"
        case .jetpackFeaturesRemovalPhaseFour:
            return "jp_removal_four"
        case .jetpackFeaturesRemovalPhaseNewUsers:
            return "jp_removal_new_users"
        case .jetpackFeaturesRemovalPhaseSelfHosted:
            return "jp_removal_self_hosted"
        case .jetpackMigrationPreventDuplicateNotifications:
            return "prevent_duplicate_notifs_remote_field"
        case .wordPressSupportForum:
            return "enable_wordpress_support_forum"
        case .blaze:
            return "blaze"
            default:
                return nil
        }
    }
}

/// Objective-C bridge for FeatureFlag.
///
/// Since we can't expose properties on Swift enums we use a class instead
class Feature: NSObject {
    /// Returns a boolean indicating if the feature is enabled
    @objc static func enabled(_ feature: FeatureFlag) -> Bool {
        return feature.enabled
    }
}

extension FeatureFlag {
    /// Descriptions used to display the feature flag override menu in debug builds
    var description: String {
        switch self {
        case .bloggingPrompts:
            return "Blogging Prompts"
        case .bloggingPromptsEnhancements:
            return "Blogging Prompts Enhancements"
        case .bloggingPromptsSocial:
            return "Blogging Prompts Social"
        case .jetpackDisconnect:
            return "Jetpack disconnect"
        case .debugMenu:
            return "Debug menu"
        case .readerCSS:
            return "Ignore Reader CSS Cache"
        case .homepageSettings:
            return "Homepage Settings"
        case .unifiedPrologueCarousel:
            return "Unified Prologue Carousel"
        case .todayWidget:
            return "iOS 14 Today Widget"
        case .milestoneNotifications:
            return "Milestone notifications"
        case .bloggingReminders:
            return "Blogging Reminders"
        case .siteIconCreator:
            return "Site Icon Creator"
        case .weeklyRoundup:
            return "Weekly Roundup"
        case .weeklyRoundupStaticNotification:
            return "Weekly Roundup Static Notification"
        case .weeklyRoundupBGProcessingTask:
            return "Weekly Roundup BGProcessingTask"
        case .domains:
            return "Domain Purchases"
        case .timeZoneSuggester:
            return "TimeZone Suggester"
        case .mediaPickerPermissionsNotice:
            return "Media Picker Permissions Notice"
        case .notificationCommentDetails:
            return "Notification Comment Details"
        case .siteIntentQuestion:
            return "Site Intent Question"
        case .landInTheEditor:
            return "Land In The Editor"
        case .statsNewAppearance:
            return "New Appearance for Stats"
        case .statsNewInsights:
            return "New Cards for Stats Insights"
        case .siteName:
            return "Site Name"
        case .quickStartForExistingUsers:
            return "Quick Start For Existing Users"
        case .qrLogin:
            return "QR Code Login"
        case .betaSiteDesigns:
            return "Fetch Beta Site Designs"
        case .featureHighlightTooltip:
            return "Feature Highlight Tooltip"
        case .jetpackPowered:
            return "Jetpack powered banners and badges"
        case .jetpackPoweredBottomSheet:
            return "Jetpack powered bottom sheet"
        case .contentMigration:
            return "Content Migration"
        case .newJetpackLandingScreen:
            return "New Jetpack landing screen"
        case .newWordPressLandingScreen:
            return "New WordPress landing screen"
        case .newCoreDataContext:
            return "Use new Core Data context structure (Require app restart)"
        case .jetpackMigrationPreventDuplicateNotifications:
            return "Jetpack Migration prevent duplicate WordPress app notifications when Jetpack is installed"
        case .jetpackFeaturesRemovalPhaseOne:
            return "Jetpack Features Removal Phase One"
        case .jetpackFeaturesRemovalPhaseTwo:
            return "Jetpack Features Removal Phase Two"
        case .jetpackFeaturesRemovalPhaseThree:
            return "Jetpack Features Removal Phase Three"
        case .jetpackFeaturesRemovalPhaseFour:
            return "Jetpack Features Removal Phase Four"
        case .jetpackFeaturesRemovalPhaseNewUsers:
            return "Jetpack Features Removal Phase For New Users"
        case .jetpackFeaturesRemovalPhaseSelfHosted:
            return "Jetpack Features Removal Phase For Self-Hosted Sites"
        case .wordPressSupportForum:
            return "Provide support through a forum"
        case .jetpackIndividualPluginSupport:
            return "Jetpack Individual Plugin Support"
        case .blaze:
            return "Blaze"
        }
    }

    var canOverride: Bool {
        switch self {
        case .debugMenu:
            return false
        case .todayWidget:
            return false
        case .weeklyRoundup:
            return false
        case .weeklyRoundupStaticNotification:
            return false
        default:
            return true
        }
    }
}

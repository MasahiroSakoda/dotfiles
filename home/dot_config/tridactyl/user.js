// -*-mode:javascript-*- vim:ft=javascript

// Disable auto update
user_pref("app.update.auto", false);

// about:* settings
user_pref("browser.aboutConfig.showWarning", false)
user_pref("browser.aboutwelcome.enabled", false)
user_pref("browser.uitour.enabled", false)

// Crash reports
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit", false)
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false)
user_pref("browser.crashReports.unsubmittedCheck.enabled", false)

// Cache
user_pref("browser.cache.disk.capacity", 512000)
user_pref("browser.cache.offline.enable", true)

// Fullscreen
user_pref("browser.fullscreen.exit_on_escape", false)
user_pref("full-screen-api.transition-duration.enter", "0 0")
user_pref("full-screen-api.transition-duration.leave", "0 0")
user_pref("full-screen-api.warning.delay", -1)
user_pref("full-screen-api.warning.timeout", 0)

// Tab
user_pref("startup.homepage_welcome_url", "about:blank")
user_pref("browser.tabs.animate", false);
user_pref("browser.tabs.closeWindowWithLastTab", false);
user_pref("browser.tabs.insertRelatedAfterCurrent", true);
user_pref("browser.tabs.selectOwnerOnClose", false);
user_pref("browser.tabs.crashReporting.sendReport", false)
user_pref("browser.tabs.tabmanager.enabled", false)
user_pref("browser.tabs.warnOnClose", false)
user_pref("browser.tabs.warnOnOpen", false)

// URL bar
user_pref("browser.urlbar.groupLabels.enabled", false)
user_pref("browser.urlbar.quicksuggest.enabled", false)
user_pref("browser.urlbar.suggest.searches", false)
user_pref("browser.urlbar.suggest.engines", false)
user_pref("browser.urlbar.suggest.calculator", false)
user_pref("browser.urlbar.suggest.history", false)
user_pref("browser.urlbar.suggest.openpage", false)
user_pref("browser.urlbar.suggest.quicksuggest.nonsponsored", false)
user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false)
user_pref("browser.urlbar.suggest.topsites", false)
user_pref("browser.urlbar.trending.featureGate", false)
user_pref("browser.urlbar.trimURLs", false);

// Link
user_pref("browser.link.open_external", 2)
user_pref("browser.link.open_newwindow", 2)

// Misc
user_pref("browser.feeds.showFirstRunUI", false);
user_pref("ui.submenuDelay", 0);

// Plugin
user_pref("plugin.expose_full_path", true);

// Network
user_pref("network.buffer.cache.count", 128)
user_pref("network.cookie.cookieBehavior", 1)
user_pref("network.cookie.sameSite.noneRequiresSecure", true)
user_pref("network.dnsCacheExpiration", 3600)
user_pref("network.http.max-connections", 1000)
user_pref("network.http.max-persistent-connections-per-server", 10)
user_pref("network.http.max-urgent-start-excessive-connections-per-host", 5)

user_pref("browser.privatebrowsing.enable-new-indicator", false)

// Security
user_pref("security.ssl.require_safe_negotiation", true)
user_pref("security.ssl.treat_unsafe_negotiation_as_broken", true)
user_pref("security.warn_entering_secure.show_once", true)
user_pref("security.warn_entering_secure", true)
user_pref("security.warn_submit_insecure", true)
user_pref("security.warn_viewing_mixed", true);
user_pref("security.warn_viewing_mixed.show_once", false);

// Telemetry
user_pref("toolkit.telemetry.archive.enabled", false)
user_pref("toolkit.telemetry.bhrPing.enabled", false)
user_pref("toolkit.telemetry.cachedClientID", "")
user_pref("toolkit.telemetry.coverage.opt-out", true)
user_pref("toolkit.telemetry.enabled", false)
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false)
user_pref("toolkit.telemetry.hybridContent.enabled", false)
user_pref("toolkit.telemetry.newProfilePing.enabled", false)
user_pref("toolkit.telemetry.prompted", 2)
user_pref("toolkit.telemetry.rejected", true)
user_pref("toolkit.telemetry.reportingpolicy.firstRun", false)
user_pref("toolkit.telemetry.server", "")
user_pref("toolkit.telemetry.server", "data:,")
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false)
user_pref("toolkit.telemetry.unified", false)
user_pref("toolkit.telemetry.unifiedIsOptIn", false)
user_pref("toolkit.telemetry.updatePing.enabled", false)

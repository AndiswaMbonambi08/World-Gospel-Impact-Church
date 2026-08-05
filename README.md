# WGIC app (frontend scaffold)

Flutter frontend for World Gospel Impact Church, covering:
- Ministry sign-up (new users pick their group before entering the app)
- Home screen with centered logo header, ministry filter tabs, event list
- RSVP for free events, "Buy ticket" flow for ticketed events (payment
  integration is stubbed — see `_handleEventAction` in `home_screen.dart`)
- Tithe/giving entry point (currently a placeholder tap target — wire up
  to PayFast/PayGate or your existing donation form link)

## Structure

```
lib/
  main.dart                        # app entry
  theme/app_theme.dart             # black and white theme
  models/
    ministry.dart                  # ministry list (Youth, Band, Media, ...)
    event_item.dart                # event + ticket fields
  widgets/
    logo_header.dart                # centered logo, swap in real logo asset
    event_card.dart                 # event row with RSVP/ticket button
  screens/
    ministry_signup_screen.dart     # onboarding: pick a ministry
    home_screen.dart                # events feed, filters, tithe button
```

## Running it

1. Install Flutter SDK if not already set up.
2. Place actual WGIC logo files in `assets/images/` (e.g.
   `wgic_logo_white.png`, `wgic_logo_black.png`) and swap the placeholder
   `Container` in `logo_header.dart` for `Image.asset(...)`.
3. From the project root:
   ```
   flutter pub get
   flutter run
   ```

## Next steps (not yet built)
- Backend API (ASP.NET Core) for real ministry membership, RSVPs, tickets
- Real auth (JWT, same pattern as SheRides)
- Payment gateway integration for ticketed events and tithes
- Push notifications (Firebase Cloud Messaging) for event reminders
- Admin view for pastoral/admin roles to see registration numbers
- Year-end ministry survey screen

## Screenshots
<img width="609" height="939" alt="Screenshot_5-8-2026_23721_localhost" src="https://github.com/user-attachments/assets/04009d71-9538-4b57-9687-4845b2411b67" />


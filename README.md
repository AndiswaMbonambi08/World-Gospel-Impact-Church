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
<img width="615" height="944" alt="Screenshot_5-8-2026_23927_localhost" src="https://github.com/user-attachments/assets/c3fbc4dd-e9e6-49b5-acd5-a1149ed5d975" />
<img width="611" height="944" alt="Screenshot_5-8-2026_2393_localhost" src="https://github.com/user-attachments/assets/84d8d210-989c-40b8-85d7-e0ac155f46af" />
<img width="614" height="939" alt="Screenshot_5-8-2026_23829_localhost" src="https://github.com/user-attachments/assets/5bb6fdb7-3c11-4f35-ac4e-8b4d7ccd05d6" />
<img width="611" height="941" alt="Screenshot_5-8-2026_231029_localhost" src="https://github.com/user-attachments/assets/89ace03c-2a1e-44e1-90b4-764574313d4b" />
<img width="611" height="935" alt="Screenshot_5-8-2026_23101_localhost" src="https://github.com/user-attachments/assets/d49d5f27-a4bf-4e89-a4e9-4d18ec192269" />



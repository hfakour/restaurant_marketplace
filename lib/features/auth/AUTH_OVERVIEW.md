# Auth Feature – Overview

This module implements **email/optional** registration and **email/password login** on top of **Firebase Auth** with a clean, layered architecture that mirrors the Reservations feature. It also creates/maintains a **UserProfile** document in Firestore so the rest of the app (e.g., Reservations, Profile) can safely consume the authenticated user’s ID and basic details.

> **Key design choice:** We **do not** add a separate *Auth DTO model*. Instead, we map Firebase’s `User` **directly** to domain **entities** (`AuthAccount`, `AuthTokens`) and handle persistence through Firestore for the `UserProfile`. This keeps the layer count minimal and avoids storing sensitive auth state beyond what’s necessary.

---

# Folder Structure

```
features/auth/
├─ data/
│  ├─ datasources/
│  │  └─ auth_remote_ds.dart
│  ├─ mappers/
│  │  ├─ auth_mappers.dart
│  │  └─ user_profile_mappers.dart
│  ├─ repositories/
│  │  └─ auth_repository_impl.dart
├─ domain/
│  ├─ entities/
│  │  ├─ auth_entities.dart
│  │  └─ auth_failures.dart
│  ├─ repositories/
│  │  └─ auth_repository.dart
│  └─ usecase/
│     ├─ register_with_email.dart
│     └─ login_with_email.dart
└─ presentation/
   ├─ bloc/
   │  └─ signup/
   │     ├─ auth_signup_cubit.dart
   │     └─ auth_signup_state.dart
   ├─ controllers/
   │  └─ auth_controller.dart
   ├─ screens/
   │  ├─ signup_page.dart
   │  ├─ login_page.dart
   │  └─ auth_gate.dart
   └─ widgets/
      └─ (optional helpers)
```

---

# Domain Layer

## `entities/auth_entities.dart`

Defines the core, storage-agnostic **auth entities** used across the feature and consumed by the rest of the app.

* **`AuthStatus`** – lifecycle state for UI: `unauthenticated`, `authenticating`, `authenticated`, `refreshing`.
* **`AuthProvider`** – linked providers: `password`, `google`, `apple`, `phone`, `anonymous`.
* **`AuthTokens`** – access/refresh tokens (if your backend issues them). Includes helpers: `isAccessExpired`, `authorizationHeader`.
* **`AuthAccount`** – domain-safe identity derived from Firebase `User`:

    * `id` (Firebase UID), `email`, `displayName`, `avatarUrl`, verification flags, provider set.
    * `profileId` is **the same as UID** for 1:1 mapping to `UserProfile`.
    * Timestamps (`createdAt`, `lastLoginAt`) are normalized to UTC when available.
* **`AuthSession`** – aggregate (account + tokens + status) if you ever expand to token-based backends. For Firebase-only you’ll mostly use `AuthAccount`.

## `entities/auth_failures.dart`

Freezed union for **typed failures** you can use in result types or to map Firebase errors to UX messages:
`invalidCredentials`, `userDisabled`, `emailNotVerified`, `tokenExpired`, `networkIssue`, `serverIssue`, `unknown`.

> Run codegen whenever you edit entities or failures:
>
> ```bash
> flutter pub run build_runner build -d
> ```

## `repositories/auth_repository.dart`

Domain contract the app talks to. It abstracts Firebase details:

* `Stream<AuthAccount?> authState()` – emits the current account or `null` on sign-out.
* `registerWithEmail(...)` – email optional, password required in UI; anonymous fallback when email omitted.
* `loginWithEmail(...)` – standard email/password login.
* `loginAnonymous(...)` *(optional extension)* – direct anonymous flow.
* `linkEmailPassword(...)` – link credentials to an anonymous account later.
* `signOut()` – sign out of Firebase.
* `ensureUserProfile(...)` – creates/merges a `UserProfile` document in Firestore.

## `usecase/`

Thin wrappers to keep UI simple and match your Reservations-style structure:

* **`register_with_email.dart`** – calls `AuthRepository.registerWithEmail`. Uses **Riverpod 2.x** (`Ref`) internally.
* **`login_with_email.dart`** – calls `AuthRepository.loginWithEmail`.

> These expose providers you can `read/watch` from UI or blocs:
>
> * `registerWithEmailUC`
> * `loginWithEmailUC`

---

# Data Layer

## `datasources/auth_remote_ds.dart`

Low-level gateway to Firebase Auth + Firestore.

* **Auth**:

    * `onAuthState()` – `FirebaseAuth.instance.authStateChanges()`
    * `createEmailUser(email, password)` – `createUserWithEmailAndPassword`
    * `loginEmail(email, password)` – `signInWithEmailAndPassword`
    * `loginAnonymous()` – `signInAnonymously`
    * `sendEmailVerification(user)` – sends verification if not verified
    * `linkEmailPassword(email, password)` – link credentials to current user
    * `signOut()` – sign out
* **Firestore (collection: `user_profiles`)**:

    * `_profileDoc(uid)` – reference helper
    * `upsertProfile(uid, payload)` – create/merge profile document
    * `getProfile(uid)` – fetch profile json for mapping

## `mappers/auth_mappers.dart`

Pure functions to transform **Firebase `User` → `AuthAccount`**:

* Computes provider set from `user.providerData` and `isAnonymous`.
* Carries over `displayName`, `photoURL`, verification flags, timestamps.
* Sets `profileId = uid` to keep `UserProfile` mapping 1:1.

## `mappers/user_profile_mappers.dart`

Minimal mapping between the **`UserProfile` domain entity** and Firestore payload used **during auth**. Cross-feature refs are initialized to **empty arrays** and are meant to be populated by their respective features later.

* `userProfileToFirestore(UserProfile)` – writes the basic fields and empty arrays.
* `firestoreToUserProfile(Map<String, dynamic>)` – returns a `UserProfile` with **typed empty lists** to avoid `List<dynamic>` issues.

## `repositories/auth_repository_impl.dart`

Concrete implementation that composes the datasource + mappers.

* **`authState()`** – maps `User?` from Firebase to `AuthAccount?` via `authAccountFromFirebaseUser`.
* **`registerWithEmail(...)`**

    1. If **email omitted** → `signInAnonymously()` → `_ensureProfile(...)` with required fields.
    2. If **email provided** → `createUserWithEmailAndPassword` → `sendEmailVerification` → `_ensureProfile(...)`.
    3. Return `AuthAccount` for the resulting Firebase user.
* **`loginWithEmail(...)`** – `signInWithEmailAndPassword` → map to `AuthAccount`.
* **`loginAnonymous(...)`** *(optional)* – same as the anonymous branch in register.
* **`linkEmailPassword(...)`** – use when upgrading anonymous accounts.
* **`ensureUserProfile(...)`** – external API; internally calls `_ensureProfile` and then re-reads the profile to return a `UserProfile` domain entity.

> Providers exposed here (used by use cases/controllers):
>
> * `firebaseAuthProvider` – `FirebaseAuth.instance`
> * `firestoreProvider` – `FirebaseFirestore.instance`
> * `authRemoteProvider` – `AuthRemoteDataSource`
> * `authRepositoryProvider` – `AuthRepository` (bound to `AuthRepositoryImpl`)

---

# Presentation Layer

## `screens/auth_gate.dart`

The **entry point** for routing. It listens to `FirebaseAuth.instance.authStateChanges()` and shows:

* **`SignUpPage`** when `user == null`.
* **`DemoPage`** (your main app) when `user != null`.

> If you want to **require email verification**:
>
> ```dart
> if (user != null) {
>   if (user.isAnonymous) return const DemoPage();
>   if (user.emailVerified) return const DemoPage();
>   return const VerifyEmailPage();
> }
> ```

## `screens/signup_page.dart`

Form that collects **first name, last name, phone (required)**, **email (optional)**, and **password**. On submit it calls **`registerWithEmailUC`**:

* If **email provided** → creates an email/password Firebase user, sends verification, creates/merges `user_profiles/{uid}`.
* If **email omitted** → signs in anonymously and still creates/merges `user_profiles/{uid}`.
* No manual navigation; `AuthGate` reacts to the auth stream and opens `DemoPage`.

## `screens/login_page.dart`

Simple email/password login that calls **`loginWithEmailUC`**. On success, `AuthGate` will route to `DemoPage`.

## `bloc/signup/`

An optional **Bloc/Cubit** (`AuthSignUpCubit`, `AuthSignUpState`) that wraps the submit lifecycle (`idle → submitting → success/error`). UI can use this or call the use case directly—both are supported.

## `controllers/auth_controller.dart`

Riverpod-facing convenience providers for the rest of the app:

* **`authAccountProvider`** – `StreamProvider<AuthAccount?>` from repository’s `authState()`.
* **`currentProfileIdProvider`** – reads `authAccountProvider` and exposes `profileId` (UID) for other features.

> Example: pass real user id into Reservations once authenticated:
>
> ```dart
> final uid = ref.watch(currentProfileIdProvider);
> if (uid != null) {
>   final userId = UserId.create(uid);
>   return ReservationsListScreen(userId: userId);
> }
> return const Center(child: Text('Please sign in.'));
> ```

---

# Data Flow – End to End

## Registration (email provided)

1. UI validates form → `registerWithEmailUC`.
2. Repo → `createUserWithEmailAndPassword` → `sendEmailVerification`.
3. Repo ensures **`user_profiles/{uid}`** exists (first/last/phone/email… empty arrays for cross-feature refs).
4. `authState()` emits new Firebase user → `AuthGate` shows **`DemoPage`**.

## Registration (email omitted → anonymous)

1. UI validates form (first/last/phone/password still collected for a consistent UX).
2. Repo → `signInAnonymously()`.
3. Repo writes **`user_profiles/{uid}`** with email `null`.
4. `AuthGate` routes to **`DemoPage`**. You can later **link email/password** from Profile.

## Login (email/password)

1. UI → `loginWithEmailUC` → `signInWithEmailAndPassword`.
2. `authState()` emits user → `AuthGate` shows **`DemoPage`**.

## Linking email/password later (upgrading anonymous)

* Call `AuthRepository.linkEmailPassword(email, password)` from a Profile/Settings screen.
* Repo links credentials and sends verification email.

---

# Firestore Schema (Auth-created profile)

Collection: **`user_profiles`**, Document ID: **`{uid}`**

```json
{
  "id": "{uid}",
  "firstName": "...",
  "lastName": "...",
  "contactNumber": "...",
  "email": "user@example.com" | null,
  "avatarUrl": null,
  "addressRefs": [],
  "walletRef": null,
  "reservationRefs": [],
  "paymentMethodRefs": [],
  "orderRefs": [],
  "favoriteRefs": [],
  "discountRefs": [],
  "isEmailVerified": false,
  "isPhoneVerified": false,
  "createdAt": <serverTimestamp>,
  "updatedAt": <serverTimestamp>,
  "roleMetadata": {}
}
```

> Cross-feature refs are intentionally **empty arrays** on creation. Those lists should be managed by their own features to prevent auth from bleeding into other modules.

---

# Integration & Setup

1. **Dependencies** (already used in the project):

    * `firebase_core`, `firebase_auth`, `cloud_firestore`
    * `flutter_riverpod`
    * `freezed`, `freezed_annotation`, `build_runner`

2. **Firebase initialization** (already in `main.dart`):

   ```dart
   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   ```

3. **MaterialApp home** → `AuthGate`:

   ```dart
   return MaterialApp(
     // ...
     home: const AuthGate(),
   );
   ```

4. **Code generation** (whenever you edit Freezed files):

   ```bash
   flutter pub run build_runner build -d
   ```

5. **Dev reset trick** (to re-show SignUp during development):

   ```dart
   const _resetAuth = bool.fromEnvironment('RESET_AUTH', defaultValue: false);
   if (_resetAuth) {
     final auth = FirebaseAuth.instance;
     final u = auth.currentUser;
     if (u != null) {
       if (u.isAnonymous) { await u.delete(); } else { await auth.signOut(); }
     }
   }
   // Run with: flutter run --dart-define=RESET_AUTH=true
   ```

---

# Error Handling & UX Messages

* Firebase exceptions are mapped to friendly messages inside the repository (or a helper) so UI shows concise hints (e.g., `email-already-in-use`, `weak-password`, `network-request-failed`).
* For sign-up, a success Snackbar clarifies whether a verification email was sent or the account was created anonymously.

---

# Security Notes

* **Passwords** are never stored or serialized in our domain/data models.
* If you persist tokens later, use **secure storage**. Current Firebase-only setup doesn’t require custom token storage.
* Avoid logging raw Firebase errors or user PII in production logs.

---

# Extension Points

* **Require email verification** before `DemoPage`.
* **Phone OTP** sign-in flow (Firebase Phone Auth) and set `isPhoneVerified`.
* **Social providers** (Google/Apple) → add to `AuthProvider` and map in `auth_mappers.dart`.
* **DTO layer** for auth (if you move away from Firebase or need local caching) – optional and easy to add without changing UI.

---

# Quick Reference (Common Providers)

* `authRepositoryProvider` – Repo instance.
* `registerWithEmailUC` / `loginWithEmailUC` – Use cases for UI.
* `authAccountProvider` – `StreamProvider<AuthAccount?>` with the current account.
* `currentProfileIdProvider` – exposes the authenticated profile/user ID (UID) for feature screens.

---

# FAQ

**Q: Why no separate Auth model class?**
A: Firebase’s `User` already serves as the data source model. We map it to domain `AuthAccount` directly, keeping the stack thin and secure. A DTO can be added later if we need caching or backends beyond Firebase.

**Q: How does Reservations get the correct user ID?**
A: Read `currentProfileIdProvider` and construct your `UserId` VO: `UserId.create(uid)`. Pass that to `ReservationsListScreen`.

**Q: Where do profile fields live?**
A: In Firestore under `user_profiles/{uid}`. Auth writes the minimal record at sign-up/login; feature modules own their respective lists/refs.

---

That’s it! This README is meant to onboard a new contributor quickly and align them with the project’s layered structure and conventions. Copy/paste freely into `features/auth/README.md`.

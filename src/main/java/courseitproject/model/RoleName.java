package courseitproject.model;

/**
 * Centralized enum for all role names in the system.
 * Use this instead of hardcoded strings like "ADMIN", "STUDENT", etc.
 *
 * Usage:
 *   RoleName.ADMIN.name()           → "ADMIN"
 *   RoleName.ADMIN.matches(str)     → case-insensitive check
 *   RoleName.fromString("admin")    → RoleName.ADMIN (or null)
 */
public enum RoleName {
    ADMIN,
    STUDENT,
    TEACHER,
    USER;

    /** Case-insensitive match against a String (e.g. from DB or session) */
    public boolean matches(String value) {
        return this.name().equalsIgnoreCase(value);
    }

    /** Safely parse a string to RoleName, returns null if invalid */
    public static RoleName fromString(String value) {
        if (value == null) return null;
        try {
            return RoleName.valueOf(value.toUpperCase());
        } catch (IllegalArgumentException e) {
            return null;
        }
    }
}

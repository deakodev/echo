#ifndef ECHO_H
#define ECHO_H

//////// Public /////////

// Logs a formatted message at the specified severity level.
// These functions behave similar to printf and support format strings.
// Example usage: echo_warn("Disk nearly full: %d%% used", 95);
void echo_trace(const char *fmt, ...);
void echo_info(const char *fmt, ...);
void echo_warn(const char *fmt, ...);
void echo_error(const char *fmt, ...);
void echo_fatal(const char *fmt, ...);


//////// Internal /////////

// Forward declaration
typedef enum Level Level;

// Callback to echo ocaml log function eg. echo_trace etc
typedef void (*echo_cb)(const char *msgf);

void echo_register(Level level, echo_cb cb);

#endif /* ECHO_H */

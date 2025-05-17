#ifndef ECHO_H
#define ECHO_H

typedef enum {
    Trace = 0,
    Info,
    Warn,
    Error,
    Fatal,
    Level_Count
} Level;

// Callback to echo ocaml log function eg. echo_trace etc
typedef void (*echo_cb)(const char *msgf);

// Tuple like struct to map Level to echo callback
typedef struct {
    Level level;
    echo_cb cb;
} LevelCallback;

void echo_register(Level level, echo_cb cb);

void echo_trace(const char *fmt, ...);
void echo_info(const char *fmt, ...);
void echo_warn(const char *fmt, ...);
void echo_error(const char *fmt, ...);
void echo_fatal(const char *fmt, ...);

#endif /* ECHO_H */
